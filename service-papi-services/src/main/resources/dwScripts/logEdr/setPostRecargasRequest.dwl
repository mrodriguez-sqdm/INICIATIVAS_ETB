%dw 2.0
output application/json

---
{
  eventType: "RECARGAS",
  ID_Sistema: vars.ID_Sistema default "",
  ID_Tpo_Xdr: vars.ID_Tpo_Xdr default "",
  Fecha_Ini: vars.Fecha_Ini default "",
  Hora_Ini: vars.Hora_Ini default "",
  Abonado_A: vars.Abonado_A default "",
  Saldo_Ini: vars.Saldo_Ini default 0,
  Saldo_Fin: vars.Saldo_Fin default 0,
  Valor_Nominal: vars.Valor_Nominal default 0,
  Fch_Vigencia_Ini: vars.Fch_Vigencia_Ini default "",
  Hora_Vigencia_Ini: vars.Hora_Vigencia_Ini default "",
  Fch_Vigencia_Fin: vars.Fch_Vigencia_Fin default "",
  Hora_Vigencia_Fin: vars.Hora_Vigencia_Fin default "",
  Modalidad_pago: vars.Modalidad_pago default "",
  ID_Punto_Rec: vars.ID_Punto_Rec default 0,
  ID_Canal_Rec: vars.ID_Canal_Rec default 0,
  Usuario: vars.Usuario default ""
}