%dw 2.0
output application/json  skipNullOn = "everywhere"
---
{
  "transactionId": correlationId,
  "status": upper(payload.message) default "SUCCESS",
  "updatedAt": now() as String {format: "YYYY-MM-dd HH:mm:ss"},
  "result": {
    "zsmartResponseCode": payload.result.responseCode,
    "zsmartMessage": payload.result.responseMessage,
    "transactionId": payload.result.transactionId,
    "customerId": payload.result.custId,
    "accountId": payload.result.acctId,
    "serviceId": vars.serviceId,
    "contacts": payload.result.contactList
  }
}