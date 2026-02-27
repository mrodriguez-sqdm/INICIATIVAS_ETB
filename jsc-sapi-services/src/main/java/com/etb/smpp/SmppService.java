package com.etb.smpp;

import org.jsmpp.bean.BindType;
import org.jsmpp.bean.ESMClass;
import org.jsmpp.bean.GeneralDataCoding;
import org.jsmpp.bean.NumberingPlanIndicator;
import org.jsmpp.bean.RegisteredDelivery;
import org.jsmpp.bean.SMSCDeliveryReceipt;
import org.jsmpp.bean.TypeOfNumber;
import org.jsmpp.session.BindParameter;
import org.jsmpp.session.SMPPSession;

/**
 * Cliente SMPP simple para integración con MuleSoft Anypoint Studio
 * Método principal que recibe todos los parámetros de conexión
 */
public class SmppService {
    
    /**
     * Método principal para enviar SMS desde MuleSoft
     * 
     * @param host Host del servidor SMPP
     * @param port Puerto del servidor SMPP
     * @param systemId ID del sistema para autenticación
     * @param password Contraseña para autenticación
     * @param systemType Tipo de sistema (opcional, por defecto "SMPP")
     * @param phoneNumber Número de teléfono destino
     * @param message Mensaje SMS a enviar
     * @param sourceAddress Dirección origen (opcional, por defecto usa systemId)
     * @return true si el mensaje se envió exitosamente, false en caso contrario
     */
    public static String sendSMS(String host, int port, String systemId, String password, 
                                 String systemType, String phoneNumber, String message, 
                                 String sourceAddress) {
        
        SMPPSession session = null;
        
        try {
            // Crear sesión SMPP
            session = new SMPPSession();
            
            // Conectar al servidor SMPP
            session.connectAndBind(host, port, 
                new BindParameter(BindType.BIND_TRX, systemId, password, systemType != null ? systemType : "SMPP", 
                                TypeOfNumber.ALPHANUMERIC, NumberingPlanIndicator.UNKNOWN, null));
            
            // Configurar parámetros del mensaje
            String sourceAddr = "7777";
            
            // Enviar mensaje
            String messageId = session.submitShortMessage(
                "CMT",                    								// serviceType
                TypeOfNumber.ALPHANUMERIC, 								// sourceAddrTon
                NumberingPlanIndicator.UNKNOWN, 						// sourceAddrNpi
                sourceAddr,               								// sourceAddr
                TypeOfNumber.INTERNATIONAL, 							// destAddrTon
                NumberingPlanIndicator.ISDN, 							// destAddrNpi
                phoneNumber,              								// destinationAddr
                new ESMClass(),           								// esmClass
                (byte) 0,                 								// protocolId
                (byte) 0,                 								// priorityFlag
                null,                     								// scheduleDeliveryTime
                null,                     								// validityPeriod
                new RegisteredDelivery(SMSCDeliveryReceipt.DEFAULT), 	// registeredDelivery
                (byte) 0,                 								// replaceIfPresentFlag
                new GeneralDataCoding(),  								// dataCoding
                (byte) 0,                 								// smDefaultMsgId
                message.getBytes()        								// shortMessage
            );
            
            return messageId;
            
        } catch (Exception e) {
            System.err.println("Error al enviar mensaje: " + e.getMessage());
            return null;
        } finally {
            try {
                if (session != null && session.getSessionState().isBound()) {
                    session.unbindAndClose();
                }
            } catch (Exception e) {
                System.err.println("Error al cerrar sesión: " + e.getMessage());
            }
        }
    }
    
    /**
     * Método entrada para envío de SMS
     * 
     * @param host Host del servidor SMPP
     * @param port Puerto del servidor SMPP
     * @param systemId ID del sistema
     * @param password Contraseña
     * @param phoneNumber Número de teléfono
     * @param message Mensaje
     * @return true si se envió exitosamente
     */
    public static String sendSMS(String host, String port, String systemId, String password, 
                                 String phoneNumber, String message) {
        return sendSMS(host, Integer.parseInt(port), systemId, password, "SMPP", phoneNumber, message, null);
    }
    
    /**
     * Método de prueba para verificar la funcionalidad
     */
    public static void main(String[] args) {
        // Ejemplo de uso
        String result = sendSMS(
            "localhost",           			// host
            "2775",                 		// port
            "test_user",          			// systemId
            "test_password",      			// password
            "+1234567890",        			// phoneNumber
            "Hola desde SMPP Mulesoft!" 	// message
        );
        
        if (result != null) {
            System.out.println("Mensaje enviado exitosamente");
        } else {
            System.out.println("Error al enviar SMS");
        }
    }
}
