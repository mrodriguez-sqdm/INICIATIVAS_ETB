%dw 2.0

/*********************************************************************************************
** Modulo para implementar funciones globales para la API order-management-papi-services (v1)*
**********************************************************************************************/

//Función que entrega la fecha con un formato dd/MM/yyyy HH:mm:ss
fun fechaActual() = (now() >> "UTC-5") as String {format: "dd/MM/yyyy HH:mm:ss"}

//Función que entrega la fecha con un formato dd/MM/yyyy yyyy-MM-dd'T'HH:mm:ss.SSS'Z'
fun fechaMongo() = {"\$date": (now() >> "UTC-5") as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}}

//Wrapper común: empaqueta el resultado de cualquier validación
fun resultado(id: String, condicionValida: Boolean, mensajeValido: String, mensajeInvalido: String) = {
	evaluateId: id,
	isValid: condicionValida,
	detail: if (condicionValida) mensajeValido else mensajeInvalido
}

//Regla que valida que el campo de entrada este poblado
fun poblado(valor: Any) = not (isEmpty(valor default "") or valor == null)

//Regla que valida que el campo sea true
fun esTrue(valor: Any) =
	(valor default "") as String {caseSensitive: false} == "true"
	
// Vigente si la diferencia entre hoy y la fecha_consulta del score es <= 30 dias
fun scoreVigente(scoreObj: Any) =
	(scoreObj != null)
		and poblado(scoreObj.fecha_consulta)
		and ((hoy - (scoreObj.fecha_consulta as Date {format: "yyyy-MM-dd"})) as Number {unit: "days"}) <= 30