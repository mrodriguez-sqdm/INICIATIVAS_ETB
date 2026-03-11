%dw 2.0
output application/json
var method = vars.paymentMethod default ""
var flow = vars.paymentFlow default ""
---
method match {
	case "payu" ->
		readUrl('classpath://dwScripts/postPayment/setPayuPaymentResponse.dwl', 'text/plain')

	case "pse" ->
		readUrl('classpath://dwScripts/postPayment/setPsePaymentResponse.dwl', 'text/plain')

	case "wompi" ->
		flow match {
			case "api" ->
				readUrl('classpath://dwScripts/postPayment/setWompiPaymentResponse.dwl', 'text/plain')
			case "checkout" ->
				readUrl('classpath://dwScripts/postPayment/setWompiCheckoutPaymentResponse.dwl', 'text/plain')
			else -> ""
		}

	else -> ""
}