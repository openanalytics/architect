package eu.openanalytics.architect.rtools;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;


public class Activator implements BundleActivator {
	
	
	public static final String BUNDLE_ID= "eu.openanalytics.architect.rtools"; //$NON-NLS-1$
	
	
	private static BundleContext context;
	
	static BundleContext getContext() {
		return context;
	}
	
	
	public void start(BundleContext bundleContext) throws Exception {
		Activator.context = bundleContext;
	}
	
	public void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null;
	}
	
}
