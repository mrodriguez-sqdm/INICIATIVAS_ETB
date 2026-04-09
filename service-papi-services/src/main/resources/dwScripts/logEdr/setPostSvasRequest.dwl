%dw 2.0
output application/json

var responseJSC = vars.orderObject
var creationDate = responseJSC.creationDate as DateTime

---
{
  eventType: "SVAS",
  ID_Sistema: responseJSC.domain,
  ID_Tpo_Xdr: "SVAS",
  Fecha_Ini: creationDate as String {format: "yyyyMMdd"},
  Hora_Ini: creationDate as String {format: "HH:mm:ss"},
  Abonado_A: responseJSC.subscription.id default "",
  Bolsa: (responseJSC.packages default [])[0].id default "",
  Valor_Nominal: responseJSC.amount.amount default 0,
  Fch_Vigencia_Ini: creationDate as String {format: "yyyyMMdd"},
  Hora_Vigencia_Ini: creationDate as String {format: "HH:mm:ss"},
  Fch_Vigencia_Fin: "",
  Hora_Vigencia_Fin: "",
  Gestor_Rec: responseJSC.salesPerson default "",
  ID_Punto_Rec: responseJSC.pos.id default "",
  Modalidad_pago: "PREPAGO",
  ID_Canal_Rec: responseJSC.salesChannel,
  ID_Plan: (responseJSC.packages default [])[0].id default ""
}