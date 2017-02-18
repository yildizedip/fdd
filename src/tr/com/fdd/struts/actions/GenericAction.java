package tr.com.fdd.struts.actions;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.hibernate.HibernateException;
import net.sf.hibernate.Session;
import net.sf.hibernate.SessionFactory;
import net.sf.hibernate.Transaction;
import net.sf.hibernate.cfg.Configuration;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import tr.com.fdd.mysql.MysqlUtil;

public abstract class GenericAction extends Action {
	
	private static Configuration cfg=null;
	private static SessionFactory sessions=null;
	private static Session session=null;	
	private static Connection mySqlConn=null;
	
	static{
		
		cfg= new Configuration();		
		try {
			cfg.configure("/myhibernate.cfg.xml");
			sessions= cfg.buildSessionFactory();
			
			mySqlConn= MysqlUtil.instance.getConnection();
			session=sessions.openSession(mySqlConn);
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	
	public Session getHibernateSessionStatic(){
		return session;
	}
	

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		Configuration cfg = new Configuration().configure("/myhibernate.cfg.xml");
		SessionFactory sessions = cfg.buildSessionFactory();
		Session session = sessions.openSession(MysqlUtil.instance.getConnection());
		//burda hibernate xmlden de dataconnection alinir.
		
		Connection connection =SQLUtils.getMySqlConneciton();
		
		return executeCode(session,connection, mapping, form, request, response, null);
		
	}

	protected abstract ActionForward executeCode(Session session, Connection connection,
			ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response, Transaction trans) throws Exception ;
	
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
