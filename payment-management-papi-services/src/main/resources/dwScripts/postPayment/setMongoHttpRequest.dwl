%dw 2.0
output application/json
---
{
	"host": p('mongo-sapi.host'),
	"port": p('mongo-sapi.port'),
	"basepath": p('mongo-sapi.basepath'),
	"method": p('mongo-sapi.postPayment.method'),
	"path": p('mongo-sapi.postPayment.path'),
	"headers": vars.httpRequest.headers,
	"uriParams": {
		"platform": vars.paymentMethod
	}
}