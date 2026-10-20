%dw 2.0
output application/xml skipNullOn = "everywhere"
ns mdm http://www.etb.com.co/Gateway/MDM_Data_Services
var header = payload.requestHeader
var body = payload.requestBody
---
{
	mdm#Set_Order: {
		mdm#WSRequestHeader: {
			mdm#system: {
				mdm#name: header.system.name,
				mdm#correlationId: header.system.correlationId,
				mdm#processingServer: header.system.processingServer
			},
			mdm#property: {
				mdm#Property: header.properties map (item) -> {
					mdm#name: item.name,
					mdm#value: item.value
				}
			}
		},
		mdm#WSRequestBody: {
			mdm#Id: body.id,
			mdm#Tipo_Documento: body.documentType,
			mdm#Numero_Identificacion: body.identificationNumber,
			mdm#CUN: body.cun,
			mdm#Id_Distribuidor: body.distributorId,
			mdm#Tipo_Orden: body.orderType,
			mdm#Subtipo_Orden: body.orderSubtype,
			mdm#Estado_Orden: body.orderStatus,
			mdm#Causal_Estado_Orden: body.orderStatusCause,
			mdm#Numero_Orden: body.orderNumber,
			mdm#Fecha_Creacion_Orden: body.orderCreationDate,
			mdm#Usuario_Creador: body.creatorUser,
			mdm#Usuario_Modificador: body.modifierUser,
			mdm#Usuario_Vendedor: body.sellerUser,
			mdm#Fecha_Actualizacion_Orden: body.orderUpdateDate,
			mdm#Canal: body.channel,
			mdm#Subcanal: body.subchannel,
			mdm#Causal_Retiro_Cliente: body.customerWithdrawalCause,
			mdm#Forma_Entrega_Contrato: body.contractDeliveryMethod,
			mdm#Fecha_Inicio_Contrato: body.contractStartDate,
			mdm#Id_Orden_Sistema_Origen: body.sourceSystemOrderId,
			mdm#Sistema_Origen: body.sourceSystem,
			mdm#IMEI: body.imei,
			mdm#ICCID: body.iccid,
			mdm#Num_Agrupacion_Catalogo: body.catalogGroupingNumber,
			mdm#producto_seleccionado: body.selectedProduct,
			mdm#tipo_entrega_factura: body.invoiceDeliveryType,
			mdm#tipo_plan: body.planType,
			mdm#ciclo_facturacion: body.billingCycle,
			mdm#numero_orden_valida: body.validOrderNumber,
			mdm#Portabilidad_Codigo_Operador: body.portabilityOperatorCode,
			mdm#Celular_Porabilidad: body.portabilityPhoneNumber,
			mdm#Tipo_Plan_Donante: body.donorPlanType,
			mdm#Caracteristicas_Orden: {
				mdm#MDM_Caracteristica_Accion: body.orderCharacteristics map (item) -> {
					mdm#Caracteristica: item.characteristic,
					mdm#Valor: item.value,
					mdm#Accion: item.action,
					mdm#actualizacion_extractor: item.extractorUpdate
				}
			},
			mdm#Pago: {
				mdm#MDM_Orden_Pago: body.payments map (item) -> {
					mdm#Tipo_Recaudo: item.collectionType,
					mdm#Forma_Pago: item.paymentMethod,
					mdm#Recibo_Pago: item.paymentReceipt,
					mdm#Valor_Pagado: item.paidAmount,
					mdm#Valor_Facturado: item.billedAmount,
					mdm#Valor_Sin_Iva: item.amountWithoutTax,
					mdm#Fecha_Pago: item.paymentDate,
					mdm#Banco: item.bank,
					mdm#Canal_Pago: item.paymentChannel,
					mdm#Fecha_Limite_Pago: item.paymentDueDate,
					mdm#Numero_Confirmacion: item.confirmationNumber,
					mdm#Estado: item.status,
					mdm#Codigo_Respuesta: item.responseCode,
					mdm#Mensaje_Respuesta: item.responseMessage,
					mdm#pago_online: item.onlinePayment,
					mdm#actualizacion_extractor: item.extractorUpdate
				}
			},
			mdm#Cuenta_Facturacion: body.billingAccount,
			mdm#Cuenta_Facturacion_Equipo: body.equipmentBillingAccount,
			mdm#Pago_Anticipado: body.advancePayment,
			mdm#Valor_Recaudo: body.collectionAmount,
			mdm#Detalle_Orden: {
				mdm#Order_Detail_Set: body.orderDetails map (detail) -> {
					mdm#Empaquetado: detail.bundled,
					mdm#Tipo_Producto: detail.productType,
					mdm#Codigo_Producto: detail.productCode,
					mdm#Producto: detail.product,
					mdm#Oferta_Plan: detail.planOffer,
					mdm#Valor_Oferta: detail.offerValue,
					mdm#Numero_Conexion: detail.connectionNumber,
					mdm#IMEI: detail.imei,
					mdm#Service_Class: detail.serviceClass,
					mdm#Integration_Id: detail.integrationId,
					mdm#Duracion_Servicio: detail.serviceDuration,
					mdm#Accion: detail.action,
					mdm#Estado: detail.status,
					mdm#Fecha_Estado: detail.statusDate,
					mdm#Portabilidad: detail.portability,
					mdm#Portabilidad_NIP: detail.portabilityNip,
					mdm#Portabilidad_Fecha: detail.portabilityDate,
					mdm#Portabilidad_Operador_Origen: detail.sourceOperatorPortability,
					mdm#Portabilidad_Autorizacion_Tercero: detail.thirdPartyPortabilityAuthorization,
					mdm#Financiamiento_Porcentaje_Maximo: detail.financingMaximumPercentage,
					mdm#Financiamiento_Valor_Financiado: detail.financedAmount,
					mdm#Financiamiento_Numero_Cuotas: detail.financingInstallmentsNumber,
					mdm#Fecha_Activacion: detail.activationDate,
					mdm#Fecha_Inactivacion: detail.deactivationDate,
					mdm#Modalidad_Servicio: detail.serviceMode,
					mdm#Direccion_Instalacion: detail.installationAddress,
					mdm#Codigo_Dane_Ciudad_Instalacion: detail.installationCityDaneCode,
					mdm#Barrio_Instalacion: detail.installationNeighborhood,
					mdm#Flag_Convergencia: detail.convergenceFlag,
					mdm#Flag_Facturable: detail.billableFlag,
					mdm#Estrato_Instalacion: detail.installationStratum,
					mdm#Tecnologia: detail.technology,
					mdm#Fecha_Vencimiento_Ejecucion: detail.executionDueDate,
					mdm#Cuenta_Facturacion: detail.billingAccount,
					mdm#Ciclo_Facturacion: detail.billingCycle,
					mdm#Ciclo_OCS: detail.ocsCycle,
					mdm#Ciclo_OCS_Codigo: detail.ocsCycleCode,
					mdm#Id_Servicio_Sistema_Origen: detail.sourceSystemServiceId,
					mdm#Id_Servicio_Sistema_Origen_Padre: detail.parentSourceSystemServiceId,
					mdm#Id_Servicio_Salesforce: detail.salesforceServiceId,
					mdm#Promocion_Servicio: {
						mdm#MDM_Promocion: detail.servicePromotions map (promo) -> {
							mdm#Promocion: promo.promotion,
							mdm#Valor_Promocion: promo.promotionValue,
							mdm#Accion: promo.action,
							mdm#Id_Promocion: promo.promotionId,
							mdm#Nombre: promo.name,
							mdm#Descripcion: promo.description,
							mdm#Tipo: promo."type",
							mdm#Fecha_Inicial: promo.startDate,
							mdm#Fecha_Final: promo.endDate,
							mdm#Fecha_Accion: promo.actionDate,
							mdm#actualizacion_extractor: promo.extractorUpdate,
							mdm#Origen: promo.origin,
							mdm#Nivel: promo.level,
							mdm#Tipo_Condicion: promo.conditionType,
							mdm#Id_Promocion_Accion: promo.promotionActionId,
							mdm#Atributo_Promocion: {
								mdm#MDM_Atributo: promo.promotionAttributes map (attr) -> {
									mdm#Atributo: attr.attribute,
									mdm#Valor_Atributo: attr.attributeValue
								}
							}
						}
					},
					mdm#Descuento_Servicio: {
						mdm#MDM_Descuento: detail.serviceDiscounts map (discount) -> {
							mdm#Descuento: discount.discount,
							mdm#Duracion_Descuento: discount.discountDuration,
							mdm#Valor_Descuento: discount.discountValue,
							mdm#Fecha_Inicio_Descuento: discount.discountStartDate,
							mdm#Fecha_Fin_Descuento: discount.discountEndDate,
							mdm#Accion: discount.action,
							mdm#Atributo_Descuento: {
								mdm#MDM_Atributo: discount.discountAttributes map (attr) -> {
									mdm#Atributo: attr.attribute,
									mdm#Valor_Atributo: attr.attributeValue
								}
							}
						}
					},
					mdm#Caracteristica_Servicio: {
						mdm#MDM_Caracteristica_Accion: detail.serviceCharacteristics map (item) -> {
							mdm#Caracteristica: item.characteristic,
							mdm#Valor: item.value,
							mdm#Accion: item.action,
							mdm#actualizacion_extractor: item.extractorUpdate
						}
					},
					mdm#Agendamiento: {
						mdm#MDM_Agendamiento_Servicio: detail.schedules map (schedule) -> {
							mdm#Fecha_Agenda: schedule.scheduledDate,
							mdm#Franja: schedule.timeSlot,
							mdm#Hora: schedule.hour,
							mdm#Estado: schedule.status,
							mdm#Causal: schedule.cause,
							mdm#Fecha_Cumplimiento: schedule.complianceDate,
							mdm#Franja_Cumplimiento: schedule.complianceTimeSlot,
							mdm#Hora_Cumplimiento: schedule.complianceHour
						}
					}
				}
			},
			mdm#Promocion_Orden: {
				mdm#MDM_Promociones: body.orderPromotions map (promo) -> {
					mdm#Id_Promocion: promo.promotionId,
					mdm#Nombre: promo.name,
					mdm#Descripcion: promo.description,
					mdm#Tipo: promo."type",
					mdm#Fecha_Inicial: promo.startDate,
					mdm#Fecha_Final: promo.endDate,
					mdm#Accion: promo.action,
					mdm#Fecha_Accion: promo.actionDate,
					mdm#actualizacion_extractor: promo.extractorUpdate,
					mdm#Origen: promo.origin,
					mdm#Nivel: promo.level,
					mdm#Tipo_Condicion: promo.conditionType,
					mdm#Id_Promocion_Accion: promo.promotionActionId,
					mdm#Atributo_Promocion: {
						mdm#MDM_Atributo: promo.promotionAttributes map (attr) -> {
							mdm#Atributo: attr.attribute,
							mdm#Valor_Atributo: attr.attributeValue
						}
					}
				}
			},
			mdm#set_type: body.setType,
			mdm#ATDP: {
				mdm#HABEAS_DATA: body.atdp.habeasData,
				mdm#FECHA: body.atdp.date,
				mdm#USUARIO: body.atdp.user,
				mdm#CANAL: body.atdp.channel,
				mdm#PQR_ASOCIADA: body.atdp.relatedPqr
			},
			mdm#Servicios_Cliente: {
				mdm#CantidadServiciosMovil: body.customerServices.mobileServicesQuantity,
				mdm#CantidadServiciosFTTX: body.customerServices.fttxServicesQuantity,
				mdm#CantidadServiciosMovilMIX: body.customerServices.mixedMobileServicesQuantity,
				mdm#CantidadServiciosFijaMIX: body.customerServices.mixedFixedServicesQuantity,
				mdm#Servicios: {
					mdm#ServicioUsuario: body.customerServices.services map (service) -> {
						mdm#Id: service.id,
						mdm#Tipo: service."type",
						mdm#Id_Estado: service.statusId,
						mdm#Estado: service.status,
						mdm#Precio: service.price,
						mdm#OrigenMix: service.mixOrigin,
						mdm#NumAgrupacion: service.groupingNumber,
						mdm#Codigo_Producto_Servicio: service.serviceProductCode,
						mdm#Velocidad: service.speed,
						mdm#Fecha_Creacion: service.creationDate,
						mdm#Tecnologia: service.technology
					}
				}
			},
			mdm#Promociones_Condicionadas: {
				mdm#MDM_Promociones: body.conditionalPromotions map (promo) -> {
					mdm#Id_Promocion: promo.promotionId,
					mdm#Nombre: promo.name,
					mdm#Descripcion: promo.description,
					mdm#Tipo: promo."type",
					mdm#Fecha_Inicial: promo.startDate,
					mdm#Fecha_Final: promo.endDate,
					mdm#Accion: promo.action,
					mdm#Fecha_Accion: promo.actionDate,
					mdm#actualizacion_extractor: promo.extractorUpdate,
					mdm#Origen: promo.origin,
					mdm#Nivel: promo.level,
					mdm#Tipo_Condicion: promo.conditionType,
					mdm#Id_Promocion_Accion: promo.promotionActionId,
					mdm#Atributo_Promocion: {
						mdm#MDM_Atributo: promo.promotionAttributes map (attr) -> {
							mdm#Atributo: attr.attribute,
							mdm#Valor_Atributo: attr.attributeValue
						}
					}
				}
			}
		}
	}
}