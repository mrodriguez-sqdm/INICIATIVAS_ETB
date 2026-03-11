%dw 2.0
output application/json
var gateway = lower(payload.gateway.gatewayName default "")
var flow = lower(payload.gateway.paymentFlow default "")
---
gateway match {
	case "payu" ->
		readUrl('classpath://dwScripts/postPayment/setPayuPaymentRequest.dwl', 'text/plain')

	case "pse" ->
		readUrl('classpath://dwScripts/postPayment/setPsePaymentRequest.dwl', 'text/plain')
		
	case "etb" ->
		readUrl('classpath://dwScripts/postPayment/setEtbPaymentRequest.dwl', 'text/plain')
		
	case "wompi" ->
		flow match {
			case "api" ->
				readUrl('classpath://dwScripts/postPayment/setWompiPaymentRequest.dwl', 'text/plain')
			case "checkout" ->
				readUrl('classpath://dwScripts/postPayment/setWompiCheckoutPaymentRequest.dwl', 'text/plain')
			else -> ""
		}

	else -> ""
}