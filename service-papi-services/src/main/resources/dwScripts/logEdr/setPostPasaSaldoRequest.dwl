%dw 2.0
output application/json

---
{
  eventType: "PASASALDO",
  ID_Sistema: vars.ID_Sistema default "",
  ID_Tpo_Xdr: vars.ID_Tpo_Xdr default "",
  Fecha_Ini: vars.Fecha_Ini default "",
  Hora_Ini: vars.Hora_Ini default "",
  Abonado_A: vars.Abonado_A default "",
  Abonado_B: vars.Abonado_B default "",
  Valor_Nominal: vars.Valor_Nominal default 0,
  Modalidad_pago_abonado_a: vars.Modalidad_pago_abonado_a default "",
  Modalidad_pago_abonado_b: vars.Modalidad_pago_abonado_b default "",
  Usuario: vars.Usuario default ""
}