%dw 2.0
output application/json

fun fechaHoraColombia() =
    ((now() >> "America/Bogota") as String {
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    })

fun getLinea() =
    ((payload.referencias.detalle_referencias[0].atributos default [])
        filter ($.atributo == "LINEA"))[0].valor default ""

---
{
  query: {
    insert: "BOT_PAYMENT_GATEWAY",
    documents: [
      {
        Atributos: [
          { Attribute: "usuarioId", Value: "" },
          { Attribute: "refVenta", Value: payload.referencias.referencia default "" },
          { Attribute: "descripcion", Value: payload.referencias.descripcion default "" },
          { Attribute: "valor", Value: payload.referencias.valor_pagar default "" },
          { Attribute: "iva", Value: "0" },
          { Attribute: "ivabaseDevolucionIva", Value: "0" },
          { Attribute: "firma", Value: "" },
          { Attribute: "prueba", Value: "0" },
          { Attribute: "moneda", Value: payload.referencias.moneda default "" },
          { Attribute: "emailComprador", Value: payload.cliente.correo default "" },
          { Attribute: "nombreComprador", Value: payload.cliente.nombre_completo default "" },
          { Attribute: "extra1", Value: getLinea() },
          { Attribute: "extra2", Value: "" },
          { Attribute: "url_respuesta", Value: "" },
          { Attribute: "confirmationUrl", Value: "" },
          { Attribute: "usuario_id", Value: "" },
          { Attribute: "cus", Value: payload.CUS default "" },
          { Attribute: "estado_pol", Value: "" },
          { Attribute: "codigo_respuesta_pol", Value: "" },
          { Attribute: "ref_venta", Value: payload.referencias.referencia default "" },
          { Attribute: "ref_pol", Value: payload.id_transaccion default "" },
          { Attribute: "medio_pago", Value: payload.metodo_pago default "" },
          { Attribute: "tipo_medio_pago", Value: "" },
          { Attribute: "ip", Value: "" }
        ],
        Fecha_Actualizacion: fechaHoraColombia(),
        Fecha_Solicitud: fechaHoraColombia(),
        Num_Identificacion: payload.cliente.numero_documento default "",
        Tipo_Identificacion: payload.cliente.tipo_documento default "",
        Referencia_Venta: payload.referencias.referencia default "",
        Estado: "CREADO",
        Tipo: "",
        Valor: payload.referencias.valor_pagar default "",
        Fuente: payload.atributos_pasarela.pasarela default "",
        Origen: payload.atributos_pasarela.tipo_pasarela default "",
        Cuenta_Facturacion: getLinea(),
        Estado_OCS: "CREADO",
        Referencia_Transaccion: payload.id_transaccion default ""
      }
    ]
  }
}