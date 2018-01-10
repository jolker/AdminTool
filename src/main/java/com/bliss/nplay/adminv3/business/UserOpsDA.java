package com.bliss.nplay.adminv3.business;

import ga.log4j.GA;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.codec.binary.Base64;

import com.bliss.framework.util.DateTimeUtils;
import com.bliss.nplay.adminv3.model.UserOps;
import com.bliss.nplay.adminv3.model.UserOps.Role;
import com.bliss.nplay.adminv3.model.UserOps.Status;
import com.bliss.framework.dbconn.ClientManager;
import com.bliss.framework.dbconn.ManagerIF;
public class UserOpsDA {

	private static final String DATABASE = "nplay_admin_database";
	private static final String USER_OPS_TABLE = "user_operators";

	private static final String SQL_GET_USER_PASS = "SELECT * FROM %s "
			+ "WHERE user_name=? AND pass_word=?";

	private static final String SQL_GET_USER_NAME = "SELECT * FROM %s "
			+ "WHERE user_name=?";

	private static final String SQL_INSERT_USER = "INSERT INTO " + USER_OPS_TABLE + " (" 
			+ "user_name," // 1
			+ "pass_word," // 2
			+ "status_," // 3
			+ "role," // 4
			+ "expired_at," // 5
			+ "created_at" // 6
			+ ") values (?,?,?,?,?,?)";

	private static final String SQL_UPDATE_USER = "UPDATE %s SET " + USER_OPS_TABLE + " (" 
			+ "user_name," // 1
			+ "pass_word," // 2
			+ "status_," // 3
			+ "role," // 4
			+ "expired_at," // 5
			+ "updated_at" // 6
			+ " WHERE id=?"; // 17

	private static final String SQL_LIST_USER_PAGING = "SELECT SQL_CALC_FOUND_ROWS * FROM %s LIMIT ?,?";

	public static int add(UserOps userOps) {
		ManagerIF cm = ClientManager.getInstance(DATABASE);
		Connection cnn = cm.borrowClient();
		try (PreparedStatement statement = cnn.prepareStatement(SQL_INSERT_USER, Statement.RETURN_GENERATED_KEYS)) {
			// statement.
			statement.setString(1, userOps.getUserName());
			String passEncoded = Base64.encodeBase64String(userOps.getPassWord().getBytes());	
			statement.setString(2, passEncoded);
			statement.setInt(3, userOps.getStatus().ordinal());
			statement.setInt(4, userOps.getRole().ordinal());
			statement.setTimestamp(5, DateTimeUtils.getTimestampSql(DateTimeUtils.getNow()));
			statement.setTimestamp(6, DateTimeUtils.getTimestampSql(DateTimeUtils.getNow()));
			int row = statement.executeUpdate();
			if (row > 0) {
				ResultSet rs = statement.getGeneratedKeys();
				rs.next();
				return rs.getInt(1);
			}
		} catch (SQLException ex) {
			GA.app.error("add user failed. " + ex.getMessage(), ex);
		} finally {
			cm.returnClient(cnn);
		}
		return -1;
	}

	public static boolean update(UserOps userOps) {
		boolean result = false;
		ManagerIF cm = ClientManager.getInstance(DATABASE);
		Connection cnn = cm.borrowClient();
		String query = String.format(SQL_UPDATE_USER, USER_OPS_TABLE);
		try (PreparedStatement statement = cnn.prepareStatement(query)) {
			// statement.
			statement.setString(1, userOps.getUserName());
			String passEncoded = Base64.encodeBase64String(userOps.getPassWord().getBytes());	
			statement.setString(2, passEncoded);
			statement.setInt(3, userOps.getStatus().ordinal());
			statement.setInt(4, userOps.getRole().ordinal());
			statement.setTimestamp(5, DateTimeUtils.getTimestampSql(DateTimeUtils.getNow()));
			statement.setTimestamp(6, DateTimeUtils.getTimestampSql(DateTimeUtils.getNow()));
			// update by Id
			statement.setInt(7, userOps.getId());
			int row = statement.executeUpdate();
			if (row > 0) 
				result = true;
		} catch (Exception e) {
			result = false;
			GA.app.error("update user failed. " + e.getMessage(), e);
		} finally {
			cm.returnClient(cnn);
		}
		return result;
	}

