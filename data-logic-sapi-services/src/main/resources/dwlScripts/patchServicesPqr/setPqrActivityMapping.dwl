%dw 2.0
ns mdm http://www.etb.com.co/Gateway/MDM_Data_Services
output application/xml  skipNullOn="everywhere", writeDeclaredNamespaces="All"
---
{
  mdm#Set_PQR_Actividades_PQR: {
    mdm#WSRequestHeader: {
      mdm#system: {
        mdm#name: "SISTEMA",
        mdm#correlationId: uuid(),
        mdm#processingServer: "Mulesoft"
      }
    },
    mdm#WSRequestBody: {
      mdm#id_pqr: vars.pqrId,
      mdm#nombre_actividad: payload.activity.activityName,
      mdm#estado_actividad: payload.activity.activityStatus,
      mdm#comentarios: payload.activity.comments,
      mdm#descripcion: payload.activity.description,
      mdm#gestion: payload.activity.management,
      mdm#descripcion_gestion: payload.activity.managementDescription,
      mdm#grupo_actividad: payload.activity.activityGroup,
      mdm#usuario_asignado: payload.activity.assignedUser,
      mdm#usuario_creador_actividad: payload.activity.activityCreatedByUser,
      mdm#fecha_inicio_actividad: payload.activity.activityStartDate,
      mdm#fecha_estado_actual: payload.activity.currentStatusDate,
      mdm#fecha_vencimiento_actividad: payload.activity.activityDueDate,
      mdm#final: payload.activity.isFinal,
      mdm#prioridad: payload.activity.priority,
      mdm#fecha_desconexion: payload.activity.disconnectionDate,
      mdm#fecha_reconexion: payload.activity.reconnectionDate,
      mdm#duracion: payload.activity.duration,
      mdm#cuenta: payload.activity.account,
      mdm#notificacion: payload.activity.notification,
      mdm#semaforo: payload.activity.statusLight,
      mdm#dias_habiles: payload.activity.businessDays,
      mdm#actividades_adjuntas: 
        mdm#PQR_ADJUNTOS_ACTIVIDAD: payload.activity.activityAttachments map ((item) -> {
          mdm#adjuntos_actividades: item.activityAttachment
        }),
      mdm#set_type: "U",
      mdm#gestion2: payload.activity.secondaryManagement
    }
  }
}