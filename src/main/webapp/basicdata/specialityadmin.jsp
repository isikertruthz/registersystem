<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.raccoon.connDB.DBconn,java.sql.*" %>
<%@ page import="com.raccoon.bean.Speciality,java.util.List" %>

<% Connection conn = DBconn.createDBConn();
	String specialityID = request.getParameter("specialityID");
	String specialityName = request.getParameter("specialityName");
	String action = request.getParameter("action");
	String errormsg = null;
	String success = null;
	List <Speciality> list = new ArrayList<Speciality>();
	int specialityIDInt = 0;
	
	if(specialityName!=null && specialityName.length()!=0){
		specialityName = new String(specialityName.getBytes("ISO-8859-1"));
	}
	if(specialityID!=null && specialityID.length()!=0){
		specialityID = new String(specialityID.getBytes("ISO-8859-1"));
	}
	
	if("add".equals(action)){
		String sql = "select speciality_name from tbl_speciality where speciality_id =?";
		PreparedStatement state = conn.prepareStatement(sql);
		try{
			state.setInt(1, specialityIDInt);
			ResultSet rs = state.executeQuery();
			if(!rs.next()){
				sql = "insert into tbl_speciality values(?,?)";
				PreparedStatement state2 = conn.prepareStatement(sql);
				state2.setString(1, specialityID);
				state2.setString(2, specialityName);
				state2.executeUpdate();
				success = "录入成功!";
			}else{
				errormsg = "ID已存在!";
			}
		}catch(NumberFormatException nfe){
			errormsg = "请输入有效ID!";
		}catch(SQLException mysqle){
			errormsg = "ID已存在!";
		}
	}
	
	if("del".equals(action)){
		String delsql = "delete from tbl_speciality where speciality_id = ?";
		PreparedStatement state = conn.prepareStatement(delsql);
		state.setString(1, specialityID);
		state.executeUpdate();
	}
	
	String sql2 = "select * from tbl_speciality";
	PreparedStatement state3 = conn.prepareStatement(sql2);
	ResultSet rs2 = state3.executeQuery();
	
	while(rs2.next()){
		Speciality speciality = new Speciality();
		speciality.setSpecialityID(rs2.getString("speciality_id"));
		speciality.setSpecialityName(rs2.getString("speciality_name"));
		list.add(speciality);
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="100%" border="1" style="border-color: #c0c0c0">
		<tr>
			<td bgcolor="c0c0c0">录入专业数据</td>
		</tr>
		<tr>
			<td>
				<form action="specialityadmin.jsp" method="get">
					请输入专业&nbsp;I&nbsp;D :&nbsp;<input type="text" name="specialityID">
					<%if(errormsg!=null){ %>
						<label style="color: red;"><%=errormsg%></label>	
					<%} %>
					<%if(success!=null){ %>
						<label style="color: green;"><%=success%></label>	
					<%} %>
					<br> 
					请输入专业名称:&nbsp;<input type="text" name="specialityName">
				<input type="hidden" name="action" value="add">
				<input type="submit" value="提交">
				</form>
			</td>
		</tr>
	</table>
	<div align="left" style="margin-top: 12px;">已录入的专业数据:</div>
	<table border="1" width="100%" style="margin-top: 5px;border-color: #c0c0c0">
		<tr bgcolor="#c0c0c0">
		<td>专业ID</td>
		<td>专业名称</td>
		<td>操作</td>
		</tr>
		<% for (Speciality spe: list){ %>
			<tr>
			<td><%=spe.getSpecialityID() %></td>
			<td><%=spe.getSpecialityName() %></td>
			<td><a href="specialityadmin.jsp?action=del&specialityID=<%=spe.getSpecialityID() %>">删除</a></td>
			</tr>
		<%} %>
	</table>
</body>
<%DBconn.closeConn(conn); %>
</html>