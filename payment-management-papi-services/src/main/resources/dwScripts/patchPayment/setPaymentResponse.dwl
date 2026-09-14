%dw 2.0
output application/json

var isSuccess = payload.code == "SUCCESS"

var resultObj = {
    (cus: payload.trazabilityCode) if (payload.trazabilityCode? and payload.trazabilityCode != null),
    (statusTransaction: payload.estado) if (payload.estado? and payload.estado != null)
}

---
{
  code: if (isSuccess) "200" else "500",
  message:
    if (isSuccess)
      "Transaction retrieved successfully"
    else
      (payload.message.message default payload.message),
  status:
    if (isSuccess)
      "SUCCESS"
    else
      "FAILED",
  (result: resultObj) if (!isEmpty(resultObj))
}