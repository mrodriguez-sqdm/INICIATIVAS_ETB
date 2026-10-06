%dw 2.0
output application/json skipNullOn = "everywhere"
var result = payload.body.ConsultarInventarioTipoRecursoResponse.ConsultarInventarioTipoRecursoResult
---
{
	code: result.Codigo,
	description: result.Descripcion,
	channel: result.Canal,
	date: result.Fecha,
	iccid: result.ICCID,
	imsi: result.IMSI,
	orderId: result.IdPedido,
	serviceId: result.IdServicio,
	msisdn: result.MSISDN,
	model: result.Modelo,
	pin: result.PIN,
	pin2: result.PIN2,
	puk: result.PUK,
	puk2: result.PUK2,
	sdp: result.SDP
}