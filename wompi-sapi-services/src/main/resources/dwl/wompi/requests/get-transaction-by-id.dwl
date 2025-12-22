%dw 2.0
output application/java
---
{
	transactionId: attributes.uriParams.transaction_id
}