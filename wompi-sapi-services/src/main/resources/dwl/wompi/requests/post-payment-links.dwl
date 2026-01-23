%dw 2.0
output application/json
---
{
	method: p('wompi.postPaymentLinks.method'),
	path: p('wompi.postPaymentLinks.path')
}