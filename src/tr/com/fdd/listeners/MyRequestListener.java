package tr.com.fdd.listeners;

import java.io.UnsupportedEncodingException;

import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;
import javax.servlet.http.HttpServletRequest;

/**
 * Application Lifecycle Listener implementation class MyRequestListener
 *
 */
public class MyRequestListener implements ServletRequestListener {

    /**
     * Default constructor. 
     */
    public MyRequestListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see ServletRequestListener#requestDestroyed(ServletRequestEvent)
     */
    public void requestDestroyed(ServletRequestEvent arg0) {
       
    }

	/**
     * @see ServletRequestListener#requestInitialized(ServletRequestEvent)
     */
    public void requestInitialized(ServletRequestEvent requestEvent) {
        HttpServletRequest req= (HttpServletRequest) requestEvent.getServletRequest();
    
     // System.out.println("request listener starting...Context path= "+req.getContextPath()+"method = "+req.getMethod()+"uri = "+req.getRequestURI());

      try {
		req.setCharacterEncoding("UTF-8");
	
	} catch (UnsupportedEncodingException e) {
		
		e.printStackTrace();
	}
	
    }
	
}
