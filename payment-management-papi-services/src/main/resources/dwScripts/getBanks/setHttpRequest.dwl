%dw 2.0
output application/json
var paymentMethod = lower(attributes.queryParams.GATEWAY_PAYMENT default "")
---
{
	"host": p(paymentMethod ++ '-sapi.host'),
	"port": p(paymentMethod ++ '-sapi.port'),
	"basepath": p(paymentMethod ++ '-sapi.basepath'),
	"method": p(paymentMethod ++ '-sapi.getBanks.method'),
	"path": p(paymentMethod ++ '-sapi.getBanks.path'),
	"headers": {
		"client_id": p('secure::app.credentials.clientId'),
		"client_secret": p('secure::app.credentials.clientSecret'),
		"X-CORRELATION-ID": attributes.headers.'x-correlation-id' default correlationId,
		"name": attributes.headers.name,
		"systemId": attributes.headers.systemId,
		"source": attributes.headers.source
	}
}