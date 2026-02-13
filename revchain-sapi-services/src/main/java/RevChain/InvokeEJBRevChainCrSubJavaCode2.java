package RevChain;

import java.util.*;
import java.rmi.Remote;

import javax.ejb.EJBHome;
import javax.naming.InitialContext;
import java.io.*;
import java.lang.reflect.Method;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

public class InvokeEJBRevChainCrSubJavaCode2 {
	/****** START SET/GET METHOD, DO NOT MODIFY *****/
	protected String Factory = "";
	protected String ContextURL = "";
	protected String JNDIName = "";
	protected String UserName = "";
	protected String Password = "";
	protected String InputXMLString = "";
	protected String OutputXMLString = "";
//	private static Logger log = LogManager.getRootLogger();

	public InvokeEJBRevChainCrSubJavaCode2(String factory, String contextURL, String jNDIName, String userName,
			String password, String inputXMLString) {
		super();
		Factory = factory;
		ContextURL = contextURL;
		JNDIName = jNDIName;
		UserName = userName;
		Password = password;
		InputXMLString = inputXMLString;		
	}

	public String getFactory() {
		return Factory;
	}

	public void setFactory(String val) {
		Factory = val;
	}

	public String getContextURL() {
		return ContextURL;
	}

	public void setContextURL(String val) {
		ContextURL = val;
	}

	public String getJNDIName() {
		return JNDIName;
	}

	public void setJNDIName(String val) {
		JNDIName = val;
	}

	public String getUserName() {
		return UserName;
	}

	public void setUserName(String val) {
		UserName = val;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String val) {
		Password = val;
	}

	public String getInputXMLString() {
		return InputXMLString;
	}

	public void setInputXMLString(String val) {
		InputXMLString = val;
	}

	public String getOutputXMLString() {
		return OutputXMLString;
	}

	public void setOutputXMLString(String val) {
		OutputXMLString = val;
	}

	/****** END SET/GET METHOD, DO NOT MODIFY *****/
	public InvokeEJBRevChainCrSubJavaCode2() {
	}

	public void invoke() throws Exception {
		/*
		 * Available Variables: DO NOT MODIFY In : String Factory In : String ContextURL
		 * In : String JNDIName In : String UserName In : String Password In : String
		 * InputXMLString Out : String OutputXMLString Available Variables: DO NOT
		 * MODIFY
		 *****/

// Creating context
		Properties props = new Properties();
		props.put(javax.naming.Context.INITIAL_CONTEXT_FACTORY, getFactory());
		props.put(javax.naming.Context.PROVIDER_URL, getContextURL());

		if (getUserName() != null && !getUserName().trim().equals("") && getPassword() != null
				&& !getPassword().trim().equals("")) {
			props.put(javax.naming.Context.SECURITY_PRINCIPAL, getUserName());
			props.put(javax.naming.Context.SECURITY_CREDENTIALS, getPassword());
		}
		javax.naming.Context context = new javax.naming.InitialContext(props);

		Object aux = context.lookup(getJNDIName());
//		log.info("aux: " + aux);
/*
		// Lookup for remote object
				com.daleen.process.CreateSubscriber.CreateSubscriberXMLHome createSubscriberHome;
				com.daleen.process.CreateSubscriber.CreateSubscriberXML createSubscriber;
				createSubscriberHome = (com.daleen.process.CreateSubscriber.CreateSubscriberXMLHome) context
						.lookup(getJNDIName());
				createSubscriber = (com.daleen.process.CreateSubscriber.CreateSubscriberXML) createSubscriberHome.create();

		// Invoke remote method
				try {
					com.daleen.PubSub.XmlProcessDetail processDetail = createSubscriber.processMessage(getInputXMLString());
					setOutputXMLString(processDetail.getText());
					System.out.println(getOutputXMLString());
				} catch (com.daleen.exception.RevChainXmlException xe) {
					setOutputXMLString(xe.getXmlProcessDetail().getText());
				}
*/
		// Lookup for remote object
				/*com.daleen.process.CreateSubscriber.CreateSubscriberXMLHome createSubscriberHome;
				//createSubscriberHome = (CreateSubscriberXMLHome) PortableRemoteObject.narrow(aux, com.daleen.process.CreateSubscriber.CreateSubscriberXMLHome.class);
				Method create = aux.getClass().getMethod("create");
				Object createSubscriber = create.invoke(aux);

		// Invoke remote method
				Method processMessage = createSubscriber.getClass().getMethod("processMessage", String.class);
				Object processDetail = processMessage.invoke(createSubscriber, getInputXMLString());
				
				Method getText = processDetail.getClass().getMethod("getText");
				setOutputXMLString((String) getText.invoke(processDetail));
				System.out.println(getOutputXMLString());*/
	}
}