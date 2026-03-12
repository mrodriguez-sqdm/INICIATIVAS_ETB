%dw 2.0
output application/json skipNullOn="everywhere"

var refs = payload.references default []

var fechaHora =
    now() as String {format: "yyyyMMddHHmmss"}

var referenceCode =
    if (sizeOf(refs) > 1)
        "MDM_PAGO_" ++ payload.customer.documentNumber ++ "_" ++ fechaHora
    else
        "MDM_PAGO_" ++ refs[0].reference ++ "_" ++ fechaHora

var totalAmount =
    sum(refs.totalAmount)

var taxesFlat =
    refs flatMap $.taxes

var taxesGrouped =
    (taxesFlat groupBy $."type")
        pluck (value, key) -> {
            code: key,
            value: sum(value.value)
        }

var link = payload.paymentMethod.link

var firstRef = refs[0]

---
{
    name: firstRef.description,
    description: firstRef.description,

    single_use: link.singleUse default true,
    collect_shipping: link.collectShipping default false,

    amount_in_cents: totalAmount * 100,

    currency: firstRef.currency,

    reference: referenceCode,

    sku: link.sku,

    expires_at:
        (link.expiresAt default (now() + |PT4H|))
            as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},

    redirect_url: link.redirectUrl,

    image_url: link.imageUrl,

    active: true,

    customer_data: {
        customer_references:
            (link.customFields default []) map (item) -> {
                label: item.label,
                is_required: item.required
            }
    },

    taxes:
        taxesGrouped map (item) ->
            (item.code) match {

                case "IVA" -> {
                    "type": "VAT",
                    amount_in_cents: item.value * 100
                }

                case "CONSUMO" -> {
                    "type": "CONSUMPTION",
                    amount_in_cents: item.value * 100
                }

                else -> {
                    "type": item.code,
                    amount_in_cents: item.value * 100
                }
            }
}