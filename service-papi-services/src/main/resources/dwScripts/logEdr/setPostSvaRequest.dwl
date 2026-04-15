%dw 2.0
output application/json

var responseJSC = vars.orderObject
var creationDate = responseJSC.creationDate default null

---
{
  eventType: "SVA",
  ID_Sistema: (responseJSC.domain default "") as String,
  ID_Tpo_Xdr: "SVA",
  Fecha_Ini: if (creationDate != null) ((creationDate as DateTime) as String {format: "yyyyMMdd"}) else "",
  Hora_Ini: if (creationDate != null) ((creationDate as DateTime) as String {format: "HH:mm:ss"}) else "",
  Abonado_A: (responseJSC.subscription.id default "") as String,
  Bolsa: ((responseJSC.packages default [])[0].id default "") as String,
  Valor_Nominal: (responseJSC.amount.amount default "") as String,
  Fch_Vigencia_Ini: if (creationDate != null) ((creationDate as DateTime) as String {format: "yyyyMMdd"}) else "",
  Hora_Vigencia_Ini: if (creationDate != null) ((creationDate as DateTime) as String {format: "HH:mm:ss"}) else "",
  Fch_Vigencia_Fin: "",
  Hora_Vigencia_Fin: "",
  Gestor_Rec: (responseJSC.salesPerson default "") as String,
  ID_Punto_Rec: (responseJSC.pos.id default "") as String,
  Modalidad_pago: "PREPAGO",
  ID_Canal_Rec: (responseJSC.salesChannel default "") as String,
  ID_Plan: ((responseJSC.packages default [])[0].id default "") as String
}