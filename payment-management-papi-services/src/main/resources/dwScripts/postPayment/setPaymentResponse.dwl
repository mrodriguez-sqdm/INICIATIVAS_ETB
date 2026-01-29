%dw 2.0
import dwScripts::commons::common
output application/json
---
{
	"status": "success",
	"data": {
		"mongoResponse": common::camelizeData(vars.mongoResponse),
		"platformResponse": common::camelizeData(vars.sapiResponse)
	} 
	
}