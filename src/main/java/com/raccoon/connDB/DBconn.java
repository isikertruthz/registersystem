package com.raccoon.connDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconn {
	static final String DBURL ="jdbc:mysql://localhost:3306/RESGISTERSYSTEM?characterEncoding=utf8&useSSL=false";
	static final String USER ="root";
	static final String PASSWORD ="liang2hui1";
	
	public static Connection createDBConn(){
		try {
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Connection conn = DriverManager.getConnection(DBURL, USER, PASSWORD);
			return conn;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.print("cuowu");
			return null;
		}	
	}
	
	public static void closeConn(Connection conn){
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
