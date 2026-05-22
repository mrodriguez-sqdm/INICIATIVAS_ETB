%dw 2.0
output application/json skipNullOn = "everywhere"
var operateAdd = "A"
var serviceEventId = "1"
var currency = "1"
---
{
	header: {
		transactionId: payload.transaction.id,
		createdDate: payload.transaction.timestamp,
		orderItemId: payload.transaction.orderItemId,
		serviceEventId: serviceEventId,
		prodInstId: payload.service.externalId,
		salesChannel: payload.transaction.contactChannel,
		salesDepartment: payload.transaction.salesDepartment,
		salesCity: payload.transaction.salesCity
	},
	cust: {
		operate: operateAdd,
		typeFlag: payload.customer.typeFlag,
		firstName: payload.customer.firstName,
		lastName: payload.customer.lastName,
		secondLastName: payload.customer.secondLastName,
		docType: payload.customer.docType,
		docNumber: payload.customer.docNumber,
		contactPhone: payload.customer.contactPhone,
		email: payload.customer.email,
		country: payload.customer.country,
		department: payload.customer.department,
		city: payload.customer.city,
		customerSegment: payload.customer.customerSegment,
		subSegmento: payload.customer.subsegmento,
		categoria: payload.customer.categoria,
		habeasData: payload.customer.habeasData,
		paymentRiskLevel: payload.customer.paymentRiskLevel,
		blockNotification: payload.customer.blockNotifications
	},
	account: {
		operate: operateAdd,
		billingDeliveryType: payload.account.billDeliveryType,
		corte: payload.account.corte,
		billFlag: payload.account.billFlag,
		country: payload.account.country,
		department: payload.account.department,
		city: payload.account.city
	},
	(chargeList: payload.service.charges map ((item, index) -> {
		charge: {
			prodInstId: payload.service.externalId as Number,
			acctId: payload.account.externalId as Number,
			chargeType: item."type"  match {
				case "ONE_OFF" -> "1"
                case "ADVANCE" -> "7"
                else -> "1"
			},
			basicCharge: item.amount,
			acctItemTypeCode: item.itemTypeCode,
			currencyId: currency,
			paidFlag: item.paidFlag default "N"
		}
	})) if (!isEmpty(payload.service.charges default [])),
	billProdInstList: [{
		billProdInst: {
			operate: operateAdd,
			prodInstId: payload.service.externalId as Number,
			areaCode: payload.service.areaCode,
			serviceNumber: payload.service.serviceNumber,
			effDate: payload.service.effectiveDate,
			offerCode: payload.service.offerCode,
			department: payload.service.department,
			city: payload.service.city,
			address: payload.service.address
		}
	}],
	billOfferInstList: [{
		billOfferInst: {
			operate: operateAdd,
			offerInstId: payload.service.offerInstanceId,
			offerCode: payload.service.offerCode,
			effDate: payload.service.effectiveDate,
			expDate: payload.service.offerExpirationDate,
			instanceId: payload.service.externalId as Number
		}
	}]
}