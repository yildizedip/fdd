package tr.com.fdd.mysql;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import javax.swing.ImageIcon;

import tr.com.fdd.utils.GenelDegiskenler;

public class MysqlUtil {

	public final static MysqlUtil instance = new MysqlUtil();
	private Connection conn = null;
	private Statement batchSt = null;

	private MysqlUtil() {
	}

	private Connection createConnection() throws ClassNotFoundException,
			SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");			

//			 String connectionString = GenelDegiskenler.CONNECTIONSTRING_GERCEK;
//			 String userName = GenelDegiskenler.USERNAME_GERCEK;
//			 String password = GenelDegiskenler.PASSWORD_GERCEK;
			
	//		String connectionString = GenelDegiskenler.CONNECTIONSTRING_TEST;
	//		String userName = GenelDegiskenler.USERNAME_TEST;
	//		String password = GenelDegiskenler.PASSWORD_TEST;
			
//			String connectionString = GenelDegiskenler.CONNECTIONSTRING_GERCEK_TEST;
//			String userName = GenelDegiskenler.USERNAME_GERCEK_TEST;
//			String password = GenelDegiskenler.PASSWORD_GERCEK_TEST;
			
			Properties prop = new Properties();
			InputStream input = null;
			input = this.getClass().getResourceAsStream("db.properties");

			// load a properties file
			prop.load(input);
			
			String ip= prop.getProperty("ip");
			String db= prop.getProperty("db");
			String port= prop.getProperty("port");
			String user = prop.getProperty("user");
			String password= prop.getProperty("password");
			
			//"jdbc:mysql://127.0.0.1:3306/dfdiscom_db?autoReconnect=true&useUnicode=true&characterEncoding=latin5";
			
			String connectionString = "jdbc:mysql://"+ip+":"+port+"/"+db+"?autoReconnect=true&useUnicode=true&characterEncoding=latin5";
			conn = DriverManager.getConnection(connectionString, user,	password);
			conn.setAutoCommit(false);
			
			setNamesLatin5(conn);
			
			return conn;
			
		} catch (ClassNotFoundException e) {
			throw e;
		} catch (SQLException e) {
			throw e;
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}

	public Connection getConnection() throws ClassNotFoundException,
			SQLException {
		return createConnection();
	}

	public void closeConnection(Connection conn) throws SQLException {
		try {
			if (conn != null && !conn.isClosed())
				conn.close();
		} catch (SQLException e) {
			throw e;
		}
	}

	public void commit(Connection conn) throws SQLException {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.commit();
				conn.setAutoCommit(true);
			}
		} catch (SQLException e) {
			throw e;
		}
	}

	public void rollback(Connection conn) throws SQLException {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.rollback();
			}
		} catch (SQLException e) {
			throw e;
		}
	}

	public void insertData(Connection conn, String sql) throws SQLException {
		Statement st = null;
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				if (st != null)
					st.close();
			} catch (SQLException e) {
				throw e;
			}
		}

	}

	public void updateData(String sql) throws SQLException {
		Statement st = null;
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				if (st != null)
					st.close();
			} catch (SQLException e) {
				throw e;
			}
		}

	}

	public void batchUpdateData(Connection conn, String sql)
			throws SQLException {
		if (batchSt == null)
			batchSt = conn.createStatement();
		try {
			batchSt.addBatch(sql);
		} catch (SQLException e) {
			throw e;
		}
	}

	public void executeBatch() throws SQLException {
		if (batchSt != null) {
			try {
				batchSt.executeBatch();
			} catch (SQLException e) {
				throw e;
			} finally {
				try {
					if (batchSt != null)
						batchSt.close();
				} catch (SQLException e) {
					throw e;
				}
			}
		}
	}

	public Object[][] getData(Connection conn, String sql, String sqlCount,
			int colNum) throws SQLException {
		Statement st = null;
		ResultSet rs = null;
		Object[][] arr = null;
		int count = getCount(conn, sqlCount);
		arr = new Object[count][colNum];
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			int index = 0;
			while (rs.next()) {
				for (int i = 1; i <= colNum; i++) {
					arr[index][i - 1] = rs.getString(i);
				}
				index++;
			}
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (st != null)
					st.close();
			} catch (SQLException e) {
				throw e;
			}
		}
		return arr;

	}

	public Object[][] getDataWithImage(Connection conn, String sql,
			String sqlCount, int colNum, ImageIcon icon) throws SQLException {
		Statement st = null;
		ResultSet rs = null;
		Object[][] arr = null;
		int count = getCount(conn, sqlCount);
		arr = new Object[count][colNum];
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			int index = 0;
			while (rs.next()) {
				for (int i = 1; i <= colNum; i++) {
					String tmp = rs.getString(i);
					if ("sil".equals(tmp)) {
						arr[index][i - 1] = icon;
					} else {
						arr[index][i - 1] = tmp;
					}
				}
				index++;
			}
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (st != null)
					st.close();
			} catch (SQLException e) {
				throw e;
			}
		}
		return arr;

	}

	public int getCount(Connection conn, String sql) throws SQLException {
		Statement st = null;
		ResultSet rs = null;

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				return rs.getInt(1);
			} else
				return 0;
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (st != null)
					st.close();
			} catch (SQLException e) {
				throw e;
			}
		}
	}

	public int getIndentity(Connection conn, String sql) throws SQLException {
		Statement st = null;
		ResultSet rs = null;

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				return rs.getInt(1);
			} else
				return 0;
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (st != null)
					st.close();
			} catch (SQLException e) {
				throw e;
			}
		}
	}

	public void deleteData(Connection conn, String sql) throws SQLException {
		Statement st = null;
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				if (st != null)
					st.close();
			} catch (SQLException e) {
				throw e;
			}
		}
	}

	public void setNamesLatin5(Connection conn) throws SQLException {
		String sql = "set names 'latin5'";
		Statement st = null;
		try {
			st = conn.createStatement();
			st.executeUpdate(sql);
		} catch (SQLException e) {
			throw e;
		} finally {
			try {
				if (st != null)
					st.close();
			} catch (SQLException e) {
				throw e;
			}
		}
	}

}
