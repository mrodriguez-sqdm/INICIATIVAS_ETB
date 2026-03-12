%dw 2.0
output application/json

var gateway = vars.requestGateway default {}
var firstDetailRef = (vars.payloadOri.references default [])[0]

---
{
	id_transaccion: vars.payloadOri.transactionId,
	CUS: vars.sapiResponse.data.id default "",

	atributos_pasarela: {
		pasarela: vars.payloadOri.gateway.gatewayName,
		tipo_pasarela: vars.payloadOri.gateway.paymentFlow
	},

	metodo_pago: vars.payloadOri.paymentMethod."type" default "",

	referencias: {
		referencia: gateway.reference default "",
		descripcion: gateway.description default "",
		moneda: gateway.currency default "",
		valor_pagar: ((gateway.amount_in_cents default 0) / 100) as String,

		impuestos:
			(gateway.taxes default [])
			map (t) -> {
				tipo:
					if (t."type" == "VAT") "IVA"
					else if (t."type" == "CONSUMPTION") "CONSUMO"
					else t."type",
				valor: ((t.amount_in_cents default 0) / 100) as String
			},

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
						tipo: t."type",
						valor: (t.value default 0) as String
					}
			}
	},

	cliente: {
		tipo_documento: vars.payloadOri.customer.documentType default "CC",
		numero_documento: vars.payloadOri.customer.documentNumber default "",
		nombre_completo: vars.payloadOri.customer.fullName default "",
		correo: vars.payloadOri.customer.email default "",
		telefono: vars.payloadOri.customer.phoneNumber default ""
	},

	concepto: gateway.description default "",

	entidad_bancaria: vars.payloadOri.paymentMethod.bank default "ENTIDAD BANCARIA",

	estado_transaccion: "PENDIENTE",

	fecha_registro: vars.sapiResponse.data.createdAt default "",

	fecha_respuesta_pasarela:
		now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},

	fecha_actualizacion:
		now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}
}