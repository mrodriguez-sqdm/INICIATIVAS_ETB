%dw 2.0
output application/json

var responseJSC = vars.orderObject
var creationDate = responseJSC.creationDate default null

---
{
  ID_Sistema: "JSC",
  ID_Tpo_Xdr: "ACTIVACION",
  Fecha_Ini: if (creationDate != null) (creationDate as DateTime) as String {format: "yyyyMMdd"} else "",
  Hora_Ini: if (creationDate != null) (creationDate as DateTime) as String {format: "HH:mm:ss"} else "",
  Abonado_A: vars.MSISDN default "",
  Fch_Vigencia_Ini: if (creationDate != null) (creationDate as DateTime) as String {format: "yyyyMMdd"} else "",
  Hora_Vigencia_Ini: if (creationDate != null) (creationDate as DateTime) as String {format: "HH:mm:ss"} else "",
  Fch_Vigencia_Fin: "",
  Hora_Vigencia_Fin: "",
  Vigencia_Rec: "",
  ID_Gestor_Rec: (responseJSC.salesPerson default "") as String,
  Modalidad_pago: "",
  ID_Medio_pago: "",
  ID_Plan: ((responseJSC.packages default [])[0].id default "") as String,
  Transaccion_Orig: "",
  Usuario: ""
}