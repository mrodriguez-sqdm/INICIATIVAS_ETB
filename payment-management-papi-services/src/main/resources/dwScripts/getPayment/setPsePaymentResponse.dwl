%dw 2.0
output application/json
---
{
	"transactionId": vars.paymentId,
	"status": payload.returnCode,
	"description": payload.paymentDescription,
	"reference": payload.referenceNumber1,
	"amount": payload.transactionValue,
	"currency": payload.currency default 'COP',
	"createdAt": if ( !isEmpty(payload) ) payload.soliciteDate as DateTime {
		unit: "milliseconds"
	} as String {
		format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	} else null,
	"platformData": payload
}