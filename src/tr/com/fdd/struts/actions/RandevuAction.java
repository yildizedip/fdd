package tr.com.fdd.struts.actions;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.tomcat.util.http.fileupload.FileUploadException;



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
		   
		  return mapping.findForward("success");
		}catch (Exception e) {
			 return mapping.findForward("failure");
		}
		
		
	}

}
