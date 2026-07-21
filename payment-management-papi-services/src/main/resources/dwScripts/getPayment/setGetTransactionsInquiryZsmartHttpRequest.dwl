%dw 2.0
output application/json
---
{
    "host": p("zsmart-sapi.host"),
    "port": p("zsmart-sapi.port"),
    "basepath": p("zsmart-sapi.basepath"),
    "method": p("zsmart-sapi.getTransactionsInquiry.method"),
    "path": p("zsmart-sapi.getTransactionsInquiry.path"),
    "headers": {
        "client_id": p("secure::app.credentials.clientId"),
        "client_secret": p("secure::app.credentials.clientSecret"),
        "X-CORRELATION-ID": attributes.headers.'x-correlation-id',
        "name": attributes.headers.name,
        "systemId": attributes.headers.systemId,
        "source": attributes.headers.source
        },
	queryParams: attributes.queryParams default {}
}
