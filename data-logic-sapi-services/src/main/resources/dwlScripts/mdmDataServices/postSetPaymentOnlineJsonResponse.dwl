%dw 2.0
output application/json skipNullOn = "everywhere"
var result = payload.body.Set_PaymentOnLineResponse.Set_PaymentOnLineResult
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
		properties: header.property.*Property map (item) -> {
			name: item.name,
			value: item.value
		}
	},
	body: {
		operationResult: body.OperationResult,
		operationResultDescription: body.OperationResultDesc
	}
}
