%dw 2.0
output application/json

var tx = payload.data.transaction
var status = tx.status default ""

fun esFraude(msg) = (msg default "") matches /(?i).*(fraude|antifraude|riesgo).*/

var homol = status match {
  case "APPROVED" -> { estado: "PAGADA",        motivo: null }
  case "ERROR"    -> { estado: "RECHAZADA",     motivo: "TECNICO" }
  case "DECLINED" -> { estado: "RECHAZADA",     motivo: if (esFraude(tx.status_message)) "FRAUDE" else "BANCO" }
  case "PENDING"  -> { estado: "EN_PROCESO",    motivo: null }
  case "VOIDED"   -> { estado: "NO_CONCILIADA", motivo: null }  // ANULACION requiere estado previo; sin él, no se concilia
  else            -> { estado: "NO_CONCILIADA", motivo: null }
}
---
{
	estado: homol.estado
}