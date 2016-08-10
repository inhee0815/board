<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*,java.text.*"%>
<%
	request.setCharacterEncoding("euc-kr");
	
	java.util.Date d = new java.util.Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/test";
	String username = "root";
	String password = "1234";
	Class.forName(driver);
	String writer = request.getParameter("writer");
	String title = request.getParameter("title");
	String editor = request.getParameter("editor");
	

	try {
		Connection conn = DriverManager.getConnection(url, username, password);

		String sql = "INSERT INTO board (title,writer,reg_date,editor) VALUES (?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, title);
		pstmt.setString(2, writer);
		pstmt.setString(3, sdf.format(d));
		pstmt.setString(4, editor);

		pstmt.execute();
		pstmt.close();

		conn.close();
	} catch (SQLException e) {
		out.println(e.toString());
	}
%>
<script language=javascript>
	self.window.alert("입력한 글을 저장하였습니다.");
	location.href = "list.jsp";
</script>