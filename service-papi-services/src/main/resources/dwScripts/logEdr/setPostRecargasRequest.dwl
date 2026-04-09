%dw 2.0
output application/json

var responseJSC = vars.billingAccountObject
var requestJSC = vars.requestJSC

---
{
  eventType: "RECARGAS",
  ID_Sistema: "JSC",
  ID_Tpo_Xdr: "RECARGAS",
  Fecha_Ini: (responseJSC.date as DateTime) as String {format: "yyyyMMdd"} default "",
  Hora_Ini: (responseJSC.date as DateTime) as String {format: "HH:mm:ss"} default "",
  Abonado_A: requestJSC.msisdn as String default "",
  Saldo_Ini: "0",
  Saldo_Fin: responseJSC.balanceAfter.amount as String default "0",
  Valor_Nominal: responseJSC.amount.amount as String default "0",
  Fch_Vigencia_Ini: (responseJSC.date as DateTime) as String {format: "yyyyMMdd"} default "",
  Hora_Vigencia_Ini: (responseJSC.date as DateTime) as String {format: "HH:mm:ss"} default "",
  Fch_Vigencia_Fin: (responseJSC.expirationDate as DateTime) as String {format: "yyyyMMdd"} default "",
  Hora_Vigencia_Fin: (responseJSC.expirationDate as DateTime) as String {format: "HH:mm:ss"} default "",
  Modalidad_pago: responseJSC.externalID as String default "",
  Usuario: responseJSC.user as String default ""
}