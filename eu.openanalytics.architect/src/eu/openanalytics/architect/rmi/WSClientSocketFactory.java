package eu.openanalytics.architect.rmi;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PipedInputStream;
import java.io.PipedOutputStream;
import java.io.Serializable;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketAddress;
import java.net.SocketException;
import java.net.SocketImpl;
import java.net.SocketOptions;
import java.net.URI;
import java.net.URISyntaxException;
import java.rmi.server.RMISocketFactory;

import eu.openanalytics.architect.rmi.WSClientEndpoint.MessageCallback;

public class WSClientSocketFactory extends RMISocketFactory implements Serializable {

	private static final long serialVersionUID = -8831317967774358699L;

	private String endpointURL;
	
	public WSClientSocketFactory(String endpointURL) {
		this.endpointURL = endpointURL;
	}
	
	@Override
	public Socket createSocket(String host, int port) throws IOException {
		return new WSSocket(host, port);
	}

	@Override
	public ServerSocket createServerSocket(int port) throws IOException {
		throw new UnsupportedOperationException("RMIServerSocketFactory is not implemented");
	}
	
	public class WSSocket extends Socket {
		public WSSocket(String host, int port) throws IOException {
			super(new WSSocketImpl());
			connect(InetSocketAddress.createUnresolved(host, port));
		}
	}

	private class WSSocketImpl extends SocketImpl {

		private WSClientEndpoint endpoint;
		private InputStream inputStream;
		private OutputStream outputStream;

		@Override
		protected void create(final boolean stream) throws IOException {
			if (!stream) throw new IOException("Not supported");
		}

		@Override
		protected void connect(final String host, final int port) throws IOException {
			connect(InetSocketAddress.createUnresolved(host, port), 0);
		}
		@Override
		protected void connect(final InetAddress address, final int port) throws IOException {
			connect(new InetSocketAddress(address, port), 0);
		}
		@Override
		protected void connect(final SocketAddress address, final int timeout) throws IOException {
			final InetSocketAddress inetAddress = ((InetSocketAddress) address);
			if (this.localport != 0) throw new IOException("Not supported: reconnect to " + address.toString());

			this.address = inetAddress.getAddress();
			this.port = inetAddress.getPort();
			this.localport = -1;

			final PipedOutputStream pipedOutput = new PipedOutputStream();
			inputStream = new PipedInputStream(pipedOutput);

			outputStream = new OutputStream() {
				@Override
				public void write(int b) throws IOException {
					endpoint.sendMessage(new byte[] {(byte) b});
				}
				@Override
				public void write(byte[] b, int off, int len) throws IOException {
					byte[] msg = new byte[len];
					System.arraycopy(b, off, msg, 0, len);
					endpoint.sendMessage(msg);
				}
			};

			try {
				String rmiPort = "" + inetAddress.getPort();
				URI uri = new URI(endpointURL);

				System.out.println("Connecting to " + uri + " (RMI target port: " + rmiPort + ")");
				endpoint = new WSClientEndpoint(uri, new MessageCallback() {
					@Override
					public void handle(byte[] msg) throws IOException {
						pipedOutput.write(msg);
						pipedOutput.flush();
					}
				});
				endpoint.sendMessage(rmiPort.getBytes());
			} catch (URISyntaxException e) {
				throw new IOException("Failed to identify target URI", e);
			}
		}

		@Override
		protected void bind(final InetAddress host, final int port) throws IOException {
			throw new IOException("Not supported");
		}

		@Override
		protected void listen(final int backlog) throws IOException {
			throw new IOException("Not supported");
		}

		@Override
		protected void accept(final SocketImpl s) throws IOException {
			throw new IOException("Not supported");
		}

		@Override
		public InputStream getInputStream() throws IOException {
			return inputStream;
		}

		@Override
		public OutputStream getOutputStream() throws IOException {
			return outputStream;
		}

		@Override
		protected int available() throws IOException {
			return inputStream.available();
		}

		@Override
		protected void close() throws IOException {
			System.out.println("Closing connection to " + endpoint.getEndpointURI());
			localport = -1;
			endpoint.shutdown();
		}

		@Override
		protected void shutdownInput() throws IOException {
			inputStream.close();
		}

		@Override
		protected void shutdownOutput() throws IOException {
			outputStream.close();
		}

		@Override
		protected void sendUrgentData(final int data) throws IOException {
			throw new IOException("Not supported");
		}

		@Override
		public void setOption(final int optID, final Object value) throws SocketException {
			return;
		}

		@Override
		public Object getOption(final int optID) throws SocketException {
			switch (optID) {
			case SocketOptions.TCP_NODELAY:
				return Boolean.TRUE;
			case SocketOptions.SO_KEEPALIVE:
				return Boolean.FALSE;
			case SocketOptions.SO_TIMEOUT:
				return Integer.valueOf(0);
			case SocketOptions.SO_SNDBUF:
				return 1024;
			case SocketOptions.SO_RCVBUF:
				return 1024;
			default:
				break;
			}
			throw new SocketException("Not supported: option= " + optID);
		}

	}
}