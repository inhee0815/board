<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/test";
	String username = "root";
	String password = "1234";
	Class.forName(driver);

	String title = "";
	String writer = "";
	String memo = "";
	int idx = Integer.parseInt(request.getParameter("idx"));

	try {

		Connection conn = DriverManager.getConnection(url, username, password);
		Statement stmt = conn.createStatement();

		String sql = "SELECT * FROM board WHERE NUM=" + idx;
		ResultSet rs = stmt.executeQuery(sql);

		if (rs.next()) {

			writer = rs.getString("writer");
			System.out.println(writer);
			title = rs.getString("title");
			System.out.println(title);
			memo = rs.getString("tag");
			System.out.println(memo);
		}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게시판</title>
<script type="text/javascript"
	src="/project4/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script language="javascript">
	function cancelCheck() {
		var retVal = confirm("정말 취소하시겠습니까?");
		if (retVal == true) {
			location.href = "list.jsp";
		} else {
			return;
		}
	}
</script>
</head>
<body>

	<form id="modifyform" name="modifyform" method="post" action="modify_send.jsp?idx=<%=idx%>">
		<table>
			<tr>
				<td>
					<table width="800">
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="76">작성자</td>
							<td><input width="500" type="text" value="<%=writer%>"
								name="writer" /></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="76">제목</td>
							<td><input width="500" type="text" value="<%=title%>"
								name="title" /></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>
						<tr>
						<td width="0">&nbsp;</td>
							<td align="center" width="76">내용</td>
							<td><textarea name="tag"  id="tag"
									style="HEIGHT: 220px; WIDTH: 610px" rows="10" cols="30"
									><%=memo%></textarea></td>
									<td width="0">&nbsp;</td>
									<!--  스마트에디터는 textarea로 이루어지지 않았다. 단지 서버로 전송하고 모드를 변환하기 위해
									textarea를 사용할뿐, html 코드를 생성하는 editor 영역은 iframe으로 구성되었으며
									textarea는 html 모드나 text 모드에서 태그값을 보여줄 때 사용
									editor 모드에 내용을 넣고 싶으면 smartEditor2.html 파일의 pasteHTML() 함수 -->
						</tr>
									

						<!-- action은 폼이 전송되었을 때 넘어가는 페이지의 url -->

						<script type="text/javascript">
							var oEditors = [];

							nhn.husky.EZCreator
									.createInIFrame({

										oAppRef : oEditors,
										elPlaceHolder : "tag",
										sSkinURI : "/project4/editor/SmartEditor2Skin.html",
										htParams : {
											// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
											bUseToolbar : true,
											// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
											bUseVerticalResizer : true,
											// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
											bUseModeChanger : true,
											
										}
									});
							

							function writeCheck() {
								var form = document.modifyform;
								var sHTML = oEditors.getById["tag"].getIR();
								 if (!form.writer.value) {
									alert("이름을 적어주세요.");
									form.writer.focus();
									return;
								}
								if (!form.title.value) {
									alert("제목을 적어주세요.");
									form.title.focus();
									return;
								}
								/* if (!sHTML) {
									alert("내용을 적어주세요.");
									form.editor.focus();
									return;
								}  */
								oEditors.getById["tag"].exec(
										"UPDATE_CONTENTS_FIELD", []);
								//editor 모드의 iframe 영역에 입력된 내용을 textarea에 반영하라는 명령어
								form.submit();
							}
						</script>

						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>
						<tr height="1" bgcolor="#82B5DF">
							<td colspan="4" width="407"></td>
						</tr>

						<tr align="center">
							<td width="0">&nbsp;</td>
							<td colspan="2" width="399"><input
								onclick="javascript:writeCheck()" type="button" value="저장">
								<input onclick="javascript:history.back(-1)" type="button"
								value="취소">
							<td width="0">&nbsp;</td>
						</tr>
						<%
							rs.close();
								stmt.close();
								conn.close();

							} catch (SQLException e) {
								out.println(e.toString());
							}
						%>
					</table>
				</td>
			</tr>
		</table>
	</form>

	</script>
</body>
</html>
