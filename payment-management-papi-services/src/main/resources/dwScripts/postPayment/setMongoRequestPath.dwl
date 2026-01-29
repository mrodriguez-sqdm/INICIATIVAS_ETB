%dw 2.0
output application/json
---
(vars.paymentMethod) match {
	case "payu" -> readUrl('classpath://dwScripts/postPayment/setPayuMongoPaymentRequest.dwl')
	case "wompi" -> readUrl('classpath://dwScripts/postPayment/setWompiMongoPaymentRequest.dwl')
	case "pse" -> readUrl('classpath://dwScripts/postPayment/setPseMongoPaymentRequest.dwl')
	else -> ""
}
