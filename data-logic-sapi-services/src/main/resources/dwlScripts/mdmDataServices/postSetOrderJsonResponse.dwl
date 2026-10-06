%dw 2.0
output application/json skipNullOn = "everywhere"
var result = payload.body.Set_OrderResponse.Set_OrderResult
var header = result.WSResponseHeader
var body = result.WSResponseBody
---
{
	header: {
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
		properties: header.property.*Property map {
			name: $.name,
			value: $.value
		}
	},
	body: {
		databaseId: body.database_id,
		operationResult: body.OperationResult,
		operationResultDescription: body.OperationResultDesc,
		mongoId: body.mongo_id
	}
}