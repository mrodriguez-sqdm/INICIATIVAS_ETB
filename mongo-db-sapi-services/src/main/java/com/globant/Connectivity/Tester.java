package com.globant.Connectivity;

import java.net.InetSocketAddress;
import java.net.Socket;

public class Tester {

	@SuppressWarnings("resource")
	public String testHost(final String host, final Integer port) {
		try {
            System.out.println("Looking for "+ host + ":" + port);
            Socket socket = new Socket();
            socket.connect(new InetSocketAddress(host, port.intValue()), 3000);          
            return "Up";
         } catch (Exception e) {
				System.out.println("Exception occured" + e);
			}
		return "Down";
	}
}
