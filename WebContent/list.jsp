<%@page import="java.io.PrintWriter"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>게시판</title>
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
<div align="right">
	<tr>

		<td><input type=button value="글쓰기"
			onclick="location.href = 'write.jsp'">
	</tr>
</div>
<body>

	<script language="javascript">
		
	</script>

	<%
		try {
			String driver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/test";
			String username = "root";
			String password = "1234";
			String search_value = "";
			Class.forName(driver);

			Connection conn = DriverManager.getConnection(url, username, password);
			PreparedStatement pstmt = conn.prepareStatement("Select * FROM board");
			ResultSet rs = pstmt.executeQuery();
	%>
	<table width="70%" cellpadding="0" cellspacing="0" border="0">

		<tr bgcolor="#41a4d2">
			<td align="center" width="40">번호</td>
			<td align="center" width="379">제목</td>
			<td align="center" width="73">작성자</td>
			<td align="center" width="164">작성일</td>
			<td align="center" width="40">조회수</td>

		</tr>

		<%
			while (rs.next()) {
					int idx = rs.getInt(1);
					String title = rs.getString("title");
					String writer = rs.getString("writer");
					String date = rs.getString("reg_date");
					//String link = rs.getString("url");
					int hit = rs.getInt(5);
		%>
		<tr height="30" align="center">
			<td><%=idx%></td>
			<td align="left"><a href="view.jsp?idx=<%=idx%>"><%=title%></td>
			<!-- 제목에 링크거는 태그 -->
			<td align="center"><%=writer%></td>
			<td align="center"><%=date%></td>
			<td><%=hit%></td>
		</tr>

		<%
			}

				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				out.println(e.toString());
			}
		%>

	</table>
	<table width="70%" cellpadding="0" cellspacing="0" border="0">
		<form name="searchform" method="post" action="searchlist.jsp">
			<input type="hidden" name="key" value="true"> <select
				name="search">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="titlecontent" selected="selected">제목+내용</option>
			</select> <input width="500" type="text" name="searchbox"> <input
				type="submit" value="검색">
		</form>
	</table>
	<div align="right">
		<tr>

			<td><input type=button value="목록"
				onclick="location.href = 'list.jsp'">
		</tr>
	</div>
</body>

</html>

