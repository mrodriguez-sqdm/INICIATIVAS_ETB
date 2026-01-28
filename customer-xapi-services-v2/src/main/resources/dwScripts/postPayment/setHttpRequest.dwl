%dw 2.0
output application/json
---
{
	"host": p('paymentPapi.host'),
	"port": p('paymentPapi.port'),
	"responseTimeout": p('paymentPapi.responseTimeout'),
	"basepath": p('paymentPapi.basepath'),
	"method": p('paymentPapi.postPayment.method'),
	"path": p('paymentPapi.postPayment.path'),
	"headers": {
		"client_id": p('secure::app.credentials.clientId'),
		"client_secret": p('secure::app.credentials.clientSecret'),
		"X-CORRELATION-ID": attributes.headers.'x-correlation-id' default correlationId,
		"source": attributes.headers.source,
		"name": attributes.headers.name,
		"processName": attributes.headers.processname,
		"systemId": attributes.headers.systemId,
	},
	"uriParams": {
		"paymentMethod": attributes.uriParams.paymentMethod
	}
}