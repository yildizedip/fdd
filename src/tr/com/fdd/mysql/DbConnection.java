package tr.com.fdd.mysql;

import java.sql.Connection;
import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class DbConnection {
	
	private static Logger logger = LoggerFactory.getLogger(DbConnection.class);
	
	public static Connection getMySqlConneciton() {

		logger.info("Getting Mysql connection..");

		Connection conn = null;
		try {

			conn = MysqlUtil.instance.getConnection();
		} catch (ClassNotFoundException e) {

			e.printStackTrace();
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return conn;
	}


}
