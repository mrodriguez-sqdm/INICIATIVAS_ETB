package RevChain;

import java.util.*;
import java.io.*;

public class InvokeEJBRevChainServJavaCode {
	/****** START SET/GET METHOD, DO NOT MODIFY *****/
	protected String Factory = "";
	protected String ContextURL = "";
	protected String JNDIName = "";
	protected String UserName = "";
	protected String Password = "";
	protected String InputXMLString = "";
	protected String OutputXMLString = "";

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
	public InvokeEJBRevChainServJavaCode() {
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

// Lookup for remote object
		/*com.daleen.process.ProvisionSubscriber.ProvisionSubscriberXMLHome provisionSubscriberHome;
		com.daleen.process.ProvisionSubscriber.ProvisionSubscriberXML provisionSubscriber;
		provisionSubscriberHome = (com.daleen.process.ProvisionSubscriber.ProvisionSubscriberXMLHome) context
				.lookup(getJNDIName());
		provisionSubscriber = (com.daleen.process.ProvisionSubscriber.ProvisionSubscriberXML) provisionSubscriberHome
				.create();

// Invoke remote method
		try {
			com.daleen.PubSub.XmlProcessDetail processDetail = provisionSubscriber.processMessage(getInputXMLString());
			setOutputXMLString(processDetail.getText());
		} catch (com.daleen.exception.RevChainXmlException xe) {
			setOutputXMLString(xe.getXmlProcessDetail().getText());
		}*/
	}
}