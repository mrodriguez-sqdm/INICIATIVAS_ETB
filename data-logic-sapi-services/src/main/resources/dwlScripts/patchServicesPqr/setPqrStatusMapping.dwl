%dw 2.0
ns mdm http://www.etb.com.co/Gateway/MDM_Data_Services
output application/xml  skipNullOn="everywhere", writeDeclaredNamespaces="All"
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
      mdm#numero_pqr: vars.pqrId,
      mdm#estado_pqr: payload.pqrStatus,
      mdm#set_type: "U"
    }
  }
}