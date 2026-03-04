package com.mulesoft.tool.vpc;

import java.io.InputStream;
import java.io.SequenceInputStream;

public class Ping {

	public Ping()
	{
	}

	public static InputStream call(String host) throws Exception {
		ProcessBuilder pb = new ProcessBuilder("ping", "-c", "4", host);
		Process p = pb.start();
		SequenceInputStream s = new SequenceInputStream(p.getInputStream(), p.getErrorStream());
		return s;
	}

}
