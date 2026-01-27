%dw 2.0
output application/x-www-form-urlencoded
---
{
	client_id: p('secure::pse.auth.client_id'),
	client_secret: p('secure::pse.auth.client_secret')
}