%dw 2.0
output application/json
---
{
    "host": p("azure-sapi.host"),
    "port": p("azure-sapi.port"),
    "basepath": p("azure-sapi.basepath"),
    "method": p("azure-sapi.postPaymentEvent.method"),
    "path": p("azure-sapi.postPaymentEvent.path"),
    "headers": {
        "client_id": p("secure::app.credentials.clientId"),
        "client_secret": p("secure::app.credentials.clientSecret"),
        "X-CORRELATION-ID": vars.headersRequest.'x-correlation-id',
        "name": vars.headersRequest.name,
        "systemId": vars.headersRequest.systemId,
        "source": vars.headersRequest.source
        }
}