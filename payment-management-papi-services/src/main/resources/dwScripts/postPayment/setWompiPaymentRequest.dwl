%dw 2.0
output application/json

var firstReference = (payload.references default [])[0]
var card = payload.paymentMethod.card default {}

---
{
  amount_in_cents: (firstReference.totalAmount default 0) * 100,
  currency: firstReference.currency default "COP",
  customer_email: payload.customer.email default "",
  
  payment_method: {
    "type": payload.paymentMethod."type" default "CARD",
    token: vars.responseWompiTokens.tokenCards default "",
    installments: card.installments default 1
  },

  payment_method_type: payload.paymentMethod."type" default "CARD",
  reference: firstReference.reference default "",
  acceptance_token: vars.responseWompiTokens.acceptanceTokens default "",
  ip: payload.origin.ipAddress default ""
}