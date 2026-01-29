%dw 2.0
output application/json
---
(vars.paymentMethod) match {
	case "payu" -> readUrl('classpath://dwScripts/getPayment/setPayuPaymentResponse.dwl', 'text/plain')
	case "wompi" -> readUrl('classpath://dwScripts/getPayment/setWompiPaymentResponse.dwl', 'text/plain')
	case "pse" -> readUrl('classpath://dwScripts/getPayment/setPsePaymentResponse.dwl', 'text/plain')
	else -> ""
}
