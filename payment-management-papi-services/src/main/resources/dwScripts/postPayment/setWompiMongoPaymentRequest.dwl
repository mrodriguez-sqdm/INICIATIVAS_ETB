%dw 2.0
output application/json
---
{
	id_transaccion: vars.payloadOri.correlatorId,
	CUS: vars.sapiResponse.data.id,
	pasarela: "wompi",
	atributos_pasarela: vars.sapiResponse.data >> [],
	referencia_pago: vars.sapiResponse.data.sku >> [],
	tipo_documento: vars.payloadOri.customer.document."type" default "CC",
	numero_documento: vars.payloadOri.customer.document.number default "",
	valor_pagar: vars.payloadOri.amount as String,
	valor_impuesto: sum(vars.payloadOri.taxes.value) as String,
	concepto: vars.payloadOri.description,
	entidad_bancaria: vars.payloadOri.paymentMethod.bank.name default '',
	pasarela_tipo: vars.paymentMethod,
	estado_transaccion: "PENDIENTE",
	estado_tx: "PENDIENTE",
	estados: [{
		estado_transaccion: vars.sapiResponse.data.active,
		estado_tx: "PENDIENTE",
		fecha: now() as String {
			format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		}
	}],
	fecha_registro: vars.sapiResponse.data.createdAt,
	fecha_respuesta_pasarela: now() as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	},
	fecha_actualizacion: now() as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	}
}