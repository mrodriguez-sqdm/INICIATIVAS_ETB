%dw 2.0
import dwScripts::commons::common
output application/json
---
{
	"code": "200",
	"message": "operacion exitosa",
	"data":  common::camelizeData(vars.sapiResponse.data)
}

