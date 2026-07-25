%dw 2.0
var serviceEventId = "804"
var transaction = payload.transaction
var customer = payload.customer default {
}
var account = payload.account default {
}
var charges = payload.charges  default []
var serviceNumber = transaction.serviceNumber
var operation = "M"
var currency = "1"
output application/json  skipNullOn = "everywhere"
---
{
	"transactionId": transaction.id,
	"createDate": transaction.timestamp,
	"orderItemId": transaction.orderItemId,
	"custId": transaction.custId,
	"acctId": transaction.acctId,
	"serviceNumber": serviceNumber,
	"prodInstId": transaction.prodInstId,
	"salesChannel": transaction.salesChannel,
	"salesDepartment": transaction.salesDepartment,
	"salesCity": transaction.salesCity,
	"po": transaction.po,
	"billType": transaction.billType,
	"comments": transaction.comments,
	("chargeList": charges default [] map (charge) -> {
		"billingNbr": charge.billingNbr,
		"basicCharge": charge.basicCharge,
		"acctId": charge.acctId default transaction.acctId,
		"chargeType": charge."type",
		"perCharge": charge.perCharge,
		"acctItemTypeCode": charge.acctItemTypeCode,
		"installmentPlanId": charge.installmentPlanId,
		"prodInstFlag": charge.prodInstFlag,
		"origAcctItemTypeCode": charge.origAcctItemTypeCode,
		"currencyId": currency
	}) if (!isEmpty(flatten(charges default [])))
}