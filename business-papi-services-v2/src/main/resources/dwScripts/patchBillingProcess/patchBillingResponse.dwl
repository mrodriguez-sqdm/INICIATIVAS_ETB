%dw 2.0
output application/json  skipNullOn = "everywhere"
---
{
  "transactionId": correlationId,
  "status": upper(payload.message) default "SUCCESS",
  "updatedAt": now() as String {format: "YYYY-MM-dd HH:mm:ss"},
  "result": {
    "zsmartResponseCode": payload.result.result.responseCode,
    "zsmartMessage": payload.result.result.responseMessage,
    "transactionId": payload.result.result.transactionId,
    "customerId": payload.result.result.custId,
    "accountId": payload.result.result.acctId,
    "serviceId": vars.serviceId,
    "contacts": payload.result.result.contactList
  }
}