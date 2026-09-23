%dw 2.0
output application/json

fun resultado(id: String, condicionValida: Boolean, mensajeValido: String, mensajeInvalido: String) = {
	evaluateId: id,
	isValid: condicionValida,
	detail: if (condicionValida) mensajeValido else mensajeInvalido
}
---
[	
    resultado("Relacion_Cliente_Servicio",
		record.Numero_Identificacion == vars.requestOrder.customer.documentNumber and record.Tipo_Documento == vars.requestOrder.customer.documentType,
		"El cliente si esta asociado al servicio enviado",
		"El cliente no esta asociado al servicio enviado")
]