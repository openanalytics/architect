package eu.openanalytics.architect.rmi;

import java.io.IOException;
import java.lang.reflect.Method;
import java.net.URL;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.RMISocketFactory;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.apache.http.NameValuePair;
import org.apache.http.client.CookieStore;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.util.EntityUtils;
import org.eclipse.core.runtime.CoreException;
import org.eclipse.core.runtime.IProgressMonitor;
import org.eclipse.core.runtime.IStatus;
import org.eclipse.core.runtime.Status;
import org.eclipse.debug.core.ILaunch;
import org.eclipse.debug.core.ILaunchConfiguration;
import org.eclipse.debug.core.model.IProcess;
import org.eclipse.debug.core.model.LaunchConfigurationDelegate;
import org.eclipse.statet.ecommons.debug.core.util.LaunchUtils;
import org.eclipse.statet.ecommons.rmi.core.RMIAddress;
import org.eclipse.statet.ecommons.ui.util.UIAccess;
import org.eclipse.statet.internal.r.console.ui.launching.RConsoleRJLaunchDelegate;
import org.eclipse.statet.nico.core.runtime.IToolEventHandler;
import org.eclipse.statet.nico.core.runtime.ToolRunner;
import org.eclipse.statet.nico.core.util.TrackingConfiguration;
import org.eclipse.statet.nico.ui.NicoUITools;
import org.eclipse.statet.nico.ui.console.NIConsoleColorAdapter;
import org.eclipse.statet.nico.ui.util.LoginHandler;
import org.eclipse.statet.nico.ui.util.WorkbenchStatusHandler;
import org.eclipse.statet.r.console.core.RProcess;
import org.eclipse.statet.r.console.ui.RConsole;
import org.eclipse.statet.r.console.ui.launching.RConsoleLaunching;
import org.eclipse.statet.r.core.renv.IREnvConfiguration;
import org.eclipse.statet.r.nico.RWorkspaceConfig;
import org.eclipse.statet.r.nico.impl.RjsController;
import org.eclipse.statet.r.nico.impl.RjsController.RjsConnection;
import org.eclipse.statet.rj.server.RjsComConfig;
import org.eclipse.statet.rj.server.Server;
import org.eclipse.ui.IWorkbenchPage;

import eu.openanalytics.architect.Activator;

@SuppressWarnings("restriction")
public class WebSocketRConsoleLaunchDelegate extends LaunchConfigurationDelegate {

	public static final String ATTR_ADDRESS = WebSocketRConsoleLaunchDelegate.class.getName() + "/address";
	public static final String ATTR_USERNAME = WebSocketRConsoleLaunchDelegate.class.getName() + "/username";
	public static final String ATTR_PASSWORD = WebSocketRConsoleLaunchDelegate.class.getName() + "/password";

