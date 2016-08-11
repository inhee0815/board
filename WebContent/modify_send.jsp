<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	java.util.Date d = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/test";
	String username = "root";
	String password = "1234";
	Class.forName(driver);

	try {
		request.setCharacterEncoding("euc-kr");
		int idx = Integer.parseInt(request.getParameter("idx"));
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String date = request.getParameter("reg_date");
		String memo = request.getParameter("tag");
		String notag=memo.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "").replaceAll("\r|\n|&nbsp;","");
		Connection conn = DriverManager.getConnection(url, username, password);
		PreparedStatement pstmt = conn.prepareStatement("Select * FROM board where NUM=" + idx);
		ResultSet rs = pstmt.executeQuery();

		String sql = "UPDATE board SET WRITER='" + writer + "' ,TITLE='" + title + "' ,REG_DATE='" + sdf.format(d)
				+ "' ,tag='" + memo + "' ,notag='" + notag + "' WHERE NUM=" + idx;
		pstmt.executeUpdate(sql);
%>
<script language=javascript>
				  	self.window.alert("글이 수정되었습니다.");
				  	location.href="view.jsp?idx=<%=idx%>";
</script>
<%
	rs.close();
		pstmt.close();
		conn.close();
	} catch (SQLException e) {
		out.println(e.toString());

	}
%>