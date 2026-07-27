%dw 2.0
output application/json
---
{
	"host": p('payu.host'),
	"method": p('payu.getPaymentTransaction.method'),
	"path": p('payu.reportsService'),
	"headers": {
		"Accept": "application/json"
	}
}