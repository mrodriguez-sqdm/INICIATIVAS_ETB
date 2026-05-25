%dw 2.0
output application/json
---
{
	"code": "200",
	"message": "operacion exitosa",
	"data": payload.transactionResponse
}