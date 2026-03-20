%dw 2.0
output application/json

---
{
  eventType: "SVAS",
  ID_Sistema: vars.ID_Sistema default "",
  ID_Tpo_Xdr: vars.ID_Tpo_Xdr default "",
  Fecha_Ini: vars.Fecha_Ini default "",
  Hora_Ini: vars.Hora_Ini default "",
  Abonado_A: vars.Abonado_A default "",
  Valor_Nominal: vars.Valor_Nominal default 0,
  Fch_Vigencia_Ini: vars.Fch_Vigencia_Ini default "",
  Hora_Vigencia_Ini: vars.Hora_Vigencia_Ini default "",
  Fch_Vigencia_Fin: vars.Fch_Vigencia_Fin default "",
  Hora_Vigencia_Fin: vars.Hora_Vigencia_Fin default "",
  Gestor_Rec: vars.Gestor_Rec default 0,
  Modalidad_pago: vars.Modalidad_pago default "",
  ID_Plan: vars.ID_Plan default 0,
  Bolsa: vars.Bolsa default "",
  Usuario: vars.Usuario default ""
}