%dw 2.0
var operateAdd = "A"
var operateDelete = "D"
var operateModify = "M"
var serviceEventId = "805"
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
		salesChannel: payload.transaction.salesChannel
	},
	billProdInst: {
		operate: operateModify,
		prodInstId: serviceInstanceId,
		areaCode: payload.service.areaCode,
		serviceNumber: payload.service.serviceNumber,
		effDate: payload.service.effectiveDate,
		Department: payload.service.department,
		City: payload.service.city,
		Address: payload.service.address,
		socialLevel: payload.service.socialLevel,
		offerCode: payload.service.offerCode
	},
	billOfferInstList: [{
		billOfferInst: {
			operate: operateDelete,
			offerInstId: payload.service.currentOfferInstanceId as Number,
			offerCode: payload.service.currentOfferCode,
			instanceId: serviceInstanceId
		}
	},
    {
		billOfferInst: {
			operate: operateAdd,
			offerInstId: payload.service.newOfferinstanceId as Number,
			offerCode: payload.service.newOfferCode,
			effDate: payload.service.effectiveDate,
			expDate: payload.service.offerExpirationDate,
			instanceId: serviceInstanceId
		}
	}]
}