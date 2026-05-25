%dw 2.0
output application/json

var refs = payload.references default []
var firstDetailRef = refs[0]

var fechaHora =
    now() as String { format: "yyyyMMddHHmmss" }

var referenceCode =
    if (sizeOf(refs) > 1)
        "MDM_PAGO_" ++ payload.customer.documentNumber ++ "_" ++ fechaHora
    else
        "MDM_PAGO_" ++ firstDetailRef.reference ++ "_" ++ fechaHora

var allTaxes =
    refs flatMap ($.taxes default [])

---
{
    id_transaccion: payload.transactionId,

    CUS: payload.CUS default "",

    atributos_pasarela: {
        pasarela: payload.gateway.gatewayName,
        tipo_pasarela: payload.gateway.paymentFlow
    },

    metodo_pago: payload.paymentMethod."type" default "",

    referencias: {

        referencia: referenceCode,

        descripcion:
            (refs map $.description) joinBy ", ",

        moneda: firstDetailRef.currency default "",

        valor_pagar:
            (sum(refs map $.totalAmount) default 0) as String,

        impuestos:
            (allTaxes)
                groupBy ($."type")
                pluck ((values, key) -> {
                    tipo: key,
                    valor: (sum(values map $.value) default 0) as String
                }),

        detalle_referencias:
            refs map (r) -> {
                referencia: r.reference default "",
                numero_factura: r.invoiceNumber default "",
                descripcion: r.description default "",
                moneda: r.currency default "",
                valor_pagar: (r.totalAmount default 0) as String,
                impuestos:
                    (r.taxes default [])
                    map (t) -> {
                        tipo: t."type" default "",
                        valor: (t.value default 0) as String
                    },
				atributos:
					(r.attributes default [])
					map (a) -> {
						atributo: a.attribute default "",
						valor: a.value default ""
					}
            }
    },

    cliente: {
        tipo_documento: payload.customer.documentType default "CC",
        numero_documento: payload.customer.documentNumber default "",
        nombre_completo: payload.customer.fullName default "",
        correo: payload.customer.email default "",
        telefono: payload.customer.phoneNumber default ""
    },

    concepto:
        firstDetailRef.description default "",

    entidad_bancaria:
        "ENTIDAD BANCARIA",

    estado_transaccion: payload.status,

    fecha_registro:
        now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" },

    fecha_respuesta_pasarela:
        now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" },

    fecha_actualizacion:
        now() as String { format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'" }
}