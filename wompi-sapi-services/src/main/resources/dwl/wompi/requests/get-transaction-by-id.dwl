%dw 2.0
output application/json
---
{
	method: p('wompi.getTransactionById.method'),
	path: p('wompi.getTransactionById.path'),
	uriParams: {
		transaction_id: attributes.uriParams.transaction_id
	}
}