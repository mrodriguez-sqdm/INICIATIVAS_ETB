package com.etb;

import java.lang.reflect.Method;
import java.util.Properties;
import javax.naming.Context;

public class RevchainServices {
	/* Consultar datos de la cuenta - Complementos
	 * Crear cuenta
	 * Crear servicio
	 * */
	public static  Object getCycle(String xmlString, RevchainSettings settings) {	 
			Properties p = new Properties();
			p.put(Context.INITIAL_CONTEXT_FACTORY, settings.getContext());
			p.put(Context.PROVIDER_URL, settings.getUrl());
			p.put(Context.SECURITY_PRINCIPAL, settings.getUser());
			p.put(Context.SECURITY_CREDENTIALS, settings.getPassword());
		
			try {
				javax.naming.Context context = new javax.naming.InitialContext(p);
				//com.daleen.process.CreateSubscriber.CreateSubscriberXMLHome createSubscriberHome;			
				Object createSubscriber = context.lookup(settings.getSubscriber());				
				Method processMessage = createSubscriber.getClass().getMethod("processMessage", String.class);
				Object processDetail = processMessage.invoke(createSubscriber, xmlString);				
				System.out.println((String) processDetail);	
				return processDetail;
			}catch(Exception e) {
				e.printStackTrace();
				return null;
			}
	}
	public static Object postService(String xmlString, RevchainSettings settings) {
		Properties p = new Properties();
		p.put(Context.INITIAL_CONTEXT_FACTORY, settings.getContext());
		p.put(Context.PROVIDER_URL, settings.getUrl());
		p.put(Context.SECURITY_PRINCIPAL, settings.getUser());
		p.put(Context.SECURITY_CREDENTIALS, settings.getPassword());
	
		try {
			javax.naming.Context context = new javax.naming.InitialContext(p);
			//com.daleen.process.CreateSubscriber.CreateSubscriberXMLHome createSubscriberHome;
			Object createSubscriberHome = context.lookup(settings.getSubscriber());
			Method subscriberCreator = createSubscriberHome.getClass().getMethod("create");
			Object createSubscriber = subscriberCreator.invoke(createSubscriberHome);

			Method processMessage = createSubscriber.getClass().getMethod("processMessage", String.class);
			Object processDetail = processMessage.invoke(createSubscriber, xmlString);
			return processDetail;
		}catch(Exception e) {
			return e.getCause();
		}
	}
}
