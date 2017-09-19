<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.raccoon.connDB.DBconn,java.sql.*" %>
<% Connection conn = DBconn.createDBConn(); %>
<% String username = request.getParameter("username");
   String password = request.getParameter("password");
   String action = request.getParameter("action");
   String errormesg = new String();
   
   if(username!=null && username.length()!=0 && password!=null &&password.length()!=0){
	   if("login".equals(action)){
		   String sql = "select * from tbl_admin_user where admin_username=? and admin_password=?";
		   PreparedStatement state = conn.prepareStatement(sql);
		   state.setString(1, username);
		   state.setString(2, password);
		   ResultSet result = state.executeQuery();
		   if(result.next()){
			   session.setAttribute("adminusername", username);
			   session.setAttribute("adminuserrole", result.getString("admin_userrole"));
			   response.sendRedirect("index.jsp");
		   }else{
			   errormesg = "用户名或密码输出有误!";
		   }
	   } 
   }else{
	   errormesg = "用户名或密码名不能为空!";
   }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="margin-top: 40px" align="center">
		<%if(errormesg.length()!=0 && errormesg!=null){ %>
		   提示信息:<label style="color: red;"><%=errormesg %>
		<%} %></label>
		<form style="margin-top: 15px;" action="login.jsp" method="post">
			<table border="1" width="300">
				<tr>
					<td width="100%" bgcolor="#c0c0c0" align="center">
					<font color="#0000ff">用户登录</font></td>
				</tr>
				<tr>
					<td>请输入用户名:<input type="text" name="username" ><br>
					请输出用户密码:<input type="password" name="password"><br>
					<input type="hidden" name="action" value="login">
					<input type="submit" value="登录" style="margin-left: 210px;">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
<%DBconn.closeConn(conn); %>
</html>