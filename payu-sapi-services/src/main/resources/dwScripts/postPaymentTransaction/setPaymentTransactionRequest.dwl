%dw 2.0
import * from dw::Crypto
output application/json

var merchantId = p('payu.merchantId')
var apiKey = p('secure::payu.apiKey')
var apiLogin = p('secure::payu.apiLogin')

var referenceCode = payload.order.referenceCode
var tx_value = payload.order.additionalValues.TX_VALUE.value
var currency_co = payload.order.additionalValues.TX_VALUE.currency

var sigString = apiKey ++ "~" ++ merchantId ++ "~" ++ referenceCode ++ "~" ++ tx_value ++ "~" ++ currency_co
var signature = MD5(sigString as Binary)

var orderSigned = payload.order ++ {
    signature: signature
}

var transaction = {
    order: orderSigned,
    payer: payload.payer,
    creditCard: payload.creditCard,
    extraParameters: payload.extraParameters,
    "type": p('payu.postPaymentTransaction.type'),
    paymentMethod: payload.paymentMethod,
    paymentCountry: payload.paymentCountry,
    deviceSessionId: payload.deviceSessionId,
    ipAddress: payload.ipAddress,
    cookie: payload.cookie,
    userAgent: payload.userAgent,
    threeDomainSecure: payload.threeDomainSecure default null
}

---
{
    language: p('payu.language'),
    command: p('payu.postPaymentTransaction.command'),
    merchant: {
        apiKey: apiKey,
        apiLogin: apiLogin
    },
    transaction: transaction,
    test: p('payu.test')
}