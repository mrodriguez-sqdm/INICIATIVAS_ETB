package com.etb;

public class RevchainSettings {
	/* Consultar datos de la cuenta - Complementos
	 * Crear cuenta
	 * Crear servicio
	 * */
	private String context;
	private String url;
	private String user;
	private String password;
	private String subscriber;
	
	public RevchainSettings(String context, String url, String user, String password, String subscriber) {
		this.context = context;
		this.url = url;
		this.user = user;
		this.password = password;
		this.subscriber = subscriber;
	}
	
	public String getContext() {
		return this.context;
	}
	
	public String getUser() {
		return this.user;
	}
	
	public String getUrl() {
		return this.url;
	}
	
	public String getPassword() {
		return this.password;
	}
	
	public String getSubscriber() {
		return this.subscriber;
	}
}
