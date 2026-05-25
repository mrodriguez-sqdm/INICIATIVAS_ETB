%dw 2.0
output application/json

var gateway = vars.requestGateway default {}
var firstDetailRef = (vars.payloadOri.references default [])[0]
var sapi = vars.sapiResponse.data default {}
var refs = vars.payloadOri.references default []

var descripcionConcatenada =
    (refs
        map ($.description default "")
        filter ($ != "")
    ) joinBy ", "

---
{
	id_transaccion: vars.payloadOri.transactionId,

	CUS: sapi.id default "",

	atributos_pasarela: {
		pasarela: vars.payloadOri.gateway.gatewayName,
		tipo_pasarela: vars.payloadOri.gateway.paymentFlow
	},

	metodo_pago: sapi.paymentMethodType default "",

	referencias: {
		referencia: gateway.reference default "",
		descripcion: descripcionConcatenada default "",
		moneda: gateway.currency default "",
		valor_pagar: ((gateway.amount_in_cents default 0) / 100) as String,

		impuestos:
			(sapi.taxes default [])
			map (t) -> {
				tipo: t."type" default "",
				valor: ((t.amount_in_cents default 0) / 100) as String
			},

		detalle_referencias:
			(vars.payloadOri.references default [])
			map (r) -> {
				referencia: r.reference default "",
				descripcion: r.description default "",
				moneda: r.currency default "",
				valor_pagar: (r.totalAmount default 0) as String,
				impuestos: [],
				atributos:
					(r.attributes default [])
					map (a) -> {
						atributo: a.attribute default "",
						valor: a.value default ""
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

	concepto: firstDetailRef.description default "",

	entidad_bancaria: vars.payloadOri.paymentMethod.bank default "ENTIDAD BANCARIA",

	estado_transaccion: sapi.status default "CREATED",

	fecha_registro: sapi.createdAt default "",

	fecha_respuesta_pasarela:
		now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},

	fecha_actualizacion:
		now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}
}