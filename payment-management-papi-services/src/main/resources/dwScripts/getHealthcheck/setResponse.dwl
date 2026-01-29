%dw 2.0
output application/json
---
{
	"status": "running",
	"data": {
		"apiName": Mule::p('app.name'),
		"apiVersion": Mule::p('app.version'),
		"statusDate": now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS z"},
	}
}