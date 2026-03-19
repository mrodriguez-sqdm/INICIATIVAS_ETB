%dw 2.0
output application/json

var method = if (vars.payloadRequest.gateway != null and vars.payloadRequest.gateway != "") 
				lower(vars.payloadRequest.gateway)
			  else if (vars.payloadRequest.event? and vars.payloadRequest.data.transaction?)
				"wompiWebhook"
			  else if (vars.payloadRequest.properties? and vars.payloadRequest.transactionId?)
				"payuWebhook"
			  else ""

var paymentId = if (method == "wompiWebhook")
					{id: vars.payloadRequest.data.transaction.id}
				else if (method == "payuWebhook")
					{id: vars.payloadRequest.transactionId}
				else
					{ id: attributes.uriParams.paymentId }
---
{
	"host": p('mongo-sapi.host'),
	"port": p('mongo-sapi.port'),
	"basepath": p('mongo-sapi.basepath'),
	"method": p('mongo-sapi.getPayment.method'),
	"path": p('mongo-sapi.getPayment.path'),
	"headers": {
		"client_id": p('secure::app.credentials.clientId'),
		"client_secret": p('secure::app.credentials.clientSecret'),
		"X-CORRELATION-ID": attributes.headers.'x-correlation-id' default correlationId,
		"name": attributes.headers.name,
		"systemId": attributes.headers.systemId,
		"source": attributes.headers.source
	},
	"uriParams": paymentId
}