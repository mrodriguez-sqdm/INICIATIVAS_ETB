%dw 2.0
output application/json

var firstDetailRef = (vars.payloadOri.references default [])[0]
var gatewayOrder = vars.requestGateway.order default {}
var gatewayAdditionalValues = gatewayOrder.additionalValues default {}

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
		impuestos: [
			{
				tipo: "IVA",
				valor: (gatewayAdditionalValues.TX_TAX.value default 0) as String
			}
		],
		detalle_referencias:
			(vars.payloadOri.references default [])
			map (r) -> {
				referencia: r.invoiceNumber default r.reference default "",
				descripcion: r.description default "",
				moneda: r.currency default "",
				valor_pagar: (r.totalAmount default 0) as String,
				impuestos:
					(r.taxes default [])
					filter ((t) -> (t."type" default "") != "BASE_GRAVABLE")
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

	estado_transaccion: vars.sapiResponse.data.state default "PENDIENTE",

	fecha_registro:
		(vars.sapiResponse.data.operationDate default 0)
			as DateTime { unit: "milliseconds" }
			as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" },

	fecha_respuesta_pasarela:
		now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" },

	fecha_actualizacion:
		now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" }
}