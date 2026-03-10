%dw 2.0
output application/json
---
{
	"host": p('billingPapi.host'),
	"port": p('billingPapi.port'),
	"basepath": p('billingPapi.basepath'),
	"method": p('billingPapi.postBillingAccounts.method'),
	"path": p('billingPapi.postBillingAccounts.path'),
	"headers": {
		"client_id": p('secure::billingPapi.credentials.clientId'),
		"client_secret": p('secure::billingPapi.credentials.clientSecret'),
		"X-CORRELATION-ID": payload.body.CreateSystemsAccountsIN.WSRequestHeader2.System.correlationID default correlationId,
		"name": payload.body.CreateSystemsAccountsIN.WSRequestHeader2.System.name,
		"systemId": p('billingPapi.systemId'),
		"source": payload.body.CreateSystemsAccountsIN.WSRequestHeader2.System.name
	}
}