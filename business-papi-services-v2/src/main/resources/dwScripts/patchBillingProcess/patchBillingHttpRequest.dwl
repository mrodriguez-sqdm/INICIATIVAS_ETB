%dw 2.0
output application/json
var requestHeaders = attributes.headers
---
{
	host: p('zsmart-sapi.host'),
	port: p('zsmart-sapi.port'),
	basepath: p('zsmart-sapi.base-path'),
	path: p('zsmart-sapi.billing.path'),
	method: p('zsmart-sapi.billing.patch.method'),
	headers: {
		"client_secret": p('zsmart-sapi.security.client_secret'),
		"client_id": p('zsmart-sapi.security.client_id'),
		"name": requestHeaders.name,
		"X-CORRELATION-ID": requestHeaders."X-CORRELATION-ID",
		"source": requestHeaders.source,
		"systemId": requestHeaders.systemId
	},
	queryParameters: {
	},
	uriParameters: {
	},
	responseTimeout: p('configurationTimeout.zsmart-sapi.responseTimeout')
}