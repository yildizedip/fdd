package tr.com.fdd.struts.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import tr.com.fdd.controllers.OperationAddForImplant;
import tr.com.fdd.controllers.OperationAddGeneral;
import tr.com.fdd.controllers.OperationAdder;
import tr.com.fdd.struts.form.IslemForm;
import tr.com.fdd.utils.GenelDegiskenler;

public class HastaOperasyonEkleAction extends Action {
	
	
	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		OperationAdder adder= new OperationAdder(mapping, form, request, response);
		
		if(((IslemForm)form).getIslemTipi()==GenelDegiskenler.OperasyonTipleri.IMPLANT)
		{
			 adder.setController(new OperationAddForImplant());
			 return mapping.findForward(adder.addOperation());
		}
		else 
			adder.setController(new OperationAddGeneral());
		 return mapping.findForward(adder.addOperation());
		
		
	}
	
}
