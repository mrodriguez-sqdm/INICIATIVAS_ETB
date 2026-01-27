%dw 2.0
output application/json
---
{
	method: p('pse.postTransaction.method'),
	path: p('pse.postTransaction.path')
}