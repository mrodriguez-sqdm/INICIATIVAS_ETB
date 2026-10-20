%dw 2.0
output application/json

var wompiResponse = vars.sapiResponse.data

---
{
  code: "200",
  message: "Services retrieved successfully",
  result: {
    gateway: "WOMPI",
    transactionId: wompiResponse.id,
    reference: wompiResponse.reference,
    createdAt: wompiResponse.createdAt,
    finalizedAt: wompiResponse.finalizedAt,
    amount: (wompiResponse.amountInCents default 0) / 100,
    amountInCents: wompiResponse.amountInCents,
    currency: wompiResponse.currency,
    customerEmail: wompiResponse.customerEmail,
    paymentMethodType: wompiResponse.paymentMethodType,
    status: wompiResponse.status,
    statusMessage: wompiResponse.statusMessage,
    redirectUrl: wompiResponse.redirectUrl,
    paymentSourceId: wompiResponse.paymentSourceId,
    paymentLinkId: wompiResponse.paymentLinkId,
    billId: wompiResponse.billId,
    tipInCents: wompiResponse.tipInCents,

    merchant: {
      id: wompiResponse.merchant.id default null,
      name: wompiResponse.merchant.name default null,
      legalName: wompiResponse.merchant.legalName default null
    },

    paymentMethod: {
      "type": wompiResponse.paymentMethod."type",
      installments: wompiResponse.paymentMethod.installments,
      extra: {
        bin: wompiResponse.paymentMethod.extra.bin,
        name: wompiResponse.paymentMethod.extra.name,
        brand: wompiResponse.paymentMethod.extra.brand,
        cardType: wompiResponse.paymentMethod.extra.cardType,
        lastFour: wompiResponse.paymentMethod.extra.lastFour,
        cardHolder: wompiResponse.paymentMethod.extra.cardHolder,
        isThreeDs: wompiResponse.paymentMethod.extra.isThreeDs,
        threeDsAuthType: wompiResponse.paymentMethod.extra.threeDsAuthType
      }
    },

    billingData: wompiResponse.billingData,
    shippingAddress: wompiResponse.shippingAddress,
    customerData: wompiResponse.customerData,

    taxes:
      wompiResponse.taxes map (tax) -> {
        "type": tax."type",
        amountInCents: tax.amountInCents
      }
  }
}