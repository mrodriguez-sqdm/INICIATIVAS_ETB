%dw 2.0
output application/json
---
{
	estado_transaccion: payload.status,
	estado_tx: payload.status_tx,
	estados: (vars.mongoGetResponse.estados default []) << 
		{
			estado_transaccion: payload.status,
	    	estado_tx: payload.status_tx default payload.status,
	    	fecha: now() as String {format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"}
		}
}