%dw 2.0
output application/java
---
(vars.pqrUpdateType) match {
	case "activity" -> {
		result: (payload.body.Set_PQR_Actividades_PQRResponse.Set_PQR_Actividades_PQRResult.WSResponseBody.OperationResult default 9999) as Number,
		resultDesc: (payload.body.Set_PQR_Actividades_PQRResponse.Set_PQR_Actividades_PQRResult.WSResponseBody.OperationResultDesc default "Web Service Error Set_PQR_Actividades") as String
	}
	case "characteristics" -> {
		result: (payload.body.Set_PQR_CaracteristicasResponse.Set_PQR_CaracteristicasResult.WSResponseBody.OperationResult default 9999) as Number,
		resultDesc: (payload.body.Set_PQR_CaracteristicasResponse.Set_PQR_CaracteristicasResult.WSResponseBody.OperationResultDesc default "Web Service Error Set_PQR_Caracteristicas") as String
	}
	case "status" -> {
		result: (payload.body.Set_PQRResponse.Set_PQRResult.WSResponseBody.OperationResult default 9999) as Number,
		resultDesc: (payload.body.Set_PQRResponse.Set_PQRResult.WSResponseBody.OperationResultDesc default "Web Service Error Set_PQR (status)") as String
	}
	case "user" -> {
		result: (payload.body.Set_PQRResponse.Set_PQRResult.WSResponseBody.OperationResult default 9999) as Number,
		resultDesc: (payload.body.Set_PQRResponse.Set_PQRResult.WSResponseBody.OperationResultDesc default "Web Service Error Set_PQR (user)") as String
	}
	else -> {
		result: 1,
		resultDesc: "Internal Web Service Error"
	}
}