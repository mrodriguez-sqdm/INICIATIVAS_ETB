%dw 2.0
output application/json
---
{
	method: p("wompi.patchTransactionById.method"),
	path: p('wompi.patchTransactionById.path'),
	uriparams: {
		transaction_id: attributes.uriParams.transaction_id
	}
}