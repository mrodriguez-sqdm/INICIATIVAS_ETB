%dw 2.0
output application/json
---
{
	method: p('pse.putTransaction.method'),
	path: p('pse.putTransaction.path')
}