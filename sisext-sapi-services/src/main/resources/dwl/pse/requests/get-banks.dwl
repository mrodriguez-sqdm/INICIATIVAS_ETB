%dw 2.0
output application/json
---
{
	method: p('pse.getBanks.method'),
	path: p('pse.getBanks.path')
}