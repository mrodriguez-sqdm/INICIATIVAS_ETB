%dw 2.0
output application/json
---
payload map ((item, index) -> {
	bankId: item.financialInstitutionCode,
	bankDescription: item.financialInstitutionName,
	bankCode: item.financialInstitutionCode
})