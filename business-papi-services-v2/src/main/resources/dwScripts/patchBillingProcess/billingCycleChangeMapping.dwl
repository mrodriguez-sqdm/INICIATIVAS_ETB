%dw 2.0
var operateModify = "M"
var serviceEventId = "234"
var currency = "1"
var accountId = payload.account.externalId as Number
output application/json  skipNullOn="everywhere"
---
{
  header: {
    transactionId: payload.transaction.id,
    createDate: payload.transaction.timestamp,
    orderItemId: payload.transaction.orderItemId,
    serviceEventId: serviceEventId,
    custId: payload.customer.externalId as Number,
    acctId: accountId,
    salesChannel: payload.transaction.salesChannel
  },
  account: {
    operate: operateModify,
    acctId: accountId,
    corte: payload.account.corte,
    effDate: payload.account.effectiveDate
  }
}