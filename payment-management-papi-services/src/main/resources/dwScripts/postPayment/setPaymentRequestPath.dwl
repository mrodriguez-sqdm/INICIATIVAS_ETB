%dw 2.0
output application/json
---
(attributes.uriParams.paymentMethod) match {
	case "payu" -> readUrl('classpath://dwScripts/postPayment/setPayuPaymentRequest.dwl')
	case "wompi" -> readUrl('classpath://dwScripts/postPayment/setWompiPaymentRequest.dwl')
	case "pse" -> readUrl('classpath://dwScripts/postPayment/setPsePaymentRequest.dwl')
	else -> ""
}
