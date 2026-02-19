%dw 2.0
output application/json
---
(attributes.uriParams.paymentMethod) match {
	case "payu" -> readUrl('classpath://dwScripts/postPayment/setPayuPaymentRequest.dwl', 'text/plain')
	case "wompi" -> readUrl('classpath://dwScripts/postPayment/setWompiPaymentRequest.dwl', 'text/plain')
	case "pse" -> readUrl('classpath://dwScripts/postPayment/setPsePaymentRequest.dwl', 'text/plain')
	else -> ""
}
