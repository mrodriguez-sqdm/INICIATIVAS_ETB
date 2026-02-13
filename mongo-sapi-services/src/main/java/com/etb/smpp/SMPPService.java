package com.etb.smpp;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.jsmpp.InvalidResponseException;
import org.jsmpp.PDUException;
import org.jsmpp.bean.Alphabet;
import org.jsmpp.bean.BindType;
import org.jsmpp.bean.DataCodings;
import org.jsmpp.bean.ESMClass;
import org.jsmpp.bean.GeneralDataCoding;
import org.jsmpp.bean.MessageClass;
import org.jsmpp.bean.NumberingPlanIndicator;
import org.jsmpp.bean.OptionalParameter;
import org.jsmpp.bean.OptionalParameters;
import org.jsmpp.bean.RegisteredDelivery;
import org.jsmpp.bean.SMSCDeliveryReceipt;
import org.jsmpp.bean.TypeOfNumber;
import org.jsmpp.extra.NegativeResponseException;
import org.jsmpp.extra.ResponseTimeoutException;
import org.jsmpp.session.BindParameter;
import org.jsmpp.session.SMPPSession;
import org.jsmpp.session.SubmitSmResult;

public class SMPPService {

	public String sendSMS(String smppHost, int port, String systemId, String password, String sourceAddr,
			String destAddr, String message) throws PDUException, ResponseTimeoutException, InvalidResponseException, NegativeResponseException, IOException {

		SMPPSession session = new SMPPSession();

			// 1. Validaciones básicas
			if (message == null || message.trim().isEmpty()) {
				return "Error: El mensaje no puede estar vacío";
			}

			// 2. Establecer la conexión y hacer bind
			session.connectAndBind(smppHost, port, new BindParameter(BindType.BIND_TX, systemId, password, "cp",
					TypeOfNumber.UNKNOWN, NumberingPlanIndicator.UNKNOWN, null));
			
			GeneralDataCoding dataCoding = new GeneralDataCoding(Alphabet.ALPHA_UCS2, MessageClass.CLASS1, false);

			// 3. Preparar y enviar el mensaje
			SubmitSmResult messageId = session.submitShortMessage("CMT", // Service Type
					TypeOfNumber.INTERNATIONAL, // Source TON
					NumberingPlanIndicator.ISDN, // Source NPI
					sourceAddr, // Source address
					TypeOfNumber.INTERNATIONAL, // Destination TON
					NumberingPlanIndicator.ISDN, // Destination NPI
					destAddr, // Destination address
					new ESMClass(), // ESM Class
					(byte) 0, // Protocol ID
					(byte) 1, // Priority
					null, null, // ScheduleDeliveryTime, ValidityPeriod
					new RegisteredDelivery(SMSCDeliveryReceipt.SUCCESS_FAILURE), // Delivery receipt
					(byte) 0, // Replace if present
					dataCoding, // Codificación del mensaje (UCS2 para UTF-16)
					(byte) 0, // Default msg ID
					message.getBytes(StandardCharsets.UTF_16) // Mensaje codificado
			);

			printMessages(messageId);
			

						if (session.getSessionState().isBound()) {
							session.unbindAndClose();
						}
						
			return messageId.getMessageId();

	}
	
	private void printMessages(SubmitSmResult messageId)
	{
		// Mostrar el messageId
		System.out.println("✅ Message ID: " + messageId.getMessageId());
		
		OptionalParameter.Congestion_state congestionState = OptionalParameters.get(OptionalParameter.Congestion_state.class,
				messageId.getOptionalParameters());

		// Mostrar optional parameters si existen
		OptionalParameter[] optionalParameters = messageId.getOptionalParameters();

		if (optionalParameters != null && optionalParameters.length > 0) {
		    System.out.println("📦 Optional Parameters:");
		    for (OptionalParameter param : optionalParameters) {
		        System.out.println("  - " + param);
		    }
		} else {
		    System.out.println("ℹ️ No optional parameters returned.");
		}
	}

}
