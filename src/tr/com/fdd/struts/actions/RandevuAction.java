package tr.com.fdd.struts.actions;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;



public class RandevuAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		try{
			response.setContentType("text/html");
		    response.setHeader("Cache-control","no-cache");

		    String err = "";

		    String contentType = request.getContentType();
		    String boundary = "";
		    final int BOUNDARY_WORD_SIZE = "boundary=".length();
		    
		   
		    
		    request.setAttribute("events", "deneme");
		   
		  return mapping.findForward("success");
		}catch (Exception e) {
			e.printStackTrace();
			 return mapping.findForward("failure");
		}
		
		
	}

}
