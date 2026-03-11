%dw 2.0
output application/json

var gateway = lower(payload.gateway.gatewayName default "")
var flow = lower(payload.gateway.paymentFlow default "")

// clave para host/port/basepath
var gatewayKey = gateway ++ "-sapi"

// clave para method/path
var flowKey =
    if (gateway == "wompi")
        gateway ++ "-" ++ flow ++ "-sapi"
    else
        gateway ++ "-sapi"

---
{
	"host": p(gatewayKey ++ ".host"),
	"port": p(gatewayKey ++ ".port"),
	"basepath": p(gatewayKey ++ ".basepath"),
	"method": p(flowKey ++ ".postPayment.method"),
	"path": p(flowKey ++ ".postPayment.path"),
	"headers": {
		"client_id": p('secure::app.credentials.clientId'),
		"client_secret": p('secure::app.credentials.clientSecret'),
		"X-CORRELATION-ID": attributes.headers.'x-correlation-id' default correlationId,
		"name": attributes.headers.name,
		"systemId": attributes.headers.systemId,
		"source": attributes.headers.source
	}
}