%dw 2.0
output application/json
---
{
  code: "200",
    message:
    if (
      (payload.returnCode? and payload.returnCode == "SUCCESS") 
      or 
      (payload.response.result.code? and payload.response.result.code == "SUCCESS")
    )
      "Services retrieved successfully"
    else
      payload.returnCode,
  result: {
    (cus: payload.trazabilityCode) if (payload.trazabilityCode? and payload.trazabilityCode != null),
    (statusTransaction: payload.estado) if (payload.estado? and payload.estado != null)
  }
}