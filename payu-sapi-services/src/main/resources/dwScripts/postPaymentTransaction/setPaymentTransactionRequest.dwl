%dw 2.0
import * from dw::Crypto
output application/json
var merchantId = p('payu.merchantId')
var apiKey = p('secure::payu.apiKey')
var paymentCountry = p('payu.paymentCountry')
var apiLogin = p('secure::payu.apiLogin')
var referenceCode = payload.order.referenceCode
var tx_value = payload.order.additionalValues.TX_VALUE.value
var currency_co = payload.order.additionalValues.TX_VALUE.currency
var sigString = apiKey ++ "~" ++ merchantId ++ "~" ++ referenceCode ++ "~" ++ tx_value ++ "~" ++ currency_co
var signature = {"signature": MD5(sigString as Binary)}
var order =  payload.order
var data = payload - "transaction" ++ {
    transaction: payload - "order"
}
var transaction = data.transaction ++ {"type": p('payu.postPaymentTransaction.type')}
var newOrder = {"order": (order ++ signature)}
---
{
    "language": p('payu.language'),
    "test": p('payu.test'),
    "command": p('payu.postPaymentTransaction.command'),
    "merchant": {
        "apiKey": apiKey,
        "apiLogin": apiLogin
    },
    "transaction": transaction ++ newOrder
}