%dw 2.0
import modules::common
output application/json
var body = common::camelizeData(payload)
var wompiUrl = { "wompiUrl": p('wompi.checkoutUrl') ++ payload.data.id }
---
{
	status: "success",
	data: body.data ++ wompiUrl
}