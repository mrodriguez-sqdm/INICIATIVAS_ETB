%dw 2.0
output application/xml skipNullOn = "everywhere"
ns tem http://tempuri.org/
ns inv http://schemas.datacontract.org/2004/07/InventarioLTE.Model.Services.ConsultaInventario
---
{
	tem#ConsultarInventarioTipoRecurso: {
		tem#solicitud: {
			inv#Estado: attributes.queryParams.status,
			inv#Identificador: attributes.queryParams.identifier,
			inv#SistemaOperativo: attributes.queryParams.operatingSystem,
			inv#TipoRecurso: attributes.queryParams.resourceType,
			inv#TipoSim: attributes.queryParams.simType
		}
	}
}