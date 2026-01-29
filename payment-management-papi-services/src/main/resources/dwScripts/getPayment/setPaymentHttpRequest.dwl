%dw 2.0
output application/json
var paymentId = vars.paymentMethod match {
    case "payu" -> { "id": vars.paymentId }
    case "wompi" -> { "transaction_id": vars.paymentId}
    case "pse" ->  { "id": vars.paymentId }
    else -> ""
}
---
{
	"host": p(vars.paymentMethod ++ '-sapi.host'),
	"port": p(vars.paymentMethod ++ '-sapi.port'),
	"basepath": p(vars.paymentMethod ++ '-sapi.basepath'),
	"method": p(vars.paymentMethod ++ '-sapi.getPayment.method'),
	"path": p(vars.paymentMethod ++ '-sapi.getPayment.path'),
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