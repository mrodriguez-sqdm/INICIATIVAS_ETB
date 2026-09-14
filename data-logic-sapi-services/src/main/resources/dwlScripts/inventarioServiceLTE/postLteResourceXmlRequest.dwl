%dw 2.0
output application/xml skipNullOn = "everywhere"
ns tem http://tempuri.org/
ns inv http://schemas.datacontract.org/2004/07/InventarioLTE
---
{
	tem#GestionarInventarioLTE: {
		tem#composite: {
			inv#Canal: payload.channel,
			inv#Categoria: payload.category,
			inv#CodigoDistribuidor: payload.distributorCode,
			inv#CodigoError: payload.errorCode,
			inv#CodigoPromocion: payload.promotionCode,
			inv#ConexionA: payload.connectionA,
			inv#ConexionB: payload.connectionB,
			inv#DescripcionError: payload.errorDescription,
			inv#Estado: payload.status,
			inv#EstadoRecurso: payload.resourceStatus,
			inv#Fecha: payload.date,
			inv#FechaFin: payload.endDate,
			inv#FechaInicio: payload.startDate,
			inv#ICCID: payload.iccid,
			inv#IMSI: payload.imsi,
			inv#IdExterno: payload.externalId,
			inv#IdPedido: payload.orderId,
			inv#IdServicio: payload.serviceId,
			inv#MSISDN: payload.msisdn,
			inv#Modelo: payload.model,
			inv#NuevoIdent: payload.newIdentifier,
			inv#Operacion: payload.operation,
			inv#PIN: payload.pin,
			inv#PIN2: payload.pin2,
			inv#PUK: payload.puk,
			inv#PUK2: payload.puk2,
			inv#Resultado: payload.result,
			inv#SDP: payload.sdp,
			inv#SIMPreactiva: payload.preactiveSim,
			inv#SerieLTE: payload.lteSerial,
			inv#Subcategoria: payload.subcategory,
			inv#TipoRecurso: payload.resourceType,
			inv#Tramite: payload.procedure
		}
	}
}