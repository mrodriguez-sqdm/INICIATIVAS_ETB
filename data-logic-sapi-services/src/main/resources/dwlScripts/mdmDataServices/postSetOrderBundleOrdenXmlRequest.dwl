%dw 2.0
output application/xml skipNullOn = "everywhere"
ns mdm http://www.etb.com.co/Gateway/MDM_Data_Services

fun validDate(value) =
	if (value is Boolean) null
	else value

---
{
	mdm#Set_Order_Bundle_Orden: {
		mdm#WSRequestHeader: {
			mdm#system: {
				mdm#name: payload.requestHeader.system.name,
				mdm#correlationId: payload.requestHeader.system.correlationId,
				mdm#processingServer: payload.requestHeader.system.processingServer
			},
			mdm#property: {
				mdm#Property: payload.requestHeader.properties map (prop) -> {
					mdm#name: prop.name,
					mdm#value: prop.value
				}
			}
		},
		mdm#WSRequestBody: {
			mdm#order_number: payload.requestBody.orderNumber,
			mdm#Bundle: {
				mdm#MDM_Bundle: payload.requestBody.bundles map (bundle) -> {
					mdm#Id: bundle.id,
					mdm#id_catalogo: bundle.catalogId,
					mdm#nombre: bundle.name,
					mdm#fecha_activacion: validDate(bundle.activationDate),
					mdm#fecha_inactivacion: validDate(bundle.deactivationDate),
					mdm#primarios: {
						mdm#MDM_Primario: bundle.primaryItems map (primary) -> {
							mdm#Id: primary.id,
							mdm#id_primario: primary.primaryId,
							mdm#numero_conexion: primary.connectionNumber,
							mdm#nombre: primary.name,
							mdm#fecha_activacion: validDate(primary.activationDate),
							mdm#fecha_inactivacion: validDate(primary.deactivationDate),
							mdm#caracteristicas_primarios: {
								mdm#MDM_Caracteristica: primary.primaryCharacteristics map (characteristic) -> {
									mdm#Caracteristica: characteristic.characteristic,
									mdm#Valor: characteristic.value
								}
							},
							mdm#secundarios: {
								mdm#MDM_Secundario: primary.secondaryItems map (secondary) -> {
									mdm#Id: secondary.id,
									mdm#id_secundario: secondary.secondaryId,
									mdm#nombre: secondary.name,
									mdm#fecha_activacion: validDate(secondary.activationDate),
									mdm#fecha_inactivacion: validDate(secondary.deactivationDate),
									mdm#caracteristicas_secundario: {
										mdm#MDM_Caracteristica: secondary.secondaryCharacteristics map (characteristic) -> {
											mdm#Caracteristica: characteristic.characteristic,
											mdm#Valor: characteristic.value
										}
									}
								}
							},
							mdm#adicionales: {
								mdm#MDM_Adicional: primary.additionalItems map (additional) -> {
									mdm#Id: additional.id,
									mdm#id_adicional: additional.additionalId,
									mdm#nombre: additional.name,
									mdm#fecha_activacion: validDate(additional.activationDate),
									mdm#fecha_inactivacion: validDate(additional.deactivationDate),
									mdm#caracteristicas_adicional: {
										mdm#MDM_Caracteristica: additional.additionalCharacteristics map (characteristic) -> {
											mdm#Caracteristica: characteristic.characteristic,
											mdm#Valor: characteristic.value
										}
									}
								}
							}
						}
					},
					mdm#opcionales: {
						mdm#MDM_Opcional: bundle.optionalItems map (optional) -> {
							mdm#Id: optional.id,
							mdm#id_opcional: optional.optionalId,
							mdm#nombre: optional.name,
							mdm#id_primario: optional.primaryId,
							mdm#fecha_activacion: validDate(optional.activationDate),
							mdm#fecha_inactivacion: validDate(optional.deactivationDate),
							mdm#caracteristicas_opcional: {
								mdm#MDM_Caracteristica: optional.optionalCharacteristics map (characteristic) -> {
									mdm#Caracteristica: characteristic.characteristic,
									mdm#Valor: characteristic.value
								}
							},
							mdm#estados_opcional: {
								mdm#MDM_Estado: optional.optionalStates map (state) -> {
									mdm#tipologia: state.typology,
									mdm#id_estado: state.stateId,
									mdm#nombre_estado: state.stateName
								}
							}
						}
					},
					mdm#caracteristicas_bundle: {
						mdm#MDM_Caracteristica: bundle.bundleCharacteristics map (characteristic) -> {
							mdm#Caracteristica: characteristic.characteristic,
							mdm#Valor: characteristic.value
						}
					},
					mdm#estados_bundle: {
						mdm#MDM_Estado: bundle.bundleStates map (state) -> {
							mdm#tipologia: state.typology,
							mdm#id_estado: state.stateId,
							mdm#nombre_estado: state.stateName
						}
					},
					mdm#bundle_auxiliar: bundle.auxiliaryBundle
				}
			}
		}
	}
}