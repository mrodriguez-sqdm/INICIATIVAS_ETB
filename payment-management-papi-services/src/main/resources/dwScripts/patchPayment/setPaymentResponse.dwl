%dw 2.0
output application/json
var isSuccess =
    (payload.returnCode? and payload.returnCode == "SUCCESS") 
    or 
    (payload.response.result.code? and payload.response.result.code == "SUCCESS")

var resultObj = {
    (cus: payload.trazabilityCode) if (payload.trazabilityCode? and payload.trazabilityCode != null),
    (statusTransaction: payload.estado) if (payload.estado? and payload.estado != null)
}

---
{
  code: "200",
  message:
    if (isSuccess)
      "Transaction retrieved successfully"
    else
      payload.returnCode,
  status:
    if (isSuccess)
      "SUCCESS"
    else
      "FAILED",
  (result: resultObj) if (!isEmpty(resultObj))
}