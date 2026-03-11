%dw 2.0
output application/json
var method = vars.paymentMethod default ""
var flow = vars.paymentFlow default ""
---
method match {
	case "payu" ->
		readUrl('classpath://dwScripts/postPayment/setPayuMongoPaymentRequest.dwl', 'text/plain')

	case "pse" ->
		readUrl('classpath://dwScripts/postPayment/setPseMongoPaymentRequest.dwl', 'text/plain')

	case "etb" ->
		readUrl('classpath://dwScripts/postPayment/setEtbMongoPaymentRequest.dwl', 'text/plain')

	case "wompi" ->
		flow match {
			case "api" ->
				readUrl('classpath://dwScripts/postPayment/setWompiMongoPaymentRequest.dwl', 'text/plain')
			case "checkout" ->
				readUrl('classpath://dwScripts/postPayment/setWompiCheckoutMongoPaymentRequest.dwl', 'text/plain')
			else -> ""
		}

	else -> ""
}