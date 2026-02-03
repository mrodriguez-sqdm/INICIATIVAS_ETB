// Date formats allowed for this function are '25/10/2022 4:04:50 p. m.' and '18/10/2022'
fun formatDate (fecha) = if ( sizeOf(fecha) == 10 ) (fecha as Date {format: 'dd/MM/yyyy'} as String {format: 'yyyy-MM-dd'}) ++ "T00:00:00.000+0000"
    else do {
        var fechaFormateada = (fecha replace ("p. m.") with ("PM")) replace ("a. m.") with ("AM")
        var fecha = splitBy(fechaFormateada," ")[0] as Date {format: 'dd/MM/yyyy'} as String {format: 'yyyy-MM-dd'}
        var hora = splitBy(fechaFormateada," ")[1]
        var ampm = splitBy(fechaFormateada," ")[2]
        ---
            if(ampm == "AM")
                fecha ++ "T" ++ (splitBy(hora,":")[0] as Number as String {format:'00'}) ++ ":" ++ splitBy(hora,":")[1] ++ ":" ++  splitBy(hora,":")[2] ++ ".000+0000"
        else fecha ++ "T" ++ (splitBy(hora,":")[0] + 12) ++ ":" ++ splitBy(hora,":")[1] ++ ":" ++  splitBy(hora,":")[2] ++ ".000+0000"
    }