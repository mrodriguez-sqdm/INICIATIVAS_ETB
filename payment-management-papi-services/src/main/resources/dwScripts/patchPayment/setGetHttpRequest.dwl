%dw 2.0
output application/json

var method = if (payload.gateway != null and payload.gateway != "") 
				lower(payload.gateway)
			  else if (payload.event? and payload.data.transaction?)
				"wompiWebhook"
			  else if (payload.properties? and payload.transactionId?)
				"payuWebhook"
			  else ""

// normalización del nombre del sistema
var systemKey =
    if (method == "etb" or method == "wompiWebhook" or method == "payuWebhook") "mongo"
    else method

var configKey = systemKey ++ "-sapi"

var paymentId = if (method == "wompiWebhook")
					{id: payload.data.transaction.id}
				else if (method == "payuWebhook")
					{id: payload.transactionId}
				else
					{ id: attributes.uriParams.paymentId }

---
{
    "host": p(configKey ++ ".host"),
    "port": p(configKey ++ ".port"),
    "basepath": p(configKey ++ ".basepath"),
    "method": p(configKey ++ ".patchPayment.method"),
    "path": p(configKey ++ ".patchPayment.path"),
    "headers": {
        "client_id": p("secure::app.credentials.clientId"),
        "client_secret": p("secure::app.credentials.clientSecret"),
        "X-CORRELATION-ID": attributes.headers.'x-correlation-id' default correlationId,
        "name": attributes.headers.name,
        "systemId": attributes.headers.systemId,
        "source": attributes.headers.source
    },
    "uriParams": paymentId
}