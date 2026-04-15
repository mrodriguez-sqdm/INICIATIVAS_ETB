%dw 2.0
output application/json

var responseJSC = vars.billingAccountObject
var requestJSC = vars.requestJSC

var creationDate = responseJSC.date default null
var expirationDate = responseJSC.expirationDate default null

---
{
  eventType: "RECARGAS",
  ID_Sistema: "JSC",
  ID_Tpo_Xdr: "RECARGAS",
  Fecha_Ini: if (creationDate != null) ((creationDate as DateTime) as String {format: "yyyyMMdd"}) else "",
  Hora_Ini: if (creationDate != null) ((creationDate as DateTime) as String {format: "HH:mm:ss"}) else "",
  Abonado_A: (requestJSC.msisdn default "") as String,
  Saldo_Ini: "0",
  Saldo_Fin: (responseJSC.balanceAfter.amount default "0") as String,
  Valor_Nominal: (responseJSC.amount.amount default "0") as String,
  Fch_Vigencia_Ini: if (creationDate != null) ((creationDate as DateTime) as String {format: "yyyyMMdd"}) else "",
  Hora_Vigencia_Ini: if (creationDate != null) ((creationDate as DateTime) as String {format: "HH:mm:ss"}) else "",
  Fch_Vigencia_Fin: if (expirationDate != null) ((expirationDate as DateTime) as String {format: "yyyyMMdd"}) else "",
  Hora_Vigencia_Fin: if (expirationDate != null) ((expirationDate as DateTime) as String {format: "HH:mm:ss"}) else "",
  Modalidad_pago: (responseJSC.externalID default "") as String,
  Usuario: (responseJSC.user default "") as String
}