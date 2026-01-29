%dw 2.0
output application/json
---
{
	"host": p('mongo-sapi.host'),
	"port": p('mongo-sapi.port'),
	"basepath": p('mongo-sapi.basepath'),
	"method": p('mongo-sapi.patchPayment.method'),
	"path": p('mongo-sapi.patchPayment.path'),
	"headers": {
		"client_id": p('secure::app.credentials.clientId'),
		"client_secret": p('secure::app.credentials.clientSecret'),
		"X-CORRELATION-ID": attributes.headers.'x-correlation-id' default correlationId,
		"name": attributes.headers.name,
		"systemId": attributes.headers.systemId,
		"source": attributes.headers.source
	},
	"uriParams": {
		"platform": vars.paymentMethod
	}
}