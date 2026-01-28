%dw 2.0
output application/json
---
{
	"host": p('customerPapi.host'),
	"port": p('customerPapi.port'),
	"responseTimeout": p('customerPapi.responseTimeout'),
	"basepath": p('customerPapi.basepath'),
	"method": p('customerPapi.getCustomer.method'),
	"path": p('customerPapi.getCustomer.path'),
	"headers": {
		"client_id": p('secure::app.credentials.clientId'),
		"client_secret": p('secure::app.credentials.clientSecret'),
		"X-CORRELATION-ID": attributes.headers.'x-correlation-id' default correlationId,
		"source": attributes.headers.source,
		"name": attributes.headers.name,
		"processName": attributes.headers.processname,
		"systemId": attributes.headers.systemId,
	},
	"queryParams": attributes.queryParams
}