%dw 2.0
var pqrResponse = payload.body.Get_PQRResponse.Get_PQRResult.WSResponseBody.PQR_PQR
output application/json
---
{
	"code": "200",
	"message": "PQR encontrada con éxito",
	"pqr": [{
		"id": pqrResponse.Id,
		"rowId": pqrResponse.row_id_pqr,
		"pqrNumber": pqrResponse.numero_pqr,
		"documentType": pqrResponse.tipo_documento,
		"identificationNumber": pqrResponse.numero_identificacion,
		"contactDocumentType": pqrResponse.contacto_tipo_documento,
		"contactDocumentNumber": pqrResponse.contacto_numero_documento,
		"serviceId": pqrResponse.id_servicio,
		"connectionNumber": pqrResponse.numero_conexion,
		"serviceAccount": pqrResponse.cuenta_servicio,
		"billingAccount": pqrResponse.cuenta_facturacion,
		"product": pqrResponse.producto,
		"pqrStatus": pqrResponse.estado_pqr,
		"pqrActivities": pqrResponse.pqr_actividades_pqr default {
		} pluck ((value) -> value) map (activity) -> {
			"extractorUpdatedAt": activity.actualizacion_extractor,
			"activityRowId": activity.row_id_actividad,
			"activityName": activity.nombre_actividad,
			"activityStatus": activity.estado_actividad,
			"comments": activity.comentarios,
			"description": activity.descripcion,
			"management": activity.gestion,
			"managementDescription": activity.descripcion_gestion,
			"activityGroup": activity.grupo_actividad,
			"assignedUser": activity.usuario_asignado,
			"activityCreatedByUser": activity.usuario_creador_actividad,
			"activityStartDate": activity.fecha_inicio_actividad,
			"currentStatusDate": activity.fecha_estado_actual,
			"activityDueDate": activity.fecha_vencimiento_actividad,
			"isFinal": activity.final,
			"priority": activity.prioridad,
			"disconnectionDate": activity.fecha_desconexion,
			"reconnectionDate": activity.fecha_reconexion,
			"duration": activity.duracion,
			"account": activity.cuenta,
			"notification": activity.notificacion,
			"statusLight": activity.semaforo,
			"secondaryManagement": activity.gestion2,
			"businessDays": activity.dias_habiles,
			"activityAttachments": activity.actividades_adjuntas default {
			} pluck ((value) -> value) map (activityAttachment) -> {
				"attachmentActivity": activityAttachment.adjuntos_actividades
			}
		}
	}]
}