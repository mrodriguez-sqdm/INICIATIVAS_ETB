%dw 2.0
output application/json
var pqrResponse = (vars.pqrUpdateType) match {
	case "activity" -> payload.body.Set_PQR_ActividadesResponse.Set_PQR_ActividadesResult.WSResponseBody
	case "characteristics" -> payload.body.Set_PQR_CaracteristicasResponse.Set_PQR_CaracteristicasResult.WSResponseBody
	case "status" -> payload.body.Set_PQRResponse.Set_PQRResult.WSResponseBody
	case "user" -> payload.body.Set_PQRResponse.Set_PQRResult.WSResponseBody
	else -> {}
}
---
{
	"code": "201",
	"message": "PQR actualizada correctamente",
	"pqr": {
		"id": vars.pqrId,
		"operationResult": pqrResponse.OperationResult,
		"operationResultDescription": pqrResponse.OperationResultDesc
	}
}