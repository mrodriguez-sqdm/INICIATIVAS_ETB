%dw 2.0
output application/json

var setWompiCheckoutPaymentResponse = vars.sapiResponse.data

var taxMap = {
    VAT: "IVA",
    CONSUMPTION: "CONSUMO"
}

---
{
  code: "200",
  message: "Services retrieved successfully",
  result: {
    gateway: "WOMPI",
    transactionId: setWompiCheckoutPaymentResponse.id,
    link: setWompiCheckoutPaymentResponse.wompiUrl,
    name: setWompiCheckoutPaymentResponse.name,
    description: setWompiCheckoutPaymentResponse.description,
    singleUse: setWompiCheckoutPaymentResponse.singleUse,
    collectShipping: setWompiCheckoutPaymentResponse.collectShipping,
    collectCustomerLegalId: setWompiCheckoutPaymentResponse.collectCustomerLegalId,
    currency: setWompiCheckoutPaymentResponse.currency,
    amount: (setWompiCheckoutPaymentResponse.amountInCents default 0) / 100,
    amountInCents: setWompiCheckoutPaymentResponse.amountInCents,
    sku: setWompiCheckoutPaymentResponse.sku default null,
    expiresAt: setWompiCheckoutPaymentResponse.expiresAt default null,
    redirectUrl: setWompiCheckoutPaymentResponse.redirectUrl,
    imageUrl: setWompiCheckoutPaymentResponse.imageUrl default null,
    active: setWompiCheckoutPaymentResponse.active,
    createdAt: setWompiCheckoutPaymentResponse.createdAt,
    updatedAt: setWompiCheckoutPaymentResponse.updatedAt,
    defaultLanguage: setWompiCheckoutPaymentResponse.defaultLanguage,
    merchantPublicKey: setWompiCheckoutPaymentResponse.merchantPublicKey,

    customerData: {
      customerReferences:
        setWompiCheckoutPaymentResponse.customerData.customerReferences map (item) -> {
          label: item.label,
          isRequired: item.isRequired
        }
    },

    taxes:
      setWompiCheckoutPaymentResponse.taxes map (tax) -> {
        "type": taxMap[tax."type"] default tax."type",
        amountInCents: tax.amountInCents
      }
  }
}