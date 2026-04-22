%dw 2.0
output application/json

var requestTransferBalance = vars.requestTransferBalance
var responseJsc = vars.responseJsc

var subscription = responseJsc.content[0] default {}
var creationDate = subscription.creationDate default null

---
{
  ID_Sistema: "JSC" as String,
  ID_Tpo_Xdr: "PASASALDO" as String,
  Fecha_Ini: (now() as String {format: "yyyyMMdd"}),
  Hora_Ini: (now() as String {format: "HH:mm:ss"}),
  Abonado_A: (requestTransferBalance.msisdnOrig default "") as String,
  Abonado_B: (requestTransferBalance.msisdnDest default "") as String,
  Valor_Nominal: (requestTransferBalance.monto default "") as String,
  Modalidad_pago_abonado_a: (subscription.billingType default "") as String,
  Modalidad_pago_abonado_b: (subscription.billingType default "") as String,
  Usuario: (subscription.salesData.salesChannel default "") as String
}