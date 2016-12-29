package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.SessionFactory;
import net.sf.hibernate.cfg.Configuration;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.mysql.MysqlUtil;

public abstract class GenericAction extends Action {
	
	

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Configuration cfg = new Configuration().configure("/myhibernate.cfg.xml");
		SessionFactory sessions = cfg.buildSessionFactory();
		Session session = sessions.openSession(MysqlUtil.instance.getConnection());
		//burda hibernate xmlden de dataconnection alinir.
		return executeCode(session, mapping, form, request, response);
		
	}

	protected abstract ActionForward executeCode(Session session, 
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) ;
	
	public static Session getHibernateSession() throws HibernateException,
				ClassNotFoundException, SQLException {
			Configuration cfg=null;
			SessionFactory sessions=null;
			Session session=null;		
			cfg= new Configuration();		
			cfg.configure("/myhibernate.cfg.xml");
			sessions= cfg.buildSessionFactory();
			// java util connection alinir.
			Connection mySqlConn= MysqlUtil.instance.getConnection();
			session=sessions.openSession(mySqlConn);
			return session;
	} 

}
