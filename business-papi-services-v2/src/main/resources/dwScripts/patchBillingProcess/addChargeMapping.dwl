%dw 2.0
var serviceEventId = "804"
var currency = "1"
var serviceInstanceId = payload.service.externalId as Number
var customerId = payload.customer.externalId as Number
var accountId = payload.account.externalId as Number
output application/json  skipNullOn="everywhere"
---
{

  header: {
    transactionId: payload.transaction.id,
    createDate: payload.transaction.timestamp,
    orderItemId: payload.transaction.orderItemId,
    serviceEventId: serviceEventId,
    custId: customerId,
    prodInstId: serviceInstanceId,
    acctId: accountId,
    salesChannel: payload.transaction.contactChannel as Number,
    salesDepartment: payload.transaction.salesDepartment,
    salesCity: payload.transaction.salesCity
  },
  (chargeList: payload.charges map ((item, index) -> {
    charge: {
      prodInstId: serviceInstanceId,
      custId: customerId,
      acctId: accountId,
      chargeType: item."type" match {
        case "ONE_OFF" -> "1"
        case "INSTALLMENT" -> "5"
        case "ADVANCE" -> "7"
        else -> "1"
      },
      basicCharge: item.amount,
      acctItemTypeCode: item.itemTypeCode,
      currencyId: currency,
      paidFlag: item.paidFlag,
      billingNbr: payload.service.serviceNumber
    }
  })) if (!isEmpty(payload.charges default []))
}