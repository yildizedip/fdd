package tr.com.fdd.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class OperationAdder {
	private IOperationAddController controller;
	private ActionMapping mapping;
	private ActionForm actionForm;
	private HttpServletRequest request; 
	private HttpServletResponse response;
	
	public OperationAdder(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		this.mapping=mapping;
		this.actionForm=form;
		this.request=request;
		this.response=response;
	}
	
	public String addOperation(){
		
		return controller.addOperation(mapping,  actionForm,
				request, response);
		
	}

	public IOperationAddController getController() {
		return controller;
	}

	public void setController(IOperationAddController controller) {
		this.controller = controller;
	}
	

}
