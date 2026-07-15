%dw 2.0
output application/json
---
{
    "host": p("zsmart-sapi.host"),
    "port": p("zsmart-sapi.port"),
    "basepath": p("zsmart-sapi.basepath"),
    "method": p("zsmart-sapi.postPayment.method"),
    "path": p("zsmart-sapi.postPayment.path"),
    "headers": {
        "client_id": p("secure::app.credentials.clientId"),
        "client_secret": p("secure::app.credentials.clientSecret"),
        "X-CORRELATION-ID": vars.headersRequest.'x-correlation-id',
        "name": vars.headersRequest.name,
        "systemId": vars.headersRequest.systemId,
        "source": vars.headersRequest.source
        }
}