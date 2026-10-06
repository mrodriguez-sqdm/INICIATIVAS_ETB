%dw 2.0
ns mdm http://www.etb.com.co/Gateway/MDM_Data_Services
output application/xml  skipNullOn = "everywhere", writeDeclaredNamespaces = "All"
---
{
	mdm#Get_PQR: {
		mdm#WSRequestHeader: {
			mdm#system: {
				mdm#name: "SISTEMA",
				mdm#correlationId: uuid(),
				mdm#processingServer: "Mulesoft"
			}
		},
		mdm#WSRequestBody: {
			mdm#id: attributes.queryParams.id,
			mdm#PQR_number: attributes.queryParams.pqrNumber,
			mdm#customer_document_type: attributes.queryParams.customerDocumentType,
			mdm#customer_document_number: attributes.queryParams.customerDocumentNumber,
			mdm#connection_number: attributes.queryParams.connectionNumber,
			mdm#billing_account: attributes.queryParams.billingAccount,
			mdm#cun: attributes.queryParams.cun,
			mdm#assigned_user: attributes.queryParams.assignedUser,
			mdm#tipo_consulta: attributes.queryParams.queryType,
			mdm#tipo_servicio: attributes.queryParams.serviceType,
			mdm#canal_recepcion: attributes.queryParams.receptionChannel,
			mdm#dias_habiles: attributes.queryParams.businessDays,
			mdm#estado: attributes.queryParams.status
		}
	}
}