%dw 2.0
output application/json

var method = (lower(payload.gateway default ""))

// normalización del nombre del sistema
var systemKey =
    if (method == "etb") "mongo"
    else method

var configKey = systemKey ++ "-sapi"

var paymentId = { id: attributes.uriParams.paymentId }

---
{
    "host": p(configKey ++ ".host"),
    "port": p(configKey ++ ".port"),
    "basepath": p(configKey ++ ".basepath"),
    "method": p(configKey ++ ".patchPayment.method"),
    "path": p(configKey ++ ".patchPayment.path"),
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