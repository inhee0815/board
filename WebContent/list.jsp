<%@page import="java.io.PrintWriter"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>�Խ���</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>



	<script language="javascript">
		
	</script>

	<%
		try {
			String driver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/test";
			String username = "root";
			String password = "1234";
			Class.forName(driver);

			Connection conn = DriverManager.getConnection(url, username, password);
			PreparedStatement pstmt = conn.prepareStatement("Select * FROM board");
			ResultSet rs = pstmt.executeQuery();
	%>
	<table width="70%" cellpadding="0" cellspacing="0" border="0">

		<tr bgcolor="#41a4d2">
			<td align="center" width="40">��ȣ</td>
			<td align="center" width="379">����</td>
			<td align="center" width="73">�ۼ���</td>
			<td align="center" width="164">�ۼ���</td>
			<td align="center" width="40">��ȸ��</td>

		</tr>
		<%
			while (rs.next()) {
					int idx = rs.getInt(1);
					String title = rs.getString("title");
					String writer = rs.getString("writer");
					String date = rs.getString("reg_date");
					//String link = rs.getString("url");
					int cnt = rs.getInt(5);
					cnt++;
		%>
		<tr height="30" align="center">
			<td><%=idx%></td>
			<td style="cursor: pointer"
				OnClick="location.href='view.jsp?idx=<%=idx%>'"><%=title%></td>
			<!-- get������� ���� -->
			<!-- ���� ��ũ�Ŵ� �±� -->
			<td align="center"><%=writer%></td>
			<td align="center"><%=date%></td>
			<td><%=cnt%></td>
		</tr>
		<%
			}
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				out.println(e.toString());
			}
		%>
		<tr align="center">
			
			<td><input type=button value="�۾���" onclick="location.href = 'write.jsp'">
		
		</tr>
	</table>

</body>
</html>

