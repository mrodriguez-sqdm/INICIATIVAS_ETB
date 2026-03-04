package com.mulesoft.tool.vpc;

import java.io.InputStream;
import java.io.SequenceInputStream;

public class TraceRoute {

	public TraceRoute()
	{
	}

	public static InputStream call(String host) throws Exception {
		ProcessBuilder pb = new ProcessBuilder("traceroute", "-w", "3", "-q", "1", "-m", "18", "-n", host);
		Process p = pb.start();
		SequenceInputStream s = new SequenceInputStream(p.getInputStream(), p.getErrorStream());
		return s;
	}

}
