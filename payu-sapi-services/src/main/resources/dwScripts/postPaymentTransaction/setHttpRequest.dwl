%dw 2.0
output application/json
---
{
	"host": p('payu.host'),
	"method": p('payu.postPaymentTransaction.method'),
	"path": p('payu.paymentsService'),
	"headers": {
		"Accept": "application/json"
	}
}