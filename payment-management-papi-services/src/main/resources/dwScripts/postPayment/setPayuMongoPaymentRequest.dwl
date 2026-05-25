%dw 2.0
output application/json

var firstDetailRef = (vars.payloadOri.references default [])[0]
var gatewayOrder = vars.requestGateway.order default {}
var gatewayAdditionalValues = gatewayOrder.additionalValues default {}

var taxMap = {
	"TX_TAX": "IVA",
	"TX_TAX_RETURN_BASE": "BASE_GRAVABLE"
}

---
{
	id_transaccion: vars.payloadOri.transactionId,
	CUS: vars.sapiResponse.data.transactionId default "",

	atributos_pasarela: {
		pasarela: vars.payloadOri.gateway.gatewayName,
		tipo_pasarela: vars.payloadOri.gateway.paymentFlow
	},

	metodo_pago: vars.payloadOri.paymentMethod."type" default "",

	referencias: {
		referencia: gatewayOrder.referenceCode default "",
		descripcion: gatewayOrder.description default "",
		moneda: gatewayAdditionalValues.TX_VALUE.currency default "",
		valor_pagar: (gatewayAdditionalValues.TX_VALUE.value default 0) as String,

		impuestos:
			(gatewayAdditionalValues default {})
				pluck ((v, k) ->
					if (taxMap[k]?)
						{
							tipo: taxMap[k],
							valor: (v.value default 0) as String
						}
					else null
				)
				filter ($ != null),

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
		tipo_documento: vars.payloadOri.customer.documentType default "CC",
		numero_documento: vars.payloadOri.customer.documentNumber default "",
		nombre_completo: vars.payloadOri.customer.fullName default "",
		correo: vars.payloadOri.customer.email default "",
		telefono: vars.payloadOri.customer.phoneNumber default ""
	},

	concepto: firstDetailRef.description default gatewayOrder.description default "",

	entidad_bancaria: vars.payloadOri.paymentMethod.bank default "ENTIDAD BANCARIA",

	estado_transaccion: vars.sapiResponse.data.state default "CREATED",

	fecha_registro:
		(vars.sapiResponse.data.operationDate default 0)
			as DateTime { unit: "milliseconds" }
			as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" },

	fecha_respuesta_pasarela:
		now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" },

	fecha_actualizacion:
		now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" }
}