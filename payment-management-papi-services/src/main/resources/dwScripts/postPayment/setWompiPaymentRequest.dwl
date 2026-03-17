%dw 2.0
output application/json

var refs = payload.references default []
var firstReference = refs[0] default {}
var card = payload.paymentMethod.card default {}
var fechaHora =
    now() as String {format: "yyyyMMddHHmmss"}
var referenceCode =
    if (sizeOf(refs) > 1)
        "MDM_PAGO_" ++ payload.customer.documentNumber ++ "_" ++ fechaHora
    else
        "MDM_PAGO_" ++ refs[0].reference ++ "_" ++ fechaHora

var totalAmount =
    sum(refs.totalAmount default [])

---
{
  amount_in_cents: (totalAmount default 0) * 100,
  currency: firstReference.currency default "COP",
  customer_email: payload.customer.email default "",
  
  payment_method: {
    "type": payload.paymentMethod."type" default "",
    token: vars.responseWompiTokens.tokenCards default "",
    installments: card.installments default 1
  },

  payment_method_type: payload.paymentMethod."type" default "",
  redirect_url: payload.paymentMethod.link.redirectUrl default "",
  reference: referenceCode,
  expiration_time: 
    (payload.paymentMethod.link.expirationDate as DateTime)
        as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"},
  customer_data: {
    phone_number: payload.customer.phoneNumber,
    full_name: payload.customer.fullName,
    legal_id: payload.customer.documentNumber,
    legal_id_type: payload.customer.documentType
  },
  "shipping_address": {
    "address_line_1": payload.customer.billingAddress.addressLine1,
    "address_line_2": payload.customer.billingAddress.addressLine2,
    "country": payload.customer.billingAddress.country,
    "region": payload.customer.billingAddress.state,
    "city": payload.customer.billingAddress.city,
    "name": payload.customer.fullName,
    "phone_number": payload.customer.phoneNumber,
    "postal_code": payload.customer.billingAddress.postalCode
  },
  acceptance_token: vars.responseWompiTokens.acceptanceTokens default "",
  ip: payload.origin.ipAddress default ""
}