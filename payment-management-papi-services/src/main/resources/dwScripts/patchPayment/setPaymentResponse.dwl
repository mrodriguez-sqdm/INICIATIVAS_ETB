%dw 2.0
import dwScripts::commons::common
output application/json
---
{
	"status": "success",
	"data": common::camelizeData(payload)	
}