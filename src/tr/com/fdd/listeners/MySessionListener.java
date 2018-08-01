package tr.com.fdd.listeners;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import tr.com.fdd.dto.TKullaniciLoginDTO;
import tr.com.fdd.dto.TLoginDTO;
import tr.com.fdd.mysql.DbConnection;
import tr.com.fdd.struts.actions.SQLUtils;

public class MySessionListener implements HttpSessionListener {

	@Override
	public void sessionCreated(HttpSessionEvent event) {
		// TODO Auto-generated method stub

	}

	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		// TODO Auto-generated method stub
		Object[] sessionArr = (Object[]) event.getSession().getAttribute("sessionMember");
		
		
		if(sessionArr==null) return;
		
		TKullaniciLoginDTO kullaniciLoginDTO = (TKullaniciLoginDTO) sessionArr[0];
		
		SQLUtils sqlUtils = new SQLUtils();
		Connection connection = DbConnection.getMySqlConneciton();
		TLoginDTO loginDTO=null;
		
		try {
			
		loginDTO=	sqlUtils.getLoginInfo(connection, kullaniciLoginDTO.getKuId());
		
		
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		
		if(loginDTO!=null)

		logout(loginDTO.getId(), kullaniciLoginDTO.getUserIp());


	}

	private void logout(int id, String userIp) {
		SQLUtils sqlUtils = new SQLUtils();
		Connection connection = DbConnection.getMySqlConneciton();

		try {
			sqlUtils.addLogoutInfo(connection, id, userIp);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

	}

}
