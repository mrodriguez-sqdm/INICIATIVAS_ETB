%dw 2.0
output application/json
---
{
	estado: payload.data.transaction.status
}