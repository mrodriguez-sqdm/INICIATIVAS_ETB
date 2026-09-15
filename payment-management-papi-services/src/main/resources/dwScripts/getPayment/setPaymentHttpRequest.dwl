%dw 2.0
output application/json

var method = vars.paymentMethod default ""
var flow   = vars.paymentFlow default ""

// key para host/port/basepath
var gatewayKey = method ++ "-sapi"

// key para method/path
var flowKey =
    if (method == "wompi")
        method ++ "-" ++ flow ++ "-sapi"
    else
        method ++ "-sapi"

var paymentId =
    method match {
        case "payu" -> { id: vars.paymentId }
        case "pse" -> { id: vars.paymentId }
        case "wompi" ->
            flow match {
                case "api" -> { transaction_id: vars.paymentId }
                case "checkout" -> { payment_link_id: vars.paymentId }
                else -> {}
            }
        else -> {}
    }

---
{
	"host": p(gatewayKey ++ '.host'),
	"port": p(gatewayKey ++ '.port'),
	"basepath": p(gatewayKey ++ '.basepath'),
	"method": p(flowKey ++ '.getPayment.method'),
	"path": p(flowKey ++ '.getPayment.path'),
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