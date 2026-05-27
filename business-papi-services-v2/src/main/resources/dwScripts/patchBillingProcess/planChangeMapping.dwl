%dw 2.0
var operateAdd = "A"
var operateDelete = "D"
var operateModify = "M"
var serviceEventId = "329"
var currency = "1"
var serviceInstanceId = payload.service.externalId as Number
output application/json  skipNullOn = "everywhere"
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
	billProdInstList: [{
		billProdInst: {
			operate: operateModify,
			prodInstId: serviceInstanceId,
			areaCode: payload.service.areaCode,
			serviceNumber: payload.service.serviceNumber,
			effDate: payload.service.effectiveDate,
			offerCode: payload.service.offerCode
		}
	}],
	billOfferInstList: [{
		billOfferInst: {
			operate: operateDelete,
			offerInstId: payload.service.currentOfferInstanceId,
			offerCode: payload.service.currentOfferCode,
			instanceId: serviceInstanceId
		}
	},
    {
		billOfferInst: {
			operate: operateAdd,
			offerInstId: payload.service.newOfferInstanceId,
			offerCode: payload.service.newOfferCode,
			effDate: payload.service.effectiveDate,
			expDate: payload.service.offerExpirationDate,
			instanceId: serviceInstanceId
		}
	}],
	(chargeList: payload.service.charges map ((item, index) -> {
		charge: {
			prodInstId: serviceInstanceId,
			(acctId: payload.account.externalId as Number) if(payload.account.externalId?),
			chargeType: item."type"  match {
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
	})) if (!isEmpty(payload.service.charges default [])),
}