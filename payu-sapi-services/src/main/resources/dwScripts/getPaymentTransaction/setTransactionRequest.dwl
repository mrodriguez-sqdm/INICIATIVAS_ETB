%dw 2.0
output application/json
---
{

   "test": p('payu.test'),
   "language": p('payu.language'),
   "command": p('payu.getPaymentTransaction.command'),
   "merchant": {
      "apiLogin": p('secure::payu.apiLogin'),
      "apiKey": p('secure::payu.apiKey')
   },
   "details": {
      "transactionId": attributes.uriParams.'id'
   }

}