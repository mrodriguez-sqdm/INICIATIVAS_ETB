%dw 2.0
output application/json skipNullOn = "everywhere"

var refs = payload.references default []

var fechaHora =
  (now() >> "America/Bogota") as String {
    format: "yyyyMMddHHmmss"
  }

var referenceCode =
    if (sizeOf(refs) > 1)
        "MDM_PAGO_" ++ payload.customer.documentNumber ++ "_" ++ fechaHora
    else
        "MDM_PAGO_" ++ refs[0].reference ++ "_" ++ fechaHora

var totalAmount =
    sum(refs.totalAmount)

var iva =
    sum(
        refs
        flatMap ($.taxes filter ($."type" == "IVA"))
        map $.value
    )

var baseGravable =
    sum(
        refs
        flatMap ($.taxes filter ($."type" == "BASE_GRAVABLE"))
        map $.value
    )

var firstRef = refs[0]

var payment = payload.paymentMethod
---
{
  order: {
    accountId: Mule::p("payu-sapi.fields.accountId"),
    referenceCode: referenceCode,
    description: (refs map $.description) joinBy ", ",
    language: "es",
    notifyUrl: payment.link.notifyUrl,

    additionalValues: {
      TX_VALUE: {
        value: totalAmount, 
        currency: firstRef.currency
      },
      TX_TAX: {
        value: iva,
        currency: firstRef.currency
      },
      TX_TAX_RETURN_BASE: {
        value: baseGravable,
        currency: firstRef.currency
      }
    },

    buyer: {
      merchantBuyerId: "1",
      fullName: payload.customer.fullName,
      emailAddress: payload.customer.email,
      contactPhone: payload.customer.phoneNumber,
      dniNumber: payload.customer.documentNumber,

      shippingAddress: {
        street1: payload.customer.billingAddress.addressLine1,
        street2: payload.customer.billingAddress.addressLine2,
        city: payload.customer.billingAddress.city,
        state: payload.customer.billingAddress.state,
        country: payload.customer.billingAddress.country,
        postalCode: payload.customer.billingAddress.postalCode,
        phone: payload.customer.phoneNumber
      }
    },

    shippingAddress: {
      street1: payload.customer.billingAddress.addressLine1,
      street2: payload.customer.billingAddress.addressLine2,
      city: payload.customer.billingAddress.city,
      state: payload.customer.billingAddress.state,
      country: payload.customer.billingAddress.country,
      postalCode: payload.customer.billingAddress.postalCode,
      phone: payload.customer.phoneNumber
    }
  },

  payer: {
    merchantPayerId: "1",
    fullName: payload.customer.fullName,
    emailAddress: payload.customer.email,
    contactPhone: payload.customer.phoneNumber,
    dniNumber: payload.customer.documentNumber,

    billingAddress: {
      street1: payload.customer.billingAddress.addressLine1,
      street2: payload.customer.billingAddress.addressLine2,
      city: payload.customer.billingAddress.city,
      state: payload.customer.billingAddress.state,
      country: payload.customer.billingAddress.country,
      postalCode: payload.customer.billingAddress.postalCode,
      phone: payload.customer.phoneNumber
    }
  },

  creditCard: {
    number: payment.card.cardData.cardNumber,
    securityCode: payment.card.cardData.cvc,
    expirationDate:
        "20" ++ payment.card.cardData.expYear ++ "/" ++ payment.card.cardData.expMonth,
    name: payment.card.cardData.cardHolder
  },

  extraParameters: {
    INSTALLMENTS_NUMBER: payment.card.installments
  },

  "type": "AUTHORIZATION_AND_CAPTURE",
  paymentMethod: payment.card.cardBrand,
  paymentCountry: payload.customer.billingAddress.country,

  deviceSessionId: payload.origin.deviceSessionId,
  ipAddress: payload.origin.ipAddress,
  cookie: payload.origin.cookie,
  userAgent: payload.origin.userAgent
}