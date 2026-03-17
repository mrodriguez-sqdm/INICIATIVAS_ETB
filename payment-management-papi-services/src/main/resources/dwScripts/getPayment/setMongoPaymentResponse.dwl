%dw 2.0
output application/json
var ref = payload.referencias
---
{
    code: "200",
    message: "Services retrieved successfully",
    result: {
    	cus: payload.CUS,
        transactionId: payload.id_transaccion,
        gatewayAttributes: {
            gateway: payload.atributos_pasarela.pasarela,
            gatewayType: payload.atributos_pasarela.tipo_pasarela
        },
        paymentMethod: payload.metodo_pago,
        references: {
            reference: ref.referencia,
            description: ref.descripcion,
            currency: ref.moneda,
            amountToPay: ref.valor_pagar,
            taxes: (ref.impuestos default []) map (t) -> {
                "type": t.tipo,
                value: t.valor
            },
            referenceDetails:
                (ref.detalle_referencias default []) map (d) -> {
                    reference: d.referencia,
                    description: d.descripcion,
                    currency: d.moneda,
                    amountToPay: d.valor_pagar,
                    taxes: (d.impuestos default []) map (tx) -> {
                        "type": tx.tipo,
                        value: tx.valor
                    }
                }
        },
        customer: {
            documentType: payload.cliente.tipo_documento,
            documentNumber: payload.cliente.numero_documento,
            fullName: payload.cliente.nombre_completo,
            email: payload.cliente.correo,
            phone: payload.cliente.telefono
        },
        concept: payload.concepto,
        bankEntity: payload.entidad_bancaria,
        transactionStatus: payload.estado_transaccion,
        registrationDate: payload.fecha_registro,
        gatewayResponseDate: payload.fecha_respuesta_pasarela,
        updateDate: payload.fecha_actualizacion
    }
}