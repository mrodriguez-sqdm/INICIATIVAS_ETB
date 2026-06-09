%dw 2.0
output application/json
var pqrResponse = payload.body.Set_PQRResponse.Set_PQRResult.WSResponseBody
---
{
	"code": "200",
	"message": "PQR Creada correctamente",
	"pqr": {
		"databaseId": pqrResponse.database_id,
		"operationResult": pqrResponse.OperationResult,
		"operationResultDescription": pqrResponse.OperationResultDesc,
		"mongoId": pqrResponse.mongo_id
	}
}