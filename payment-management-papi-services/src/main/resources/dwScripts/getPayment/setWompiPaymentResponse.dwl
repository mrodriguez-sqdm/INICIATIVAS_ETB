%dw 2.0
output application/json
---
{
	"id": payload.data.id,
	"description": payload.data.description,
	"sku": payload.data.sku,
	"amount": payload.data.amountInCents,
	"currency": payload.data.currency,
	"createdAt": payload.data.createdAt,
	"expiresAt": payload.data.expiresAt,
	"wompiUrl": "https://checkout.wompi.co/l/" ++ payload.data.id
}