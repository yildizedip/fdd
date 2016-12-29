package tr.com.fdd.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public interface IOperationAddController {
	
	/**
	 * 
	 * @return
	 */
	String addOperation(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response);

}
