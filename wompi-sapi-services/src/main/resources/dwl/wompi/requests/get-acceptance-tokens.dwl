%dw 2.0
output application/json
---
{
	method: p('wompi.getAcceptanceTokens.method'),
	path: p('wompi.getAcceptanceTokens.path'),
	uriParams: {
		merchant_public_key: Mule::p('secure::wompi.auth.public_key')
	}
}