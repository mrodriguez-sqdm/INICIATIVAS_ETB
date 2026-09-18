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
	(valor default "") ~= true
	
// Vigente si la diferencia entre hoy y la fecha_consulta del score es <= 30 dias
fun scoreVigente(scoreObj) =
    do {
        var fechaHoy = (now() >> "UTC-5") as Date
        var fechaScore = scoreObj.Fecha as Date {format: "yyyy-MM-dd"}
        ---
        (fechaHoy - fechaScore) as Number {unit: "days"} <= 30
    }

// Formatos de Fechas    
fun parseFechaFlexible(valor) =
    if (isEmpty(valor)) "0001-01-01T00:00:00.000Z"
    else
        (
            if (valor matches /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(\.\d+)?Z?$/)
                valor as String  // ya viene en formato ISO completo, se deja tal cual
            else if (valor matches /^\d{4}-\d{2}-\d{2}$/)
                ((valor as Date {format: "yyyy-MM-dd"}) as String {format: "yyyy-MM-dd"}) ++ "T00:00:00.000Z"
            else if (valor matches /^\d{2}\/\d{2}\/\d{4}$/)
                ((valor as Date {format: "dd/MM/yyyy"}) as String {format: "yyyy-MM-dd"}) ++ "T00:00:00.000Z"
            else
                "0001-01-01T00:00:00.000Z"
        )