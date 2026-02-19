%dw 2.0
output application/json
---
{
	method: p('wompi.getBanks.method'),
	path: p('wompi.getBanks.path')
}