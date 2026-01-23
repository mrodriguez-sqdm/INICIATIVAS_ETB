%dw 2.0
output application/json
---
{
	method: p('wompi.postTransaction.method'),
	path: p('wompi.postTransaction.path')
}