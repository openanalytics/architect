package eu.openanalytics.architect.rmi;

import java.io.IOException;
import java.net.URI;
import java.nio.ByteBuffer;

import javax.websocket.CloseReason;
import javax.websocket.ContainerProvider;
import javax.websocket.Endpoint;
import javax.websocket.EndpointConfig;
import javax.websocket.MessageHandler;
import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.WebSocketContainer;

public class WSClientEndpoint extends Endpoint {

	private URI endpointURI;
	private Session userSession = null;
	private MessageCallback handler;

	public WSClientEndpoint(URI endpointURI, MessageCallback handler) {
		try {
			this.endpointURI = endpointURI;
			this.handler = handler;
			WebSocketContainer container = ContainerProvider.getWebSocketContainer();
			container.connectToServer(this, endpointURI);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public void onOpen(Session session, EndpointConfig config) {
		this.userSession = session;
		session.addMessageHandler(new MessageHandler.Whole<byte[]>() {
			@OnMessage
			public void onMessage(byte[] message) {
				try {
					handler.handle(message);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		});
	}

	@Override
	public void onError(Session userSession, Throwable t) {
		t.printStackTrace();
	}
	
	@Override
	public void onClose(Session userSession, CloseReason reason) {
		shutdown();
		this.userSession = null;
	}

	public void sendMessage(byte[] message) {
		this.userSession.getAsyncRemote().sendBinary(ByteBuffer.wrap(message));
	}
	
	public void shutdown() {
		try {
			userSession.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public URI getEndpointURI() {
		return endpointURI;
	}
	
	public static interface MessageCallback {
		public void handle(byte[] msg) throws IOException;
	}
}