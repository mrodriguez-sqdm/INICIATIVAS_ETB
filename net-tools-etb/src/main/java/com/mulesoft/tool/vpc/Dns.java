package com.mulesoft.tool.vpc;

import java.net.InetAddress;

public class Dns {
	public Dns()
	{
	}

	public static String call(String host) throws Exception {
		java.net.InetAddress address = InetAddress.getByName(host); 
		return address.getHostAddress();
	}

}