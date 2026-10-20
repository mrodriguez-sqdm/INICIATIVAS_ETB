%dw 2.0
output application/json
var method = vars.paymentMethod default ""
var flow = vars.paymentFlow default ""
---
method match {
	case "payu" ->
		readUrl('classpath://dwScripts/getPayment/setPayuPaymentResponse.dwl', 'text/plain')

	case "pse" ->
		readUrl('classpath://dwScripts/getPayment/setPsePaymentResponse.dwl', 'text/plain')

	case "wompi" ->
		flow match {
			case "api" ->
				readUrl('classpath://dwScripts/getPayment/setWompiPaymentResponse.dwl', 'text/plain')
			case "checkout" ->
				readUrl('classpath://dwScripts/getPayment/setWompiCheckoutPaymentResponse.dwl', 'text/plain')
			else -> ""
		}

	else -> ""
}