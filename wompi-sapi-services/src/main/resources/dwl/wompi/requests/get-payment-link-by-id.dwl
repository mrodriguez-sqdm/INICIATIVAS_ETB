%dw 2.0
output application/json
---
{
	method: p('wompi.getPaymentLinkById.method'),
	path: p('wompi.getPaymentLinkById.path'),
	uriParams: {
		payment_link_id: attributes.uriParams.payment_link_id
	}
}