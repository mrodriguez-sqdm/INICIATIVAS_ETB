%dw 2.0
import * from dw::Runtime
output application/java
---
(vars.processCode) match {
	case "PLAN_CHANGE" -> readUrl('classpath://dwScripts/patchBillingProcess/planChangeMapping.dwl', 'text/plain')
	case "PLAN_CHANGE_BUNDLE" -> readUrl('classpath://dwScripts/patchBillingProcess/planChangeMapping.dwl', 'text/plain')
	case "ADD_CHARGE" -> readUrl('classpath://dwScripts/patchBillingProcess/addChargeMapping.dwl', 'text/plain')
	case "SVA" -> readUrl('classpath://dwScripts/patchBillingProcess/svaMapping.dwl', 'text/plain')
	case "SUSPENSION" -> readUrl('classpath://dwScripts/patchBillingProcess/suspensionMapping.dwl', 'text/plain')
	case "RESTORATION" -> readUrl('classpath://dwScripts/patchBillingProcess/restorationMapping.dwl', 'text/plain')
	case "SUSPENSION_FRAUD" -> readUrl('classpath://dwScripts/patchBillingProcess/suspensionFraudMapping.dwl', 'text/plain')
	case "RESTORATION_FRAUD" -> readUrl('classpath://dwScripts/patchBillingProcess/restorationFraudMapping.dwl', 'text/plain')
	case "NUMBER_CHANGE" -> readUrl('classpath://dwScripts/patchBillingProcess/numberChangeMapping.dwl', 'text/plain')
	case "VOLUNTARY_CANCELLATION" -> readUrl('classpath://dwScripts/patchBillingProcess/voluntaryCancelMapping.dwl', 'text/plain')
	case "STRATUM_CHANGE" -> readUrl('classpath://dwScripts/patchBillingProcess/stratumChangeMapping.dwl', 'text/plain')
	case "OWNERSHIP_TRANSFER" -> readUrl('classpath://dwScripts/patchBillingProcess/ownershipTransferMapping.dwl', 'text/plain')
	case "BILLING_CYCLE_CHANGE" -> readUrl('classpath://dwScripts/patchBillingProcess/billingCycleChangeMapping.dwl', 'text/plain')
	case "CUSTOMER_UPDATE" -> readUrl('classpath://dwScripts/patchBillingProcess/customerUpdateMapping.dwl', 'text/plain')
	case "ACCOUNT_UPDATE" -> readUrl('classpath://dwScripts/patchBillingProcess/accountUpdateMapping.dwl', 'text/plain')
	case "ADDRESS_CHANGE" -> readUrl('classpath://dwScripts/patchBillingProcess/addressChangeMapping.dwl', 'text/plain')
	case "ADDRESS_CHANGE_BUNDLE" -> readUrl('classpath://dwScripts/patchBillingProcess/addressChangeMapping.dwl', 'text/plain')
	else -> fail("Invalid Process Code")
}