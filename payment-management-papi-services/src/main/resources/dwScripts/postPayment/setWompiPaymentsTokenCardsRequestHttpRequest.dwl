%dw 2.0
output application/java
---
{
	"host": p("wompi-sapi.host"),
	"port": p("wompi-sapi.port"),
	"basepath": p("wompi-sapi.basepath"),
	"method": p("wompi-sapi.postTokenCards.method"),
	"path": p("wompi-sapi.postTokenCards.path"),
	"headers": {
		"client_id": p('secure::app.credentials.clientId'),
		"client_secret": p('secure::app.credentials.clientSecret'),
		"X-CORRELATION-ID": attributes.headers.'x-correlation-id' default correlationId,
		"name": attributes.headers.name,
		"systemId": attributes.headers.systemId,
		"source": attributes.headers.source
	}
}