%dw 2.0
output application/json skipNullOn = "everywhere"
var result = payload.body.Set_Order_Bundle_OrdenResponse.Set_Order_Bundle_OrdenResult
var header = result.WSResponseHeader
var body = result.WSResponseBody
---
{
	responseHeader: {
		system: {
			name: header.system.name,
			correlationId: header.system.correlationId,
			processingServer: header.system.processingServer
		},
		service: {
			status: header.service.status,
			responseDate: header.service.responseDate,
			statusDetail: header.service.statusDetail
		},
		properties: header.property.*Property map (prop) -> {
			name: prop.name,
			value: prop.value
		}
	},
	responseBody: {
		databaseId: body.database_id,
		operationResult: body.OperationResult,
		operationResultDescription: body.OperationResultDesc,
		mongoId: body.mongo_id
	}
}