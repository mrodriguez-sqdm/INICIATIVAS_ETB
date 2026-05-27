%dw 2.0
var operateModify = "M"
var serviceEventId = "28"
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
    salesChannel: payload.transaction.contactChannel as Number,
  },
  billProdInst: {
    operate: operateModify,
    prodInstId: serviceInstanceId,
    areaCode: payload.service.areaCode,
    serviceNumber: payload.service.serviceNumber,
    effDate: payload.service.effectiveDate
  }
}