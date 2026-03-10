%dw 2.0
output application/json
---
(vars.paymentMethod) match {
	case "payu" -> readUrl('classpath://dwScripts/postPayment/setPayuPaymentResponse.dwl', 'text/plain')
	case "wompi" -> readUrl('classpath://dwScripts/postPayment/setWompiPaymentResponse.dwl', 'text/plain')
	case "pse" -> readUrl('classpath://dwScripts/postPayment/setPsePaymentResponse.dwl', 'text/plain')
	else -> ""
}
