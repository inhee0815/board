<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*"%>

<%
	//ConnectDB db = new ConnectDB();
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/test";
	String username = "root";
	String password = "1234";
	Class.forName(driver);
	int idx = Integer.parseInt(request.getParameter("idx"));
	try {

		Connection conn = DriverManager.getConnection(url, username, password);
		Statement pstmt = conn.createStatement();
		String sql = "Select * FROM board WHERE NUM=" + idx;
		ResultSet rs = pstmt.executeQuery(sql);
		if (rs.next()) {

			String title = rs.getString("title");
			String writer = rs.getString("writer");
			String date = rs.getString("reg_date");
			String memo=rs.getString("tag");
			int hit = rs.getInt("hit");
			hit++;

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>�Խ���</title>
<script language="javascript">
	function checkDelete() {
		var retVal = confirm("���� �����Ͻðڽ��ϱ�?");
		if (retVal == true) {
			location.href = "delete.jsp?idx=<%=idx%>";
		} else {
			return;
		}
	}
</script>
</head>
<body>
	<table>
		<tr>
			<td>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr
						style="background: url('img/table_mid.gif') repeat-x; text-align: center;">
						<td width="5"><img src="img/table_left.gif" width="5"
							height="30" /></td>
						<td>�� ��</td>
						<td width="5"><img src="img/table_right.gif" width="5"
							height="30" /></td>
					</tr>
				</table>
				<table width="413">
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">�۹�ȣ</td>
						<td width="319"><%=idx%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">����</td>
						<td width="319"><%=title%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">�ۼ���</td>
						<td width="319"><%=writer%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">�ۼ���</td>
						<td width="319"><%=date%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td align="center" width="76">����</td>
						<td width="319"><%=memo%></td>
						<td width="0">&nbsp;</td>
					</tr>
					<tr>
						<td width="0">&nbsp;</td>
						<td width="399" colspan="2" height="200">
					</tr>
					<%
								sql = "UPDATE board SET HIT=" + hit + " where NUM=" +idx;
								pstmt.executeUpdate(sql);
								rs.close();
								pstmt.close();
								conn.close();
							}
						} catch (SQLException e) {
						}
					%>

					<tr height="1" bgcolor="#dddddd">
						<td colspan="4" width="407"></td>
					</tr>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="4" width="407"></td>
					</tr>
					<tr align="center">
						<td width="0">&nbsp;</td>
						<td colspan="2" width="399">
							 <input onclick="location.href = 'modify.jsp?idx=<%=idx%>'" type=button
							value="����"> <input onclick="javascript:checkDelete()" type=button
							value="����"> <input onclick="location.href = 'list.jsp'" type=button
							value="���"> 
						<td width="0">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>