package com.mulesoft.tool.vpc;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.net.InetSocketAddress;
import java.net.Socket;

public class SocketTool {

	public SocketTool()
	{
	}

	public static String call(String host, String port) {
		try {
			
			Socket socket = new Socket();
			socket.connect(new InetSocketAddress(host, Integer.parseInt(port)), 10000);
			socket.setSoTimeout(10000);
			if (socket.isConnected()) {
				socket.getInputStream();
			}
			socket.close();
		} catch (Exception e) {
			ByteArrayOutputStream b = new ByteArrayOutputStream();
			e.printStackTrace(new PrintStream(b));
			return b.toString();
		}

		return "Connection successful";
	}
}
