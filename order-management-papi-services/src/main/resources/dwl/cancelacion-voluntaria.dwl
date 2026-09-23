%dw 2.0
output application/json

fun resultado(id: String, condicionValida: Boolean, mensajeValido: String, mensajeInvalido: String) = {
	evaluateId: id,
	isValid: condicionValida,
	detail: if (condicionValida) mensajeValido else mensajeInvalido
}
---
[
	resultado("Campo_Estado_Principal_Activo",
		upper(record.Estado default "") != "INACTIVO",
		"El servicio no esta inactivo, se puede continuar con la cancelacion",
		"El servicio a cancelar ya esta inactivo"),
	
    resultado("Relacion_Cliente_Servicio",
		record.Numero_Identificacion == vars.requestOrder.customer.documentNumber and record.Tipo_Documento == vars.requestOrder.customer.documentType,
		"El cliente si esta asociado al servicio enviado",
		"El cliente no esta asociado al servicio enviado")
]