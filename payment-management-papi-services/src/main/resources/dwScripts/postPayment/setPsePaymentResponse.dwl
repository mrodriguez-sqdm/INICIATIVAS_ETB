%dw 2.0
output application/json

var pseResponse = vars.sapiResponse

---
{
  code: "200",
  message: "Services retrieved successfully",
  result: {
    gateway: "PSE",
    returnCode: pseResponse.returnCode default "",
    errorDetails: pseResponse.errorDetails default "",
    traceabilityCode: pseResponse.trazabilityCode default "",
    redirectUrl: pseResponse.pseURL default "",
    transactionCycle: pseResponse.transactionCycle default 0
  }
}