	@Override
	public void launch(ILaunchConfiguration configuration, String mode, ILaunch launch, IProgressMonitor monitor) throws CoreException {
		if (monitor.isCanceled()) return;

		String address = configuration.getAttribute(ATTR_ADDRESS, (String) null);
		String username = configuration.getAttribute(ATTR_USERNAME, (String) null);
		String password = configuration.getAttribute(ATTR_PASSWORD, (String) null);
		
		String endpoint = null;
		String session = "remote_test";
		
		CloseableHttpClient httpclient = null;
		try {
			httpclient = HttpClients.createDefault();
			CookieStore cookieStore = new BasicCookieStore();
			HttpContext httpContext = new BasicHttpContext();
			httpContext.setAttribute(HttpClientContext.COOKIE_STORE, cookieStore);
			
			HttpPost loginPost = new HttpPost(address + "/login");
			List<NameValuePair> params = new ArrayList<NameValuePair>();
		    params.add(new BasicNameValuePair("username", username));
		    params.add(new BasicNameValuePair("password", password));
		    loginPost.setEntity(new UrlEncodedFormEntity(params));
		    
			CloseableHttpResponse res = httpclient.execute(loginPost, httpContext);
			
			HttpPost launchSessionPost = new HttpPost(address + "/api/proxy");
			res = httpclient.execute(launchSessionPost, httpContext);
			String body = EntityUtils.toString(res.getEntity());

			endpoint = body.substring(body.indexOf("endpoint/"), body.indexOf("backend") - 3);
			endpoint = address.replace("http:", "ws:").replace("https:", "wss:") + "/" + endpoint;
		} catch (Exception e) {
			throw new CoreException(new Status(IStatus.ERROR, Activator.PLUGIN_ID, "Failed to authenticate at " + address, e));
		} finally {
			if (httpclient != null) try { httpclient.close(); } catch (IOException e) {}
		}
		
		//TODO Still many things missing (e.g. reconnect), see RRemoteConsoleLaunchDelegate.java
		try {
			final long timestamp = System.currentTimeMillis();

			String host = new URL(endpoint.replace("ws:", "http:").replace("wss:", "https:")).getHost();
			RMISocketFactory socketFactory = new WSClientSocketFactory(endpoint);
			Registry registry = LocateRegistry.getRegistry(host, 0, socketFactory);
			Object remote = registry.lookup(session);

			if (remote instanceof Server) {
				final Server server = (Server) remote;
				final int state = server.getState();
				if (state > Server.S_NOT_STARTED) throw new IllegalStateException("Server state: " + state);
			}

			RMIAddress rmiAddress = new RMIAddress(String.format("//%s/%s", host, session));
			final RjsConnection connection = RjsController.lookup(registry, null, rmiAddress);

			String[] args = new String[0];
			IREnvConfiguration rEnv= null;
			
			RProcess process = new RProcess(launch, rEnv,
					LaunchUtils.createLaunchPrefix(configuration),
					"-" + " / RJ " + rmiAddress.toString() + ' ' + LaunchUtils.createProcessTimestamp(timestamp), //$NON-NLS-1$ //$NON-NLS-2$
					rmiAddress.toString(),
					null,
					timestamp);
			process.setAttribute(IProcess.ATTR_CMDLINE, rmiAddress.toString() + '\n' + Arrays.toString(args));

			HashMap<String, Object> rjsProperties = new HashMap<String, Object>();
			rjsProperties.put(RjsComConfig.RJ_DATA_STRUCTS_LISTS_MAX_LENGTH_PROPERTY_ID,
					configuration.getAttribute(RConsoleLaunching.ATTR_OBJECTDB_LISTS_MAX_LENGTH, 10000));
			rjsProperties.put(RjsComConfig.RJ_DATA_STRUCTS_ENVS_MAX_LENGTH_PROPERTY_ID,
					configuration.getAttribute(RConsoleLaunching.ATTR_OBJECTDB_ENVS_MAX_LENGTH, 10000));
			rjsProperties.put("rj.session.startup.time", timestamp); //$NON-NLS-1$

			RjsController controller = new RjsController(process, rmiAddress, connection, new HashMap<String, Object>(),
					RjsController.RJS_SETUP_CONSOLE, args, rjsProperties, null,
					new RWorkspaceConfig(), new ArrayList<TrackingConfiguration>());
			
			process.init(controller);
			
			RConsoleLaunching.registerDefaultHandlerTo(controller);
			controller.addCommandHandler(IToolEventHandler.LOGIN_REQUEST_EVENT_ID, new LoginHandler());
			
			Method[] methods = RConsoleRJLaunchDelegate.class.getDeclaredMethods();
			for (Method m: methods) {
				if (m.getName().equals("initConsoleOptions")) {
					m.setAccessible(true);
					m.invoke(null, controller, rEnv, configuration, mode, true);
				}
			}
			
			final IWorkbenchPage page = UIAccess.getActiveWorkbenchPage(false);
			
			final RConsole console = new RConsole(process, new NIConsoleColorAdapter());
			NicoUITools.startConsoleLazy(console, page,
					configuration.getAttribute(RConsoleLaunching.ATTR_PIN_CONSOLE, false));
			new ToolRunner().runInBackgroundThread(process, new WorkbenchStatusHandler());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	protected boolean saveBeforeLaunch(final ILaunchConfiguration configuration, final String mode, final IProgressMonitor monitor) throws CoreException {
		return true; // continue launch
	}

	@Override
	public boolean buildForLaunch(final ILaunchConfiguration configuration, final String mode, final IProgressMonitor monitor) throws CoreException {
		return false; // no incremental build
	}
}
