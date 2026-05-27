%dw 2.0
var operateModify = "M"
var serviceEventId = "802"
var currency = "1"
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
		salesChannel: payload.transaction.salesChannel as Number
	},
	cust: {
		operate: operateModify,
		custId: customerId,
		firstName: payload.customer.firstName,
		lastName: payload.customer.lastName,
		email: payload.customer.email,
		contactPhone: payload.customer.contactPhone,
		country: payload.customer.country,
		department: payload.customer.department,
		city: payload.customer.city,
		address: payload.customer.address,
		habeasData: payload.customer.habeasData,
		paymentRiskLevel: payload.customer.paymentRiskLevel,
		blockNotification: payload.customer.blockNotification,
		(contactDtoList: payload.customer.contacts map ((item, index) -> {
			contactType: item.contactType,
			operate: operateModify,
			contactId: item.contactId,
			firstName: item.firstName,
			lastName: item.lastName,
			email: item.email,
			mobilePhone: item.mobilePhone
		})) if (!isEmpty(payload.customer.contacts default []))
	}
}