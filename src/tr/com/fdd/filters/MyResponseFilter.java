package tr.com.fdd.filters;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import tr.com.fdd.struts.actions.SQLUtils;

/**
 * Servlet Filter implementation class MyResponseFilter
 */
public class MyResponseFilter implements Filter {

	private static Logger logger = LoggerFactory.getLogger(MyResponseFilter.class);

	FilterConfig filterConfig = null;
	
	
	/**
	 * Default constructor.
	 */
	public MyResponseFilter() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		// pass the request along the filter chain

		// HttpSession sessionInf = ((HttpServletRequest)request).getSession();
		// Object[] sessions= (Object[])
		// sessionInf.getAttribute("sessionMember");
		//
		// if(sessions!=null){
		// logger.info("Request Content Lenght = "+request.getContentLength());
		// logger.info("Request Local Name = "+request.getLocalName());
		// logger.info("Request Local Addr = "+request.getLocalAddr());
		//
		// logger.info("Request Content Type"+request.getContentType());
		// logger.info("ip adress"+request.getRemoteAddr());

		logger.info("REQUEST URI = " + ((HttpServletRequest) request).getRequestURI());
		String requestURI = ((HttpServletRequest) request).getRequestURI();
		if (!"/FDD_MUHTAK/login.do".equals(requestURI)) {
			HttpSession sessionInf = ((HttpServletRequest) request).getSession();
			try {
				if (sessionInf != null) {
					Object[] sessions = (Object[]) sessionInf.getAttribute("sessionMember");

					if (sessions == null) {
						RequestDispatcher dips = request.getRequestDispatcher("/logout.jsp");
						dips.forward(request, response);
					} else {
						go(request, response, chain);
					}
				} else {
					RequestDispatcher dips = request.getRequestDispatcher("/logout.jsp");
					dips.forward(request, response);
				}
			} catch (Exception e) {
				e.printStackTrace();
				RequestDispatcher dips = request.getRequestDispatcher("/logout.jsp");
				dips.forward(request, response);
			}
		} else

			go(request, response, chain);

		// }

		// else
		// {
		// RequestDispatcher dips= request.getRequestDispatcher("/login3.jsp");
		// dips.forward(request, response);
		// }
	}

	private void go(ServletRequest request, ServletResponse response, FilterChain chain)
			throws UnsupportedEncodingException, IOException, ServletException {

		Enumeration<String> ff = filterConfig.getInitParameterNames();

		while (ff.hasMoreElements()) {
			Object object = (Object) ff.nextElement();
			logger.info(object.toString());
		}

		request.setCharacterEncoding("ISO-8859-9");

		chain.doFilter(request, response);

		response.setContentType("ISO-8859-9");
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		if (this.filterConfig == null)
			this.filterConfig = fConfig;
	}

}
