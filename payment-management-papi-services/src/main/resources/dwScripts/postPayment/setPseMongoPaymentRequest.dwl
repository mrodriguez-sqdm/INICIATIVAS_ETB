
%dw 2.0
output application/json
---
{
	id_transaccion: vars.payloadOri.correlatorId,
	CUS: vars.sapiResponse.trazabilityCode,
	pasarela: "pse",
	atributos_pasarela: vars.sapiResponse >> [],
	referencia_pago: vars.payloadOri.reference  >> [],
	tipo_documento: vars.payloadOri.customer.document."type" default "CC",
	numero_documento: vars.payloadOri.customer.document.number default "",
	valor_pagar: vars.payloadOri.amount as String,
	valor_impuesto: sum(vars.payloadOri.taxes.value) as String,
	concepto: vars.payloadOri.description,
	entidad_bancaria: vars.payloadOri.paymentMethod.bank.name default "ENTIDAD BANCARIA",
	pasarela_tipo: vars.paymentMethod,
	estado_transaccion: vars.sapiResponse.returnCode,
	estado_tx: "PENDIENTE",
	estados: (vars.estados default []) << {
		estado_transaccion: vars.sapiResponse.returnCode,
		estado_tx: "PENDIENTE",
		fecha: now() as String {
			format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
		}
	},
	fecha_registro: now() as DateTime {
		unit: "milliseconds"
	} as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	},
	fecha_respuesta_pasarela: now() as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	},
	fecha_actualizacion: now() as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	}
}