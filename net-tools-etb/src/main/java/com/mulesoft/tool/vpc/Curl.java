package com.mulesoft.tool.vpc;


import java.io.IOException;
import java.io.InputStream;
import java.io.SequenceInputStream;


public class Curl{
	public Curl()
	{
	}
	public static InputStream call(String host, String port, String path) throws IOException {
		
		String url = "";
		url = url.concat(host.concat(":").concat(port).concat("/").concat(path));
		//-i include protocol headers
		//-L follow redirects
		//-k insecure
		//-E cert status
		ProcessBuilder pb = new ProcessBuilder("curl","-k", "-E", "-i","-L", url);
		Process p = pb.start();
		SequenceInputStream s = new SequenceInputStream(p.getInputStream(), p.getErrorStream());	
		return s;
	}
}
