%dw 2.0
output application/json
---
{
	"code": "200",
	"message": "operacion exitosa",
	"data": payload.data map (item, index) -> {
		bankId: item.id,
		bankDescription: item.description,
		bankCode: item.pseCode
	}
}
