%dw 2.0
ns mdm http://www.etb.com.co/Gateway/MDM_Data_Services
output application/xml  skipNullOn="everywhere", writeDeclaredNamespaces="All"
---
{
  mdm#Set_PQR_Actividades: {
    mdm#WSRequestHeader: {
      mdm#system: {
        mdm#name: "SISTEMA",
        mdm#correlationId: uuid(),
        mdm#processingServer: "Mulesoft"
      }
    },
    mdm#WSRequestBody: {
      mdm#id: vars.pqrId,
      mdm#activity: payload.activity.name,
      mdm#management_group: payload.activity.managementGroup,
      mdm#activity_class: payload.activity.activityClass,
      mdm#reason: payload.activity.reason,
      mdm#description: payload.activity.description,
      mdm#observations: payload.activity.observations,
      mdm#activity_type: payload.activity.activityType,
      mdm#lets_close_pqr: payload.activity.closePqr,
      mdm#status: payload.activity.status,
      mdm#set_type: payload.activity.setType default "U",
      mdm#start_date: payload.activity.startDate,
      mdm#end_date: payload.activity.endDate,
      mdm#version: payload.activity.version default "1"
    }
  }
}