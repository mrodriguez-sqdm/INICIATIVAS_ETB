%dw 2.0
/****************************************************************************************
 * * Modulo para implementar funciones globales para la API cusomer-papi-services-v2 (v1)**
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

//Función que toma distintos formatos de fecha y normaliza para entregar un único formato (ISO con milisegundos y zona) yyyy-MM-ddTHH:mm:ss.SSS-05:00
fun formatDateToISO8601(value) =
  if ( isEmpty(value) ) ""
  else do {
	var inputV = value as String
	var datePart =
      if ( inputV matches /^\d{2}\/\d{2}\/\d{4}$/ ) (inputV as Date {
		format: "dd/MM/yyyy"
	}) as String {
		format: "yyyy-MM-dd"
	}
      else if ( inputV matches /^\d{2}-\d{2}-\d{4}$/ ) (inputV as Date {
		format: "dd-MM-yyyy"
	}) as String {
		format: "yyyy-MM-dd"
	}
      else if ( inputV matches /^\d{4}-\d{2}-\d{2}.*$/ ) inputV[0 to 9]
      else
        ""
	var timePart =
      if ( inputV matches /^\d{4}-\d{2}-\d{2}T\d{2}(:\d{2})?(:\d{2})?(\.\d{1,3})?(Z|[+-]\d{2}:\d{2})?$/ ) do {
		var time = (inputV splitBy "T")[1]
		var cleanTime = (time splitBy /Z|[+-]\d{2}:\d{2}$/)[0]
		var parts = cleanTime splitBy ":"
		var hours = parts[0]
		var minutes = if ( sizeOf(parts) > 1 ) parts[1] else "00"
		var secondsPart = if ( sizeOf(parts) > 2 ) parts[2] else "00"
		var seconds = (secondsPart splitBy ".")[0]
		var milliseconds =
            if ( secondsPart contains "." ) ((secondsPart splitBy ".")[1] ++ "000")[0 to 2]
            else
              "000"
		---
		hours ++ ":" ++ minutes ++ ":" ++ seconds ++ "." ++ milliseconds
	}
      else
        "00:00:00.000"
	---
	if ( datePart == "" ) ""
    else
      datePart ++ "T" ++ timePart ++ "-05:00"
}
