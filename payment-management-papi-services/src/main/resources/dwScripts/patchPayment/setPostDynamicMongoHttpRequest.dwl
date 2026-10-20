%dw 2.0
output application/json
---
{
    "host": p("mongo-sapi.host"),
    "port": p("mongo-sapi.port"),
    "basepath": p("mongo-sapi.basepath"),
    "method": p("mongo-sapi.postDynamicQueryAutoG.method"),
    "path": p("mongo-sapi.postDynamicQueryAutoG.path"),
    "headers": {
        "client_id": p("secure::app.credentials.clientId"),
        "client_secret": p("secure::app.credentials.clientSecret"),
        "X-CORRELATION-ID": vars.headersRequest.'x-correlation-id',
        "name": vars.headersRequest.name,
        "systemId": vars.headersRequest.systemId,
        "source": vars.headersRequest.source
        }
}