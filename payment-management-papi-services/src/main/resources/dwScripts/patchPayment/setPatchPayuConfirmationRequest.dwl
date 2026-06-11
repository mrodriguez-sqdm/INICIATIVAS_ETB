%dw 2.0
output application/json

fun fechaHoraColombia() =
    ((now() >> "America/Bogota") as String {
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    })

fun getEstadoPayu(statePol, responseCodePol) =
    do {
        var state = statePol as String
        var code = responseCodePol as String
        ---
        if (
            (["7", "12", "14"] contains state) and
            (["9994", "9995", "9996", "9999", "25"] contains code)
        )
            "EN_PROCESO"
        else if (state == "4" and code == "1")
            "PAGADA"
        else if (
            state == "6" and
            (["5", "8", "9", "12", "19", "9991"] contains code)
        )
            "RECHAZADA"
        else if (
            state == "6" and
            (["28", "35"] contains code)
        )
            "RECHAZADA"
        else if (
            state == "104" and
            (["9998", "1006", "1007"] contains code)
        )
            "RECHAZADA"
        else if (state == "5" and code == "9997")
            "RECHAZADA"
        else
            "NO_CONCILIADA"
    }
---
{
	estado: getEstadoPayu(
              payload.state_pol,
              payload.response_code_pol
            )
   
}