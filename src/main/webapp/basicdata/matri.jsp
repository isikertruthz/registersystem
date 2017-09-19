<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,com.raccoon.connDB.DBconn" %>
<%@ page import="java.util.List,com.raccoon.bean.Speciality" %>
<%@	page import="java.util.ArrayList"%>

<%	Connection conn = DBconn.createDBConn();
	PreparedStatement state = null;
	ResultSet rs = null;
	ResultSet rsSelSpe = null;
	
	int curpage = 1;
	int countRecord = 0;
	int countPageRecord = 0;
	int countPage = 0;
	
	/*
	 *	记录总数/页数初始化值
	 */
	String sqlSelCou = null;
	sqlSelCou = "select count(*) as recordcount from tbl_speciality";
	state = conn.prepareStatement(sqlSelCou);
	rs = state.executeQuery();
	
	if(request.getParameter("currpage")!=null){
		curpage = Integer.parseInt(request.getParameter("currpage"));
	}

	if(rs.next()){
		countRecord = rs.getInt("recordcount");
	}
	
	countPageRecord = 10;
	if( countRecord % countPageRecord == 0 ){
		countPage = countRecord / countPageRecord;
	}else{
		countPage = countRecord / countPageRecord + 1;
	}
	
	/*
	 *	页面数值限制!
	 */
	if(curpage<1){
		curpage = 1;
	}
	
	if(curpage>countPage){
		curpage = countPage;
	}
	
	/*
	 *	获取数据
	 */
	String sqlSelSpeLtm= "select * from tbl_speciality limit "+ (curpage-1)*countPageRecord+","+ countPageRecord;
	List<Speciality> list = new ArrayList<Speciality>();
	rs = state.executeQuery(sqlSelSpeLtm);
	while(rs.next()){
		Speciality spe = new Speciality();
		spe.setSpecialityID(rs.getString("speciality_id"));
		spe.setSpecialityName(rs.getString("speciality_name"));
		list.add(spe);
	}
	
	/*
	 *	获取已录入的专业
	 */
	String sqlSelSpeTp = "select DISTINCT speciality_name from tbl_speciality ";
	ResultSet rsSpetp = state.executeQuery(sqlSelSpeTp);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table width="100%" border="1" bordercolor="#c0c0c0">
		<tr bgcolor="c0c0c0"><td>录入录取学生名册</td></tr>
		<tr>
			<td>
				<form action="matri.jsp" method="get">
					&nbsp;&nbsp;&nbsp;请输入学生姓名:&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" name=studentName >&nbsp;&nbsp;&nbsp; 
					请选录取专业:
						<select name="specialityName">
							<option>---请选择--</option>
							<%while(rsSpetp.next()){ %>
								<option value="<%=rsSpetp.getString("speciality_name")%>"><%=rsSpetp.getString("speciality_name")%></option>
							<%} %>
						</select><br>
					请输入录取通知书号:&nbsp;
						<input type="text" name ="noticeNum">
				</form>
			</td>
		</tr>
	</table>

	<table border="1" style="border-color: #c0c0c0; margin-top: 15px;" width="100%" >
		<tr>
			<td colspan="2" align="center">用户数据</td>
		</tr>
		<tr bgcolor="#c0c0c0" >
			<td align="center">专业ID</td>
			<td align="center">专业名称</td>
		</tr>
		<%for(Speciality spe :list){ %>
			<tr>
				<td><%=spe.getSpecialityID() %></td>
				<td><%=spe.getSpecialityName() %></td>
			</tr>
		<%} %>
		<tr>
			<td colspan="2" align="center"> 共<%=countRecord %>条记录,共<%=countPage %>页，当前第<%=curpage %>页，每页<%=countPageRecord %>条记录，
					<a href="matri.jsp?currpage=1">首页,</a>
					<a href ="matri.jsp?currpage=<%=curpage-1 %>">上一页,</a>
					<a href="matri.jsp?currpage=<%=curpage+1 %>">下一页,</a>
					<a href="matri.jsp?currpage=<%=countPage %>">末页</a>
	</table>


</body>
</html>