	public static UserOps find(String userName) {
		UserOps userOps = new UserOps();
		ManagerIF cm = ClientManager.getInstance(DATABASE);
		Connection cnn = cm.borrowClient();
		try {
			String query = String.format(SQL_GET_USER_NAME, USER_OPS_TABLE);
			PreparedStatement statement = cnn.prepareStatement(query);
			statement.setString(1, userName);
			ResultSet rs = statement.executeQuery();
			if (rs != null && rs.next()) {
				userOps = populateDateFromDB(rs);            
			}
		} catch (SQLException ex) {
			GA.app.error("find user failed. userName: " + userName  +" - " + ex.getMessage(), ex);
		} finally {
			if (cm != null) {
				cm.returnClient(cnn);
			}
		}
		return userOps;
	}

	public static UserOps find(String userName, String password) {
		UserOps userOps = new UserOps();
		ManagerIF cm = ClientManager.getInstance(DATABASE);
		Connection cnn = cm.borrowClient();
		try {
			String query = String.format(SQL_GET_USER_PASS, USER_OPS_TABLE);
			PreparedStatement statement = cnn.prepareStatement(query);

			statement.setString(1, userName);
			String passEncoded = Base64.encodeBase64String(password.getBytes());
			statement.setString(2, passEncoded);

			ResultSet rs = statement.executeQuery();

			if (rs != null && rs.next()) {
				userOps = populateDateFromDB(rs);            
			}

		} catch (SQLException ex) {
			GA.app.error("find user failed. userName: " + userName  +" - " + ex.getMessage(), ex);
		} finally {
			if (cm != null) {
				cm.returnClient(cnn);
			}
		}
		return userOps;
	}

	public static List<UserOps> find(short page, short offset) {
		List<UserOps> userOpsList = new ArrayList<UserOps>();
		int beginRecord = (page - 1) * offset; // 20 each page
		ManagerIF cm = ClientManager.getInstance(DATABASE);
		Connection cnn = cm.borrowClient();
		try {
			String query = String.format(SQL_LIST_USER_PAGING, USER_OPS_TABLE);
			PreparedStatement statement = cnn.prepareStatement(query);
			statement.setInt(1, beginRecord);
			statement.setInt(2, beginRecord + offset);
			ResultSet rs = statement.executeQuery();
			while (rs != null && rs.next()) {
				UserOps userOps = populateDateFromDB(rs);
				userOpsList.add(userOps);
			}
		}  catch (SQLException ex) {
			GA.app.error("find user paging failed.  " + ex.getMessage(), ex);
		} finally {
			if (cm != null) {
				cm.returnClient(cnn);
			}
		}
		return userOpsList;
	}

	private static UserOps populateDateFromDB(ResultSet rs) throws SQLException {
		UserOps userOps = new UserOps();
		userOps.setId(rs.getInt("id"));
		userOps.setUserName(rs.getString("user_name"));
		userOps.setPassWord(rs.getString("pass_word"));
		userOps.setStatus(Status.values()[rs.getInt("status_")]);
		userOps.setRole(Role.values()[rs.getInt("role")]);
		if (rs.getString("expired_at") != null)
			userOps.setExpiredAt(DateTimeUtils.getDateTime(rs.getString("expired_at")));
		userOps.setCreatedAt(DateTimeUtils.getDateTime(rs.getString("created_at")));
		if (rs.getString("updated_at") != null)
			userOps.setUpdatedAt(DateTimeUtils.getDateTime(rs.getString("updated_at")));
		return userOps;
	}


}
