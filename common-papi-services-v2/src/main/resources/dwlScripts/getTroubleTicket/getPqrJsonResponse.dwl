%dw 2.0
output application/json skipNullOn="everywhere"
fun normalize(value) = value match {
	case list is Array -> list map normalize($)
	case object is Object ->
		if (object."\$oid"?) object."\$oid"
		else if (object."\$date"?) normalize(object."\$date")
		else if (object."\$numberDecimal"?) object."\$numberDecimal"
		else if (object."\$numberLong"?) object."\$numberLong"
		else object mapObject ((itemValue, itemKey) -> { (itemKey): normalize(itemValue) })
	else -> value
}
fun asArray(value) = value match {
	case list is Array -> list
	case is Null -> []
	else -> [value]
}
var pqrResponse = asArray(normalize(payload.result))
var limit = vars.limit
---
{
	"code": "200",
	"message": "PQR encontrada con éxito",
	"pqr": (if (isEmpty(limit)) pqrResponse
		else pqrResponse filter ((item, index) -> index < limit as Number)) map (pqrResponse) -> {
		"extractorUpdatedAt": pqrResponse.actualizacion_extractor,
		"id": pqrResponse."_id",
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
		"orderNumber": pqrResponse.numnumero_pedido,
		"claim": pqrResponse.pqr_reclamo_pqr,
		"claimType": pqrResponse.tipo_pqr_reclamo,
		"cun": pqrResponse.cun,
		"service": pqrResponse.servicio,
		"technology": pqrResponse.tecnologia,
		"pqrType": pqrResponse.tipo_pqr,
		"pqrClass": pqrResponse.clase_pqr,
		"pqrReason": pqrResponse.motivo_pqr,
		"pqrCause": pqrResponse.causal_pqr,
		"pqrUrgency": pqrResponse.urgencia_pqr,
		"impact": pqrResponse.impacto,
		"pqrSymptom": pqrResponse.sintoma_pqr,
		"claimedAmount": pqrResponse.valor_reclamado,
		"adjustedAmount": pqrResponse.valor_ajustado,
		"creationDate": pqrResponse.fecha_creacion,
		"filingDate": pqrResponse.fecha_radicacion,
		"solutionDate": pqrResponse.fecha_solucion,
		"solution": pqrResponse.solucion,
		"imputability": pqrResponse.imputabilidad,
		"pqrStatus": pqrResponse.estado_pqr,
		"remedySendStatus": pqrResponse.estado_envio_remedy,
		"closureType": pqrResponse.Tipo_cierre,
		"notificationMethod": pqrResponse.medio_notificacion_pqr,
		"receptionMethod": pqrResponse.medio_recepcion,
		"pqrDescription": pqrResponse.descripcion_pqr,
		"pqrAnswer": pqrResponse.respuesta_pqr,
		"remedyIncidentNumber": pqrResponse.num_incidendia_remedy,
		"remedyResponse": pqrResponse.respuesta_remedy,
		"sourceSystemId": pqrResponse.id_sistema_origen,
		"sourceSystem": pqrResponse.sistema_origen,
		"callOriginLsp": pqrResponse.lsp_origen_llamada,
		"thirdDestinationLsp": pqrResponse.lsp_tercer_destino,
		"completePqrIndicator": pqrResponse.indicador_pqr_completa,
		"email": pqrResponse.correo_electronico,
		"massiveFailureCun": pqrResponse.cun_falla_masiva,
		"writtenNotificationAddress": pqrResponse.direccion_notificacion_escrita,
		"externalFilingNumber": pqrResponse.radicado_externo,
		"appealFlag": pqrResponse.flag_recurso_apelacion,
		"governmentTransferFlag": pqrResponse.flag_traslado_gobierno,
		"recurrentCustomerFlag": pqrResponse.flag_cliente_recurrente,
		"reopeningFlag": pqrResponse.flag_reapertura,
		"priority": pqrResponse.prioridad,
		"createdByUser": pqrResponse.usuario_creador,
		"assignedUser": pqrResponse.usuario_asignado,
		"comments": pqrResponse.comentarios,
		"customerName": pqrResponse.nombre_cliente,
		"customerSegment": pqrResponse.segmento_cliente,
		"resolutionCode": pqrResponse.codigo_resolucion,
		"resolutionDescription": pqrResponse.descripcion_resolucion,
		"subChannel": pqrResponse.subcanal,
		"servicePoint": pqrResponse.punto,
		"provider": pqrResponse.proveedor,
		"managementArea": pqrResponse.gerencia,
		"statusLight": pqrResponse.semaforo,
		"businessDays": pqrResponse.dias_habiles,
		"waitStartDate": pqrResponse.Fecha_Inicio_Espera,
		"waitEndDate": pqrResponse.Fecha_Fin_Espera,
		"relatedCun": pqrResponse.cun_relacionado,
		"contactName": pqrResponse.nombre_contacto,
		"receptionChannel": pqrResponse.canal_recepcion,
		"pqrExtensions": asArray(pqrResponse.pqr_extensiones) map (extension) -> {
			"extensionDays": extension.dias_extension,
			"extensionStartDate": extension.fecha_incio_extension,
			"extensionEndDate": extension.fecha_fin_extension
		},
		"pqrActivities": asArray(pqrResponse.pqr_actividades_pqr) map (activity) -> {
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
			"activityAttachments": asArray(activity.actividades_adjuntas) map (activityAttachment) -> {
				"attachmentActivity": if (activityAttachment is Object) activityAttachment.adjuntos_actividades else activityAttachment
			}
		},
		"pqrAttachments": asArray(pqrResponse.pqr_archivos_adjuntos) map (attachment) -> {
			"attachmentFile": if (attachment is Object) attachment.archivo_adjunto else attachment
		},
		"pqrFlowCharacteristics": asArray(pqrResponse.Caracteristicas_pqr) map (flowCharacteristic) -> {
			"flowId": flowCharacteristic.id_flujo,
			"url": flowCharacteristic.url,
			"date": flowCharacteristic.fecha
		},
		"pqrCharacteristics": asArray(pqrResponse.pqr_caracteristicas) map (characteristic) -> {
			"characteristic": characteristic.Caracteristica,
			"value": characteristic.Valor
		},
		"suspensionDetails": asArray(pqrResponse.pqr_detalle_suspension) map (suspension) -> {
			"newGroup": suspension.nuevo_grupo,
			"suspensionStatus": suspension.estado_suspension,
			"suspensionReason": suspension.causal_motivo_supension,
			"groupChangeDate": suspension.fecha_cambio_grupo
		},
		"pqrVersion": pqrResponse.version_pqr,
		"notificationFlag": pqrResponse.flag_notificacion,
		"earlyFailureFlag": pqrResponse.flag_fallaJoven,
		"secondLevelStatus": asArray(pqrResponse.Estado_Segundo_Nivel) map (secondLevel) -> {
			"id": secondLevel.id,
			"code": secondLevel.Codigo,
			"description": secondLevel.Descripcion,
			"date": secondLevel.Fecha,
			"retries": secondLevel.Reintentos,
			"exceptionCode": secondLevel.CodigoExcepcion
		},
		"modificationDate": pqrResponse.fecha_modificacion,
		"subStatus": pqrResponse.sub_estado,
		"exception": pqrResponse.excepcion,
		"exceptionType": pqrResponse.tipo_excepcion,
		"originatedBy": pqrResponse.originada_por,
		"family": pqrResponse.familia,
		"contactType": pqrResponse.tipoContacto,
		"signature": pqrResponse.firma,
		"isMultiDetail": pqrResponse.EsMultidetalle,
		"contingencyDate": pqrResponse.fecha_contingente,
		"communicationDelivery": {
			"communicationMethod": pqrResponse.EnvioComunicaciones.MedioComunicacion,
			"communicationData1": pqrResponse.EnvioComunicaciones.DatoComunicacion1,
			"communicationData2": pqrResponse.EnvioComunicaciones.DatoComunicacion2
		},
		"mdmRelated": pqrResponse.mdm_relaciona,
		"cancellationReason": pqrResponse.motivo_anulacion,
		"backCode": pqrResponse.codigo_back,
		"permanenceLock": pqrResponse.bloqueo_permanencia,
		"retentionNumber": pqrResponse.numero_retencion,
		"repeatCase": pqrResponse.reincidente,
		"failureType": pqrResponse.tipo_falla
	}
}
