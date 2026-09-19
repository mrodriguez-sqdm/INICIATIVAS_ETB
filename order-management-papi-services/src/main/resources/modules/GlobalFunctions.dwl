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
        
fun homologarAccion(tipoTramite) =
    tipoTramite match {
        case "VTA" -> "ADD"
        case "TESR" -> "DELETE"
        case "TRAMITE LTE" -> "DELETE"
        else -> null
    }

fun enriquecerAtributos(atributos: Array, catalogo: Array): Array =
    atributos map (attr) -> {
        Nombre: attr.Nombre,
        Valor: attr.Valor,
        Tipo: attr.Tipo,
        Clase: (catalogo filter ($.Nombre == attr.Nombre))[0].Clase_Atributo default "",
        Nuevo: true,
        Display: 0
    }
    
fun valorODefecto(valor: Any, porDefecto: Any): Any =
    if (valor != null and valor != "") valor else porDefecto

fun homologarCobertura(cobertura: Object): Object = {
    Tipo_Cobertura: valorODefecto(cobertura.Tipo_Cobertura, ""),
    Codigo_Lote: valorODefecto(cobertura.Codigo_Lote, ""),
    Localidad: valorODefecto(cobertura.Localidad, ""),
    Estrato: valorODefecto(cobertura.Estrato, 0),
    Latitud: valorODefecto(cobertura.Latitud, 0),
    Longitud: valorODefecto(cobertura.Longitud, 0),
    Direccion_GIS: valorODefecto(cobertura.Direccion_GIS, ""),
    NombreCobertura: valorODefecto(cobertura.NombreCobertura, ""),
    Olt: valorODefecto(cobertura.Olt, ""),
    Propietario: valorODefecto(cobertura.Propietario, ""),
    Proposito: valorODefecto(cobertura.Proposito, ""),
    Tecnologia: valorODefecto(cobertura.Tecnologia, ""),
    Zona: valorODefecto(cobertura.Zona, ""),
    TipoDistancia: valorODefecto(cobertura.TipoDistancia, ""),
    TipoDistancia2: valorODefecto(cobertura.TipoDistancia2, null),
    Distrito: valorODefecto(cobertura.Distrito, null),
    Molecula: valorODefecto(cobertura.Molecula, null),
    Viable: valorODefecto(cobertura.Viable, false)
}

fun homologarDireccion(direccion: Object): Object = {
    Id_Direccion: valorODefecto(direccion.Id_Direccion, 0),
    Direccion_Normalizada: valorODefecto(direccion.Direccion_Normalizada, ""),
    Tipo_Direccion: valorODefecto(direccion.Tipo_Direccion, ""),
    Codigo_Direccion: valorODefecto(direccion.Codigo_Direccion, ""),
    Codigo_Departamento: valorODefecto(direccion.Codigo_Departamento, ""),
    Codigo_Municipio: valorODefecto(direccion.Codigo_Municipio, ""),
    Codigo_Pais: valorODefecto(direccion.Codigo_Pais, ""),
    Nombre_Direccion: valorODefecto(direccion.Nombre_Direccion, null),
    Departamento: valorODefecto(direccion.Departamento, ""),
    Municipio: valorODefecto(direccion.Municipio, ""),
    Estado: valorODefecto(direccion.Estado, ""),
    Seleccionada: valorODefecto(direccion.Seleccionada, false),
    Cobertura: homologarCobertura(direccion.Cobertura default {})
}

fun homologarDirecciones(direcciones: Array): Array =
    direcciones map (direccion) -> homologarDireccion(direccion)