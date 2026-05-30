%dw 2.0
var operateModify = "M"
var serviceEventId = "32"
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
    salesChannel: payload.transaction.contactChannel as Number
  },
  billProdInst: {
    operate: operateModify,
    prodInstId: serviceInstanceId,
    areaCode: payload.service.areaCode,
    areaCodeNew: payload.service.newNumber.areaCode,
    serviceNumberNew: payload.service.newNumber.serviceNumber,
    areaCodeOld: payload.service.areaCode,
    serviceNumberOld: payload.service.serviceNumber,
    effDate: payload.service.effectiveDate
  },
  (chargeList: payload.service.charges map ((item, index) -> {
    charge: {
      prodInstId: serviceInstanceId,
      chargeType: item."type" match {
        case "ONE_OFF" -> "1"
        case "INSTALLMENT" -> "5"
        case "ADVANCE" -> "7"
        else -> "1"
      },
      basicCharge: item.amount,
      acctItemTypeCode: item.itemTypeCode,
      currencyId: currency,
      paidFlag: item.paidFlag
    }
  })) if (!isEmpty(payload.service.charges default []))
}