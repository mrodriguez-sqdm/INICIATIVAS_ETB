%dw 2.0
output application/json
---
{
	ProcessData: {
		ProcessingType: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.ProcessData.ProcessingType,
		RVC: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.ProcessData.RVC,
		RMCA: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.ProcessData.RMCA,
		MDM: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.ProcessData.MDM
	},
	CreateSystemsAccountsBody: {
		MarketType: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.MarketType,
		GeoCode1: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.GeoCode1,
		GeoCode2: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.GeoCode2,
		GeoCode3: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.GeoCode3,
		ConnectionNumber: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.ConectionNumber,
		FD: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.FD,
		CurrCode: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.CurrCode,
		InvDay: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.InvDay,
		ConvInd: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.ConvInd,
		SubId: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.SubId,
		BillPrntSubId: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillPrntSubId,
		PaymentPrd: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.PaymentPrd,
		Billable: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Billiable,
		InvoiceDeliveryName: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.InvoiceDeliveryName,
		InvoiceMethod: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.InvoiceMethod,
		OrderType: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.OrderType,
		OrderSubType: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.OrderSubType,
		SourceSystem: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.SourceSystem,
		ClaimMethod: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.ClaimMethod,
		Segment: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Segment,
		SubSegment: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.SubSegment,
		EconomicActivity: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.EconomicActivity,
		State: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.State,
		Market: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Market,
		Frequency: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Frequency,
		PortfolioArrears: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.PortfolioArrears,
		InvoiceType: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.InvoiceType,
		InvoiceSupport: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.InvoiceSupport,
		ChargingCycle: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.ChargingCycle,
		CodeChargingCycle: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.CodeChargingCycle,
		DateCutBilling: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.DateCutBilling,
		Taxes: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Taxes,
		ModifiedMDM: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.ModifiedMDM,
		OrderRelated: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.OrderRelated,
		SalesforceInvoiceId: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.SalesforceInvoiceId,
		SetTypeMDM: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.SetTypeMDM,
		ExternalAddressNumber: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.ExternalAddressNumber,
		StartDate: {
			Day: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.StartDate.Day,
			Month: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.StartDate.Month,
			Year: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.StartDate.Year
		},
		Customer: {
			BillingAccountName: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.BillingAccountName,
			FirstName: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.FirstName,
			SecondName: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.SecondName,
			Surame: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.Surame,
			Lastname: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.Lastname,
			SecondSurname: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.SecondSurname,
			ClientAccountName: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.ClientAccountName,
			DocumentType: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.DocumentType,
			DocumentNumber: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.DocumentNumber,
			AccountIdentificationID: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.AccountIdentificationID,
			AccountTypeCode: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.AccountTypeCode,
			IdentificationID: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.IdentificationID,
			Email: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.Email,
			ContactInfo: {
				PhoneNumber: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.ContactInfo.PhoneNumber,
				ContactEmail: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.ContactInfo.ContactEmail,
				DocumentNumber: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.Customer.DocumentNumber
			}
		},
		BillingAddress: {
			BillAddress: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.BillAddress,
			Country: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.Country,
			DepartmentName: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.DepartmentName,
			CityName: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.CityName,
			Neighborhood: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.Neighborhood,
			Location: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.Location,
			StateCode: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.StateCode,
			PostCode: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.PostCode,
			DaneCode: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.DaneCode,
			Stratum: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAddress.Stratum,
		},
		BillingAccountData: {
			SubscriberId: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.BillingAccountData.SubscriberId,
		},
		User: {
			CreatorUser: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.User.CreatorUser,
			ModifierUser: payload.body.CreateSystemsAccountsIN.CreateSystemsAccountsInput.CreateSystemsAccountsBody.User.ModifierUser,
		}
	}
}