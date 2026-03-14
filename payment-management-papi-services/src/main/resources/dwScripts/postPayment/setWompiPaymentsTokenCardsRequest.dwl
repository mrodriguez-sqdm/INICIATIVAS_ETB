%dw 2.0
output application/json

var cardData = vars.payloadOri.paymentMethod.card.cardData default {}

---
{
  number: cardData.cardNumber,
  exp_month: cardData.expMonth,
  exp_year: cardData.expYear,
  cvc: cardData.cvc,
  card_holder: cardData.cardHolder
}