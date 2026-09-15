%dw 2.0
output application/xml skipNullOn = "everywhere"
ns ns01 http://www.etb.com.co/Gateway/MDM_Data_Services
var req = payload
---
{
	ns01#Set_PaymentOnLine: {
		ns01#WSRequestHeader: {
			ns01#system: {
				ns01#name: req.requestHeader.system.name,
				ns01#correlationId: req.requestHeader.system.correlationId,
				ns01#processingServer: req.requestHeader.system.processingServer
			},
			ns01#property: {
				ns01#Property: req.requestHeader.properties map (item) -> {
					ns01#name: item.name,
					ns01#value: item.value
				}
			}
		},
		ns01#WsRequestBody: {
			ns01#NumeroCuentaFacturacion: req.requestBody.billingAccountNumber,
			ns01#NumeroFactura: req.requestBody.invoiceNumber,
			ns01#NumeroFacturaRMCA: req.requestBody.rmcaInvoiceNumber,
			ns01#ValorRecaudado: req.requestBody.collectedAmount,
			ns01#FechaRecaudo: req.requestBody.collectionDate,
			ns01#EntidadRecaudadora: req.requestBody.collectingEntity,
			ns01#NumeroCiclo: req.requestBody.cycleNumber,
			ns01#SistemaRecaudador: req.requestBody.collectingSystem,
			ns01#ProcedenciaPago: req.requestBody.paymentOrigin,
			ns01#MetodoPago: req.requestBody.paymentMethod,
			ns01#CuentaRecaudadora: req.requestBody.collectingAccount,
			ns01#NombreArchivo: req.requestBody.fileName,
			ns01#TipoCuentaRecaudadora: req.requestBody.collectingAccountType
		}
	}
}
