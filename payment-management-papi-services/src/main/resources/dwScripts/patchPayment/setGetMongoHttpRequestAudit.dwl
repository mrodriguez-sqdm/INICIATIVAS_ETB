%dw 2.0
output application/json

var method = if (vars.payloadRequest.gateway != null and vars.payloadRequest.gateway != "") 
				lower(vars.payloadRequest.gateway)
			  else if (vars.payloadRequest.event? and vars.payloadRequest.data.transaction?)
				"wompiWebhook"
			  else if (vars.payloadRequest.properties? and vars.payloadRequest.transactionId?)
				"payuWebhook"
			  else if (vars.payloadRequest.transaction_id? and vars.payloadRequest.reference_sale?)
                "payuConfirmation"
			  else ""

var paymentLinkId = vars.payloadRequest.data.transaction.payment_link_id default null

var paymentId = if (method == "wompiWebhook" and paymentLinkId != null and paymentLinkId != "")
					paymentLinkId
				else if (method == "wompiWebhook")
					vars.payloadRequest.data.transaction.reference
				else if (method == "payuWebhook")
					vars.payloadRequest.transactionId
				else if (method == "payuConfirmation")
        			vars.payloadRequest.reference_sale
				else
					vars.uriParamsRequest.paymentId

var paymentPath = if (method == "wompiWebhook" and paymentLinkId != null and paymentLinkId != "")
					p('mongo-sapi.getPaymentCus.path')
				  else
					p('mongo-sapi.getPayment.path')

---
{
	"host": p('mongo-sapi.host'),
	"port": p('mongo-sapi.port'),
	"basepath": p('mongo-sapi.basepath'),
	"method": p('mongo-sapi.getPayment.method'),
	"path": paymentPath,
	"headers": {
		"client_id": p('secure::app.credentials.clientId'),
		"client_secret": p('secure::app.credentials.clientSecret'),
		"X-CORRELATION-ID": vars.headersRequest.'x-correlation-id',
		"name": vars.headersRequest.name,
		"systemId": vars.headersRequest.systemId,
		"source": vars.headersRequest.source
	},
	"uriParams": if (method == "wompiWebhook" and paymentLinkId != null and paymentLinkId != "")
					{
						"cus": paymentId
					}
				 else
					{
						"transaccionId": paymentId
					}
}