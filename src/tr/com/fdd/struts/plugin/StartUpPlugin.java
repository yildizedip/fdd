package tr.com.fdd.struts.plugin;

import java.util.Enumeration;

import javax.servlet.ServletException;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.config.ModuleConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class StartUpPlugin  implements org.apache.struts.action.PlugIn{
	
	
	private static Logger logger = LoggerFactory.getLogger(StartUpPlugin.class);

	@Override
	public void destroy() {
		logger.info("StartUpPlugin destroyed.");
		
	}

	@Override
	public void init(ActionServlet arg0, ModuleConfig arg1)
			throws ServletException {

		logger.info("Start Up Plug in  init...");
		Enumeration<?> en= arg0.getInitParameterNames();
		int i=0;
		while(en.hasMoreElements())
		{
			logger.info("Action servlet init param "+ i++ +" = "+en.nextElement());
		}		
	}
}
