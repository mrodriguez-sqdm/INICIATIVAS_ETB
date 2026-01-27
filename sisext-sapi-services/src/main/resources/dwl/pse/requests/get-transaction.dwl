%dw 2.0
output application/json
---
{
	method: p('pse.getTransaction.method'),
	path: p('pse.getTransaction.path')
}