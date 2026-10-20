%dw 2.0
output application/json

var method = if (payload.gateway != null and payload.gateway != "") 
				lower(payload.gateway)
			  else if (payload.event? and payload.data.transaction?)
				"wompiWebhook"
			  else if (payload.properties? and payload.transactionId?)
				"payuWebhook"
			  else if (payload.transaction_id? and payload.reference_sale?)
        		"payuConfirmation"
			  else ""

// normalización del nombre del sistema
var systemKey =
    if (method == "etb" or method == "wompiWebhook" or method == "payuWebhook" or method == "payuConfirmation") "mongo"
    else method

var configKey = systemKey ++ "-sapi"

var paymentLinkId = payload.data.transaction.payment_link_id default null

var paymentId = if (method == "wompiWebhook" and paymentLinkId != null and paymentLinkId != "")
					{cus: paymentLinkId}
				else if (method == "wompiWebhook")
					{id: payload.data.transaction.reference}
				else if (method == "payuWebhook")
					{id: payload.transactionId}
				else if (method == "payuConfirmation")
        			{id: payload.reference_sale }
				else
					{ id: attributes.uriParams.paymentId }

var paymentPath = if (method == "wompiWebhook" and paymentLinkId != null and paymentLinkId != "")
					p(configKey ++ ".patchPaymentCus.path")
				  else
					p(configKey ++ ".patchPayment.path")

---
{
    "host": p(configKey ++ ".host"),
    "port": p(configKey ++ ".port"),
    "basepath": p(configKey ++ ".basepath"),
    "method": p(configKey ++ ".patchPayment.method"),
    "path": paymentPath,
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