%dw 2.0
output application/json

fun fechaHoraColombia() =
    ((now() >> "America/Bogota") as String {
        format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
    })

fun getLinea() =
    ((payload.referencias.detalle_referencias[0].atributos default [])
        filter ($.atributo == "LINEA"))[0].valor default ""

var requestPayload = vars.vars.auditResponse
---
{
  query: {
    insert: "BOT_PAYMENT_GATEWAY",
    documents: [
      {
        Atributos: [
          { Attribute: "usuarioId", Value: "" },
          { Attribute: "refVenta", Value: requestPayload.referencias.referencia default "" },
          { Attribute: "descripcion", Value: requestPayload.referencias.descripcion default "" },
          { Attribute: "valor", Value: requestPayload.referencias.valor_pagar default "" },
          { Attribute: "iva", Value: "0" },
          { Attribute: "ivabaseDevolucionIva", Value: "0" },
          { Attribute: "firma", Value: "" },
          { Attribute: "prueba", Value: "0" },
          { Attribute: "moneda", Value: requestPayload.referencias.moneda default "" },
          { Attribute: "emailComprador", Value: requestPayload.cliente.correo default "" },
          { Attribute: "nombreComprador", Value: requestPayload.cliente.nombre_completo default "" },
          { Attribute: "extra1", Value: getLinea() },
          { Attribute: "extra2", Value: "" },
          { Attribute: "url_respuesta", Value: "" },
          { Attribute: "confirmationUrl", Value: "" },
          { Attribute: "usuario_id", Value: "" },
          { Attribute: "cus", Value: requestPayload.CUS default "" },
          { Attribute: "estado_pol", Value: "" },
          { Attribute: "codigo_respuesta_pol", Value: "" },
          { Attribute: "ref_venta", Value: requestPayload.referencias.referencia default "" },
          { Attribute: "ref_pol", Value: requestPayload.id_transaccion default "" },
          { Attribute: "medio_pago", Value: requestPayload.metodo_pago default "" },
          { Attribute: "tipo_medio_pago", Value: "" },
          { Attribute: "ip", Value: "" }
        ],
        Fecha_Actualizacion: fechaHoraColombia(),
        Fecha_Solicitud: fechaHoraColombia(),
        Num_Identificacion: requestPayload.cliente.numero_documento default "",
        Tipo_Identificacion: requestPayload.cliente.tipo_documento default "",
        Referencia_Venta: requestPayload.referencias.referencia default "",
        Estado: "CREADO",
        Tipo: "",
        Valor: requestPayload.referencias.valor_pagar default "",
        Fuente: requestPayload.atributos_pasarela.pasarela default "",
        Origen: requestPayload.atributos_pasarela.tipo_pasarela default "",
        Cuenta_Facturacion: getLinea(),
        Estado_OCS: "CREADO",
        Referencia_Transaccion: requestPayload.id_transaccion default ""
      }
    ]
  }
}