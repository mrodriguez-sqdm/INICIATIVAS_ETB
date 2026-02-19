%dw 2.0
output application/json
---
{
	"transactionId": vars.paymentId,
	"status": payload.data.state,
	"description": payload.description,
	"reference": payload.reference,
	"amount": payload.amount,
	"currency": payload.currency,
	"createdAt": if ( !isEmpty(payload.data) ) payload.data.operationDate as DateTime {
		unit: "milliseconds"
	} as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	} else null,
	"platformData": payload.data
}