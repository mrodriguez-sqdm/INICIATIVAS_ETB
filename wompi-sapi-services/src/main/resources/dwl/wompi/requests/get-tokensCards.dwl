%dw 2.0
output application/json
---
{
	method: p('wompi.getTokensCards.method'),
	path: p('wompi.getTokensCards.path')
}