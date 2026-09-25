%dw 2.0
output application/json
---
{
    "host": p("dataLogicSapi.host"),
    "port": p("dataLogicSapi.port"),
    "basepath": p("dataLogicSapi.basePath"),
    "method": p("dataLogicSapi.paymentsOnline.post.method"),
    "path": p("dataLogicSapi.paymentsOnline.path"),
    "headers": {
        "client_id": p("secure::app.credentials.clientId"),
        "client_secret": p("secure::app.credentials.clientSecret"),
        "X-CORRELATION-ID": vars.headersRequest.'x-correlation-id',
        "name": vars.headersRequest.name,
        "systemId": vars.headersRequest.systemId,
        "source": vars.headersRequest.source
        }
}