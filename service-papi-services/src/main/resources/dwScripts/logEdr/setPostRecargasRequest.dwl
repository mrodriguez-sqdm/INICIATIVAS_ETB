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
  Abonado_A: requestJSC.msisdn default "",
  Saldo_Ini: 0,
  Saldo_Fin: responseJSC.balanceAfter.amount default 0,
  Valor_Nominal: responseJSC.amount.amount default 0,
  Fch_Vigencia_Ini: (responseJSC.date as DateTime) as String {format: "yyyyMMdd"} default "",
  Hora_Vigencia_Ini: (responseJSC.date as DateTime) as String {format: "HH:mm:ss"} default "",
  Fch_Vigencia_Fin: (responseJSC.expirationDate as DateTime) as String {format: "yyyyMMdd"} default "",
  Hora_Vigencia_Fin: (responseJSC.expirationDate as DateTime) as String {format: "HH:mm:ss"} default "",
  Modalidad_pago: responseJSC.externalID default "",
  Usuario: responseJSC.user default ""
}