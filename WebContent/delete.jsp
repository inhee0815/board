<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/test";
	String username = "root";
	String password = "1234";
	Class.forName(driver);
	int idx = Integer.parseInt(request.getParameter("idx"));

	try {
		
		Connection conn = DriverManager.getConnection(url, username, password);
		PreparedStatement pstmt = conn.prepareStatement("Select * FROM board where NUM=" + idx);
		ResultSet rs = pstmt.executeQuery();
		
		String sql = "DELETE FROM board WHERE NUM=" + idx;	
		pstmt.executeUpdate(sql);
		sql = "UPDATE board set NUM=NUM-1 where NUM>" + idx;
		pstmt.executeUpdate(sql);
		
%>
<script language=javascript>
				  	self.window.alert("글이 삭제되었습니다.");
				  	location.href="list.jsp";
	
</script>
<%
	rs.close();
		pstmt.close();
		conn.close();
	} catch (SQLException e) {
		out.println(e.toString());

	}
%>