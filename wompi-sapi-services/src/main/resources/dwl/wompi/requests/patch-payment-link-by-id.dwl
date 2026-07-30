%dw 2.0
output application/json
---
{
	method: p('wompi.patchPaymentLinkById.method'),
	path: p('wompi.patchPaymentLinkById.path'),
	uriParams: {
		payment_link_id: attributes.uriParams.payment_link_id
	}
}