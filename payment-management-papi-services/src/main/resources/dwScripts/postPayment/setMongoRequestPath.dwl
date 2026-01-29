%dw 2.0
output application/json
---
(vars.paymentMethod) match {
	case "payu" -> readUrl('classpath://dwScripts/postPayment/setPayuMongoPaymentRequest.dwl', 'text/plain')
	case "wompi" -> readUrl('classpath://dwScripts/postPayment/setWompiMongoPaymentRequest.dwl', 'text/plain')
	case "pse" -> readUrl('classpath://dwScripts/postPayment/setPseMongoPaymentRequest.dwl', 'text/plain')
	else -> ""
}
