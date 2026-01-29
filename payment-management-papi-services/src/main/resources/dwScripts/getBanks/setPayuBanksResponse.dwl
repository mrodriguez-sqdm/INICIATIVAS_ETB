%dw 2.0
output application/json
---
payload.data map ((item, index) -> {
	bankId: item.id,
	bankDescription: item.description,
	bankCode: item.pseCode
})