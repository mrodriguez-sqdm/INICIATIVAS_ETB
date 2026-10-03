%dw 2.0

/****************************************************************************************
** Modulo para implementar funciones globales para la API cusomer-papi-services-v2 (v1)**
****************************************************************************************/

//Función que toma distintos formatos de fecha y normaliza para entregar un único formato dd/MM/yyyy
fun formatDate(value) =
    if ( isEmpty(value) ) ""
    else if ( (value as String) matches /^\d{2}\/\d{2}\/\d{4}$/ ) value as String
    else if ( (value as String) matches /^\d{2}-\d{2}-\d{4}$/ ) ((value as String) as Date {
	format: "dd-MM-yyyy"
})
            as String {
	format: "dd/MM/yyyy"
}
    else if ( (value as String) matches /^\d{4}-\d{2}-\d{2}.*$/ ) ((value as String)[0 to 9] as Date {
	format: "yyyy-MM-dd"
})
            as String {
	format: "dd/MM/yyyy"
}
    else
        ""