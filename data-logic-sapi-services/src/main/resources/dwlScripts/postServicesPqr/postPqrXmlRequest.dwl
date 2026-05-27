%dw 2.0
ns mdm http://www.etb.com.co/Gateway/MDM_Data_Services
output application/xml  skipNullOn = "everywhere", writeDeclaredNamespaces = "All"
---
{
	mdm#Set_PQR: {
		mdm#WSRequestHeader: {
			mdm#system: {
				mdm#name: "SISTEMA",
				mdm#correlationId: uuid(),
				mdm#processingServer: "Mulesoft"
			}
		},
		mdm#WSRequestBody: {
			mdm#id: payload.id,
			mdm#row_id_pqr: payload.pqrRowId,
			mdm#numero_pqr: payload.pqrNumber,
			mdm#NumOrden: payload.orderNumber,
			mdm#tipo_documento: payload.documentType,
			mdm#numero_identificacion: payload.documentNumber,
			mdm#contacto_tipo_documento: payload.contactDocumentType,
			mdm#contacto_numero_documento: payload.contactDocumentNumber,
			mdm#id_servicio: payload.serviceId,
			mdm#numero_conexion: payload.connectionNumber,
			mdm#cuenta_servicio: payload.serviceAccount,
			mdm#cuenta_facturacion: payload.billingAccount,
			mdm#producto: payload.product,
			mdm#numnumero_pedido: payload.orderNumber,
			mdm#pqr_reclamo_pqr: payload.pqrClaimPqr,
			mdm#tipo_pqr_reclamo: payload.claimPqrType,
			mdm#cun: payload.cun,
			mdm#servicio: payload.service,
			mdm#tecnologia: payload.technology,
			mdm#tipo_pqr: payload.pqrType,
			mdm#clase_pqr: payload.pqrClass,
			mdm#motivo_pqr: payload.pqrReason,
			mdm#causal_pqr: payload.pqrRootCause,
			mdm#urgencia_pqr: payload.pqrUrgency,
			mdm#impacto: payload.impact,
			mdm#sintoma_pqr: payload.pqrSymptom,
			mdm#valor_reclamado: payload.claimedValue,
			mdm#valor_ajustado: payload.adjustedValue,
			mdm#fecha_creacion: payload.creationDate,
			mdm#fecha_radicacion: payload.filingDate,
			mdm#fecha_solucion: payload.solutionDate,
			mdm#solucion: payload.solution,
			mdm#imputabilidad: payload.imputability,
			mdm#estado_envio_remedy: payload.remedySendStatus,
			mdm#Tipo_cierre: payload.closureType,
			mdm#medio_notificacion_pqr: payload.pqrNotificationMethod,
			mdm#medio_recepcion: payload.receptionMethod,
			mdm#descripcion_pqr: payload.pqrDescription,
			mdm#respuesta_pqr: payload.pqrResponse,
			mdm#num_incidendia_remedy: payload.remedyIncidentNumber,
			mdm#respuesta_remedy: payload.remedyResponse,
			mdm#id_sistema_origen: payload.originSystemId,
			mdm#sistema_origen: payload.originSystem,
			mdm#lsp_origen_llamada: payload.callOriginLsp,
			mdm#lsp_tercer_destino: payload.thirdPartyDestinationLsp,
			mdm#indicador_pqr_completa: payload.completePqrIndicator,
			mdm#correo_electronico: payload.email,
			mdm#cun_falla_masiva: payload.massiveFailureCun,
			mdm#direccion_notificacion_escrita: payload.writtenNotificationAddress,
			mdm#radicado_externo: payload.externalFiling,
			mdm#flag_recurso_apelacion: payload.appealResourceFlag,
			mdm#flag_traslado_gobierno: payload.governmentTransferFlag,
			mdm#flag_reapertura: payload.reopeningFlag,
			mdm#prioridad: payload.priority,
			mdm#usuario_creador: payload.creatorUser,
			mdm#usuario_asignado: payload.assignedUser,
			mdm#comentarios: payload.comments,
			mdm#nombre_cliente: payload.clientName,
			mdm#segmento_cliente: payload.clientSegment,
			mdm#codigo_resolucion: payload.resolutionCode,
			mdm#descripcion_resolucion: payload.resolutionDescription,
			mdm#subcanal: payload.subChannel,
			mdm#punto: payload.point,
			mdm#proveedor: payload.provider,
			mdm#gerencia: payload.management,
			mdm#semaforo: payload.trafficLight,
			mdm#dias_habiles: payload.businessDays,
			mdm#adicionales: {
				(payload.additionalFields map (additional, index) -> {
					mdm#PQR_Llave_Valor: {
						mdm#llave: additional.key,
						mdm#valor: additional.value
					}
				})
			},
			mdm#pqr_extensiones: {
				(payload.pqrExtensions map (extension, index) -> {
					mdm#PQR_EXTENSION_Request: {
						mdm#dias_extension: extension.extensionDays,
						mdm#fecha_incio_extension: extension.extensionStartDate,
						mdm#fecha_fin_extension: extension.extensionEndDate
					}
				})
			},
			mdm#pqr_actividades_pqr: {
				(payload.pqrActivities map (activity, index) -> {
					mdm#PQR_ACTIVIDAD_PQR_Request: {
						mdm#row_id_actividad: activity.activityRowId,
						mdm#nombre_actividad: activity.activityName,
						mdm#estado_actividad: activity.activityStatus,
						mdm#comentarios: activity.comments,
						mdm#descripcion: activity.description,
						mdm#gestion: activity.management,
						mdm#descripcion_gestion: activity.managementDescription,
						mdm#grupo_actividad: activity.activityGroup,
						mdm#usuario_asignado: activity.assignedUser,
						mdm#usuario_creador_actividad: activity.activityCreatorUser,
						mdm#fecha_inicio_actividad: activity.activityStartDate,
						mdm#fecha_estado_actual: activity.currentStatusDate,
						mdm#fecha_vencimiento_actividad: activity.activityDueDate,
						mdm#final: activity.isFinal,
						mdm#prioridad: activity.priority,
						mdm#fecha_desconexion: activity.disconnectionDate,
						mdm#fecha_reconexion: activity.reconnectionDate,
						mdm#duracion: activity.duration,
						mdm#cuenta: activity.account,
						mdm#notificacion: activity.notification,
						mdm#semaforo: activity.trafficLight,
						mdm#dias_habiles: activity.businessDays,
						mdm#actividades_adjuntas: {
							(activity.activityAttachments map (attach, index) -> {
								mdm#PQR_ADJUNTOS_ACTIVIDAD_Request: {
									mdm#adjuntos_actividades: attach.activityAttachment
								}
							})
						}
					}
				})
			},
			mdm#pqr_caracteristicas: {
				(payload.pqrCharacteristics map (characteristic, index) -> {
					mdm#PQR_CARACTERISTICA_Request: {
						mdm#Caracteristica: characteristic.characteristic,
						mdm#Valor: characteristic.value
					}
				})
			},
			mdm#pqr_archivos_adjuntos: {
				(payload.pqrAttachedFiles map (attach, index) -> {
					mdm#PQR_ARCHIVO_ADJUNTO_Request: {
						mdm#archivo_adjunto: attach.attachedFile
					}
				})
			},
			mdm#set_type: payload.setType,
			mdm#version_pqr: payload.pqrVersion,
			mdm#flag_notificacion: payload.notificationFlag,
			mdm#flag_fallaJovenField: payload.earlyFailureFlagField,
			mdm#Estado_Segundo_Nivel: {
				mdm#id: payload.secondLevelStatus.id,
				mdm#Codigo: payload.secondLevelStatus.code,
				mdm#Descripcion: payload.secondLevelStatus.description,
				mdm#Fecha: payload.secondLevelStatus.date,
				mdm#Reintentos: payload.secondLevelStatus.retries,
				mdm#CodigoExcepcion: payload.secondLevelStatus.exceptionCode
			},
			mdm#sub_estado: payload.subStatus,
			mdm#excepcion: payload.exception,
			mdm#tipo_excepcion: payload.exceptionType,
			mdm#originada_por: payload.originatedBy,
			mdm#familia: payload.family,
			mdm#tipoContacto: payload.contactType,
			mdm#firma: payload.signature,
			mdm#EsMultidetalle: payload.isMultiDetail,
			mdm#EnvioComunicaciones: {
				mdm#MedioComunicacion: payload.communicationsDelivery.communicationMethod,
				mdm#DatoComunicacion1: payload.communicationsDelivery.communicationData1,
				mdm#DatoComunicacion2: payload.communicationsDelivery.communicationData2
			},
			mdm#codigo_back: payload.backCode,
			mdm#numero_retencion: payload.retentionNumber,
			mdm#tipo_falla: payload.failureType,
			mdm#bloqueo_permanencia: payload.permanenceBlock
		}
	}
}