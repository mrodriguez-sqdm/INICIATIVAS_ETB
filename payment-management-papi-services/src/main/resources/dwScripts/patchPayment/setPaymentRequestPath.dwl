%dw 2.0
output application/json

var gateway = if (payload.gateway != null and payload.gateway != "") 
				lower(payload.gateway)
			  else if (payload.event? and payload.data.transaction?)
				"wompiWebhook"
			  else if (payload.properties? and payload.transactionId?)
				"payuWebhook"
    		  else if (payload.transaction_id? and payload.reference_sale?)
                "payuConfirmation"
			  else ""

---
gateway match {

	case "pse" ->
		readUrl('classpath://dwScripts/patchPayment/setPatchPseRequest.dwl', 'text/plain')

	case "etb" ->
		readUrl('classpath://dwScripts/patchPayment/setPatchMongoRequest.dwl', 'text/plain')
	
	case "wompiWebhook" ->
		readUrl('classpath://dwScripts/patchPayment/setPatchWompiWebhookRequest.dwl', 'text/plain')
	
	case "payuWebhook" ->
		readUrl('classpath://dwScripts/patchPayment/setPatchPayuWebhookRequest.dwl', 'text/plain')
	
	case "payuConfirmation" ->
        readUrl('classpath://dwScripts/patchPayment/setPatchPayuConfirmationRequest.dwl', 'text/plain')

	else -> ""
}