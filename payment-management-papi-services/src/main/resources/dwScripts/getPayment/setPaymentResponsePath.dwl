%dw 2.0
output application/json
---
(vars.paymentMethod) match {
	case "payu" -> readUrl('classpath://dwScripts/getPayment/setPayuPaymentResponse.dwl')
	case "wompi" -> readUrl('classpath://dwScripts/getPayment/setWompiPaymentResponse.dwl')
	case "pse" -> readUrl('classpath://dwScripts/getPayment/setPsePaymentResponse.dwl')
	else -> ""
}
