%dw 2.0
output application/json

var firstDetailRef = (vars.payloadOri.references default [])[0]
var gateway = vars.requestGateway default {}
var sapi = vars.sapiResponse default {}

---
{
	id_transaccion: vars.payloadOri.transactionId,
	CUS: sapi.trazabilityCode default "",

	atributos_pasarela: {
		pasarela: vars.payloadOri.gateway.gatewayName,
		tipo_pasarela: vars.payloadOri.gateway.paymentFlow
	},

	metodo_pago: vars.payloadOri.paymentMethod."type" default "",

	referencias: {
		referencia: gateway.referenceNumber1 default "",
		descripcion: gateway.paymentDescription default "",
		moneda: firstDetailRef.currency default "",
		valor_pagar: (gateway.transactionValue default 0) as String,

		impuestos: [
			{
				tipo: "IVA",
				valor: (gateway.vatValue default 0) as String
			}
		],

		detalle_referencias:
			(vars.payloadOri.references default [])
			map (r) -> {
				referencia: r.reference default "",
				descripcion: r.description default "",
				moneda: r.currency default "",
				valor_pagar: (r.totalAmount default 0) as String,
				impuestos:
					(r.taxes default [])
					map (t) -> {
						tipo: t."type" default "",
						valor: (t.value default 0) as String
					}
			}
	},

	cliente: {
		tipo_documento: vars.payloadOri.customer.documentType,
		numero_documento: vars.payloadOri.customer.documentNumber default "",
		nombre_completo: vars.payloadOri.customer.fullName default "",
		correo: vars.payloadOri.customer.email default "",
		telefono: vars.payloadOri.customer.phoneNumber default ""
	},

	concepto: firstDetailRef.description default gateway.paymentDescription default "",

	entidad_bancaria: vars.payloadOri.paymentMethod.pse.financialInstitutionCode default "ENTIDAD BANCARIA",

	estado_transaccion: sapi.returnCode default "CREATED",

	fecha_registro:
		(gateway.soliciteDate default now())
			as DateTime
			as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" },

	fecha_respuesta_pasarela:
		now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" },

	fecha_actualizacion:
		now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" }
}