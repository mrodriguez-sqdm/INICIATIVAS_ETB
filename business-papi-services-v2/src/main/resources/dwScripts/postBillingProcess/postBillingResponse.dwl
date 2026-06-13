%dw 2.0
output application/json  skipNullOn = "everywhere"
---
{
  "transactionId": correlationId,
  "processCode": vars.processCode,
  "status": upper(payload.message) default "SUCCESS",
  "createdAt": now() as String {format: "YYYY-MM-dd HH:mm:ss"},
  "result": {
    "zsmartResponseCode": payload.result.responseCode,
    "zsmartMessage": payload.result.responseMessage,
    "transactionId": payload.result.transactionId,
    "customerId": payload.result.custId,
    "accountId": payload.result.acctId,
    "serviceId": vars.serviceId
  }
}