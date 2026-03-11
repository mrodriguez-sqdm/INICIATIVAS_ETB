%dw 2.0
output application/json

var setWompiCheckoutPaymentResponse = vars.sapiResponse.data

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
    currency: setWompiCheckoutPaymentResponse.currency,
    amount: (setWompiCheckoutPaymentResponse.amountInCents default 0) / 100,
    sku: setWompiCheckoutPaymentResponse.sku default null,
    expiresAt: setWompiCheckoutPaymentResponse.expiresAt default null,
    redirectUrl: setWompiCheckoutPaymentResponse.redirectUrl,
    imageUrl: setWompiCheckoutPaymentResponse.imageUrl default null,
    active: setWompiCheckoutPaymentResponse.active,
    createdAt: setWompiCheckoutPaymentResponse.createdAt,
    updatedAt: setWompiCheckoutPaymentResponse.updatedAt,
    merchantPublicKey: setWompiCheckoutPaymentResponse.merchantPublicKey
  }
}