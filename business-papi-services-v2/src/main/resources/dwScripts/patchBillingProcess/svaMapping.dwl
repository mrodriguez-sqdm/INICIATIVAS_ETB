%dw 2.0
var operateAdd = "A"
var operateDelete = "D"
var serviceEventId = "189"
var currency = "1"
var serviceInstanceId = payload.service.externalId as Number
var customerId = payload.customer.externalId as Number
output application/json  skipNullOn = "everywhere"
---
{
	header: {
		transactionId: payload.transaction.id,
		createDate: payload.transaction.timestamp,
		orderItemId: payload.transaction.orderItemId,
		serviceEventId: serviceEventId,
		custId: customerId,
		prodInstId: serviceInstanceId,
		salesChannel: payload.transaction.contactChannel as Number
	},
	billOfferInstList: [({
		billOfferInst: {
			operate: operateAdd,
			offerInstId: payload.service.additions[0].offerInstanceId,
			offerCode: payload.service.additions[0].offerCode,
			effDate: payload.service.effectiveDate,
			instanceId: serviceInstanceId
		}
	}) if(!isEmpty(payload.service.additions default [])),
    ({
		billOfferInst: {
			operate: operateDelete,
			offerInstId: payload.service.removals[0].offerInstanceId,
			offerCode: payload.service.removals[0].offerCode,
			instanceId: serviceInstanceId
		}
	}) if(!isEmpty(payload.service.removals default []))],
	(chargeList: payload.service.charges map ((item, index) -> {
		charge: {
			prodInstId: serviceInstanceId,
			chargeType: item."type"   match {
				case "ONE_OFF" -> "1"
                case "INSTALLMENT" -> "5"
                case "ADVANCE" -> "7"
                else -> "1"
			},
			basicCharge: item.amount,
			acctItemTypeCode: item.itemTypeCode,
			currencyId: currency,
			paidFlag: item.paidFlag default "N"
		}
	})) if (!isEmpty(payload.service.charges default []))
}