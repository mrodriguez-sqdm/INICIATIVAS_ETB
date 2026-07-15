%dw 2.0
var serviceEventId = "803"
var transaction = payload.transaction
var account = payload.account default {
}
var services = payload.services default []
var operation = "M"
var currency = "1"
output application/json  skipNullOn = "everywhere"
---
{
	// Header Mapping
	"header": {
		"transactionId": transaction.id,
		"createDate": transaction.timestamp,
		"orderItemId": transaction.orderItemId,
		"serviceEventId": serviceEventId,
		"custId": transaction.custId,
		"acctId": transaction.acctId,
		"salesChannel": transaction.salesChannel,
		"salesDepartment": transaction.salesDepartment,
		"salesCity": transaction.salesCity,
		"po": transaction.po,
		"billType": transaction.billType,
		"comments": transaction.comments
	},
	// Account Mapping
	("account": {
		"operate": operation,
		"acctId": account.acctId default transaction.acctId,
		"acctName": account.acctName,
		"billDeliveryType": account.billDeliveryType,
		"paymentMode": account.paymentMode,
		"corte": account.corte,
		"defaultAccount": account.defaultAccount,
		"parentAccountId": account.parentaccountId,
		"billFlag": account.billFlag,
		"taxExempt": account.taxExempt,
		"dunningExemption": account.dunningExemption,
		"dunningExemEff": account.dunningExemEff,
		"dunningExemExp": account.dunningExemExp,
		"contractName": account.contractName,
		"roundingAdjustmentFlag": account.roundingAdjustmentFlag,
		"previousBalanceFlag": account.previousBalanceFlag,
		"coverPageOnlyFlag": account.coverPageOnlyFlag,
		"interestChargeFlag": account.interestChargeFlag,
		"interestRateType": account.interestRateType,
		"dunningManagementTime": account.dunningManagementTime,
		"country": account.country,
		"departament": account.departament,
		"city": account.city,
		"district": account.district,
		"address": account.address,
		"paymentTerm": account.paymentTerm,
		"effDate": account.effDate,
		("contactDtoList": account.contacts map ((acctContact) -> {
			"operate": acctContact.operate,
			"contactType": acctContact.contactType,
			"contactId": acctContact.contactId,
			"firstName": acctContact.firstName,
			"lastName": acctContact.lastName,
			"email": acctContact.email,
			"sms": acctContact.sms,
			"mobilePhone": acctContact.mobilePhone,
			"whatsapp": acctContact.whatsApp,
			"fixedPhone": acctContact.fixedPhone,
			"contactDocType": acctContact.contactDocType,
			"contactDocNo": acctContact.contactDocNo,
			"contactDocExpDate": acctContact.DocExpDate,
			"country": acctContact.country,
			"department": acctContact.department,
			"city": acctContact.city,
			"district": acctContact.district,
			"addressName": acctContact.addressName
		})) if (!isEmpty(account.contacts default []))
	}) if (!isEmpty(account default {
	})),
	// Account Attributes Mapping
	("acctAttrList": account.attributes map ((acctAttr) -> {
		"operate": acctAttr.operate,
		"acctId": account.acctId default transaction.acctId,
		"attrCode": acctAttr.attrCode,
		"value": acctAttr.value,
		"effDate": acctAttr.effectiveDate
	})) if (!isEmpty(account.attributes default []))
}