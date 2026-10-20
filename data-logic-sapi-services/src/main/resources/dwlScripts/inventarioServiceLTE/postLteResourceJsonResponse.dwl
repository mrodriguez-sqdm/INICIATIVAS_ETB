%dw 2.0
output application/json skipNullOn = "everywhere"
var result = payload.body.GestionarInventarioLTEResponse.GestionarInventarioLTEResult
---
{
	channel: result.Canal,
	category: result.Categoria,
	distributorCode: result.CodigoDistribuidor,
	errorCode: result.CodigoError,
	promotionCode: result.CodigoPromocion,
	connectionA: result.ConexionA,
	connectionB: result.ConexionB,
	errorDescription: result.DescripcionError,
	status: result.Estado,
	resourceStatus: result.EstadoRecurso,
	date: result.Fecha,
	endDate: result.FechaFin,
	startDate: result.FechaInicio,
	iccid: result.ICCID,
	imsi: result.IMSI,
	externalId: result.IdExterno,
	orderId: result.IdPedido,
	serviceId: result.IdServicio,
	msisdn: result.MSISDN,
	model: result.Modelo,
	newIdentifier: result.NuevoIdent,
	operation: result.Operacion,
	pin: result.PIN,
	pin2: result.PIN2,
	puk: result.PUK,
	puk2: result.PUK2,
	result: result.Resultado,
	sdp: result.SDP,
	preactiveSim: result.SIMPreactiva,
	lteSerial: result.SerieLTE,
	subcategory: result.Subcategoria,
	resourceType: result.TipoRecurso,
	procedure: result.Tramite
}