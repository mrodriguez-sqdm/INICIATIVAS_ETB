%dw 2.0
var operateModify = "M"
var serviceEventId = "67"
var currency = "1"
var serviceInstanceId = payload.service.externalId as Number
output application/json  skipNullOn="everywhere"
---
{
  header: {
    transactionId: payload.transaction.id,
    createDate: payload.transaction.timestamp,
    orderItemId: payload.transaction.orderItemId,
    serviceEventId: serviceEventId,
    custId: payload.customer.externalId as Number,
    prodInstId: serviceInstanceId,
    acctId: payload.account.externalId as Number,
    salesChannel: payload.transaction.salesChannel as Number,
    newCustId: payload.customer.targetExternalId as Number,
    newAcctId: payload.account.targetExternalId as Number
  },
  billProdInst: {
    operate: operateModify,
    prodInstId: serviceInstanceId,
    areaCode: payload.service.areaCode,
    serviceNumber: payload.service.serviceNumber,
    effDate: payload.service.effectiveDate
  }
}