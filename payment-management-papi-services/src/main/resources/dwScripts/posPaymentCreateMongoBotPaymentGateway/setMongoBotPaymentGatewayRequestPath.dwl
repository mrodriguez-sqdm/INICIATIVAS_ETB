%dw 2.0
output application/json

fun fechaHoraColombia() =
  (now() >> "America/Bogota") as String {
    format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
  }

var fechaColombia = fechaHoraColombia()
var requestPayload = vars.auditResponse default payload

fun getTipo() =
  ((requestPayload.referencias.detalle_referencias[0].atributos default [])
    filter ($.atributo == "TIPO_PAGO"))[0].valor default ""

fun getLinea() =
  ((requestPayload.referencias.detalle_referencias[0].atributos default [])
    filter ($.atributo == "LINEA"))[0].valor default ""
    
fun getNumAgrupacion() =
  ((requestPayload.referencias.detalle_referencias[0].atributos default [])
    filter ($.atributo == "NUM_AGRUPACION_PLAN"))[0].valor default ""

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
        Fecha_Actualizacion: fechaColombia,
        Fecha_Solicitud: fechaColombia,
        Numeros: [getLinea()],
        Num_Identificacion: requestPayload.cliente.numero_documento default "",
        Linea: getLinea(),
        Num_Agrupacion_Plan: getNumAgrupacion(),
        Tipo_Identificacion: requestPayload.cliente.tipo_documento default "",
        Referencia_Venta: requestPayload.id_transaccion default "",
        Estado: requestPayload.estado_transaccion default "CREATED",

        (
          Facturas:
            (requestPayload.referencias.detalle_referencias default [])
              map (factura) -> {
                Numero_Cuenta_Facturacion:
                  factura.Numero_Cuenta_Facturacion default "",
                Numero_Factura:
                  factura.numero_factura default factura.referencia default "",
                Valor:
                  (factura.valor_pagar default 0) as Number
              }
        ) if (upper(getTipo()) == "PAGO FACTURA"),

        Tipo: getTipo(),
        Valor: requestPayload.referencias.valor_pagar default "",
        Fuente: requestPayload.atributos_pasarela.pasarela default "",
        Origen: requestPayload.atributos_pasarela.tipo_pasarela default "",
        Estado_OCS: null,
        Referencia_Transaccion: null
      }
    ]
  }
}