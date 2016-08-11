<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.text.*"%>
<%@ page import="java.util.regex.*"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style>
A:link {
	text-decoration: none;
}

A:visited {
	text-decoration: none;
}

A:active {
	text-decoration: none;
}

A:hover {
	text-decoration: underline;
	color: #20b2aa;
}
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("euc-kr");

		java.util.Date d = new java.util.Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/test";
		String username = "root";
		String password = "1234";
		Class.forName(driver);
		String key = request.getParameter("key"); //�˻�����
		System.out.println(key);
		String search = request.getParameter("search");//�˻�����
		System.out.println(search);
		String searchbox = request.getParameter("searchbox");//�˻�����
		System.out.println(searchbox);
		String sql = null;

		try {
			Connection conn = DriverManager.getConnection(url, username, password);
			if (key != null) { //�˻��̸�
				if (search.equals("title")) {
					sql = "Select * from board where title like '%" + searchbox + "%'";
				} else if (search.equals("content")) {
					sql = "Select * from board where notag like '%" + searchbox + "%'";

				} else if (search.equals("titlecontent")) {
					sql = "Select * from board where title like '%" + searchbox + "%' OR notag like '%" + searchbox
							+ "%'";
				} else {
					System.out.println("select error!");
				}
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery(sql);
	%>
	<table width="70%" cellpadding="0" cellspacing="0" border="0">

		<tr bgcolor="#41a4d2">

			<td align="center" width="379">����</td>
			<td align="center" width="73">�ۼ���</td>
			<td align="center" width="164">�ۼ���</td>

		</tr>
		<%
			if (rs.next()) {
				do {
					int idx = rs.getInt("num");
					String title = rs.getString("title");
					System.out.println(title);
					String writer = rs.getString("writer");
					String date = rs.getString("reg_date");
				
		%>
		<tr height="30" align="center">
			<td align="left"><a href="view.jsp?idx=<%=idx%>"><%=title%></td>
			<!-- ���� ��ũ�Ŵ� �±� -->
			<td align="center"><%=writer%></td>
			<td align="center"><%=date%></td>
		</tr>

		<%
				} while(rs.next()); 
			} else {
				%>
				<tr height="30" align="center"><td align="center">��ϵ� �Խù��� �����ϴ�.</td>
				</tr>
				<%
			}
					pstmt.close();
					conn.close();
				}

			} catch (SQLException e) {
				out.println(e.toString());
			}
		%>
	</table>
	<table width="70%" cellpadding="0" cellspacing="0" border="0">
		<form name="searchform" method="post" action="searchlist.jsp">
			<input type="hidden" name="key" value="true"> 
			<select name="search">
				<option value="title">����</option>
				<option value="content">����</option>
				<option value="titlecontent" selected="selected">����+����</option>
			</select> 
			<input width="300" type="text" name="searchbox"> 
			<input type="submit" value="�˻�">
		</form>

	</table>
	<div align="right">
		<tr>

			<td><input type=button value="���"
				onclick="location.href = 'list.jsp'">
		</tr>
	</div>
</body>
</html>