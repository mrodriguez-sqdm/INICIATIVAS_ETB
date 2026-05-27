%dw 2.0
var operateModify = "M"
var serviceEventId = "803"
var currency = "1"
var customerId = payload.customer.externalId as Number
var accountId = payload.account.externalId as Number
output application/json  skipNullOn = "everywhere"
---
{
	header: {
		transactionId: payload.transaction.id,
		createDate: payload.transaction.timestamp,
		orderItemId: payload.transaction.orderItemId,
		serviceEventId: serviceEventId,
		custId: customerId,
		acctId: accountId,
		salesChannel: payload.transaction.salesChannel
	},
	account: {
		operate: operateModify,
		acctId: accountId,
		acctName: payload.account.acctName,
		billDeliveryType: payload.account.billDeliveryType,
		billFlag: payload.account.billFlag,
		dunningExemption: payload.account.dunningExemption,
		contractName: payload.account.contractName,
		country: payload.account.country,
		department: payload.account.department,
		city: payload.account.city,
		address: payload.account.address,
		(contactDtoList: payload.customer.contacts map ((item, index) -> {
			contactType: item.contactType,
			operate: operateModify,
			contactId: item.contactId,
			firstName: item.firstName,
			lastName: item.lastName,
			email: item.email,
			mobilePhone: item.mobilePhone
		})) if (!isEmpty(payload.customer.ccontacts default []))
	}
}