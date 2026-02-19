%dw 2.0
import modules::common
output application/json
var body = common::camelizeData(payload)
---
{
	status: "success",
	data: body.data
}