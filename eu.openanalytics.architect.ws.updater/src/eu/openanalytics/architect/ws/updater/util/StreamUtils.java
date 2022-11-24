package eu.openanalytics.architect.ws.updater.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class StreamUtils {

	public static void copyAndClose(InputStream in, OutputStream out) throws IOException {
		try {
			byte[] buffer = new byte[4096];
			int len = 0;
			do {
				len = in.read(buffer, 0, buffer.length);
				if (len > 0) out.write(buffer, 0, len);
			} while (len >= 0);
		} finally {
			if (in != null) try { in.close(); } catch	(IOException e) {}
			if (out != null) try { out.close(); } catch	(IOException e) {}
		}
	}
	
	public static void copyAndClose(InputStream in, OutputStream out, int bufferSize) throws IOException {
		try {
			byte[] buffer = new byte[bufferSize];
			int len = 0;
			do {
				len = in.read(buffer, 0, buffer.length);
				if (len > 0) out.write(buffer, 0, len);
			} while (len >= 0);
		} finally {
			if (in != null) try { in.close(); } catch	(IOException e) {}
			if (out != null) try { out.close(); } catch	(IOException e) {}
		}
	}
}
