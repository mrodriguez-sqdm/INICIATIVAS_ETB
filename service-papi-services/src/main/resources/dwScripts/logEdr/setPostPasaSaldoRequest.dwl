%dw 2.0
output application/json

var requestTransferBalance = vars.requestTransferBalance
var responseJsc = vars.responseJsc

var subscription = responseJsc.content[0] default {}
var creationDate = subscription.creationDate default null

---
{
  eventType: "PASASALDO" as String,
  ID_Sistema: "JSC" as String,
  ID_Tpo_Xdr: "PASASALDO" as String,
  Fecha_Ini: 
    if (creationDate != null)
      ((creationDate as DateTime {format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"})
        as String {format: "yyyyMMdd"})
    else "",
  Hora_Ini: 
    if (creationDate != null)
      ((creationDate as DateTime {format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"})
        as String {format: "HH:mm:ss"})
    else "",
  Abonado_A: (requestTransferBalance.msisdnOrig default "") as String,
  Abonado_B: (requestTransferBalance.msisdnDest default "") as String,
  Valor_Nominal: (requestTransferBalance.monto default "") as String,
  Modalidad_pago_abonado_a: (subscription.billingType default "") as String,
  Modalidad_pago_abonado_b: (subscription.billingType default "") as String,
  Usuario: (subscription.salesData.salesChannel default "") as String
}