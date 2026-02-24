%dw 2.0
output application/json
---
{
	id_transaccion: vars.payloadOri.transactionId,
	CUS: vars.sapiResponse.data.transactionId default "",
	pasarela: "payu",
	atributos_pasarela: vars.sapiResponse.data >> [],
	referencia_pago: vars.payloadOri.reference >> [],
	tipo_documento: vars.payloadOri.customer.document."type" default "CC",
	numero_documento: vars.payloadOri.customer.document.number default "",
	valor_impuesto: ((vars.payloadOri.taxes filter $.code == "IVA")[0].value default 0) as String,
	valor_pagar: (vars.payloadOri.amount default (sum(vars.payloadOri.taxes.value) default 0)) as String,
	concepto: vars.payloadOri.description,
	entidad_bancaria: vars.payloadOri.paymentMethod.bank default "ENTIDAD BANCARIA",
	pasarela_tipo: vars.paymentMethod,
	estado_transaccion: vars.sapiResponse.data.state,
	estado_tx: "PENDIENTE",
	estados: (vars.estados default []) << {
		estado_transaccion: vars.sapiResponse.data.state,
		estado_tx: "PENDIENTE",
		fecha: now() as String {
			format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		}
	},
	fecha_registro: (vars.sapiResponse.data.operationDate default 0)
              as DateTime {
		unit: "milliseconds"
	}
              as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	},
	fecha_respuesta_pasarela: now() as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	},
	fecha_actualizacion: now() as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	}
}