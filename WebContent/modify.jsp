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
<title>�Խ���</title>
<script type="text/javascript"
	src="/project4/se2/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type="text/javascript"
	src="/project4/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"" charset="utf-8"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script language="javascript">
	function cancelCheck() {
		var retVal = confirm("���� ����Ͻðڽ��ϱ�?");
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
							<td align="center" width="76">�ۼ���</td>
							<td><input width="500" type="text" value="<%=writer%>"
								name="writer" /></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="76">����</td>
							<td><input width="500" type="text" value="<%=title%>"
								name="title" /></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>
						<tr>
						<td width="0">&nbsp;</td>
							<td align="center" width="76">����</td>
							<td><textarea name="tag"  id="tag"
									style="HEIGHT: 220px; WIDTH: 610px" rows="10" cols="30"
									><%=memo%></textarea></td>
									<td width="0">&nbsp;</td>
									<!--  ����Ʈ�����ʹ� textarea�� �̷������ �ʾҴ�. ���� ������ �����ϰ� ��带 ��ȯ�ϱ� ����
									textarea�� ����һ�, html �ڵ带 �����ϴ� editor ������ iframe���� �����Ǿ�����
									textarea�� html ��峪 text ��忡�� �±װ��� ������ �� ���
									editor ��忡 ������ �ְ� ������ smartEditor2.html ������ pasteHTML() �Լ� -->
						</tr>
									

						<!-- action�� ���� ���۵Ǿ��� �� �Ѿ�� �������� url -->

						<script type="text/javascript">
							var oEditors = [];

							nhn.husky.EZCreator
									.createInIFrame({

										oAppRef : oEditors,
										elPlaceHolder : "tag",
										sSkinURI : "/project4/se2/SmartEditor2Skin.html",
										htParams : {
											// ���� ��� ���� (true:���/ false:������� ����)
											bUseToolbar : true,
											// �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
											bUseVerticalResizer : true,
											// ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
											bUseModeChanger : true,
											
										}
									});
							function pasteHTML(filepath){
							    var sHTML = '<img src="<%=request.getContextPath()%>/uploadFolder/'+filepath+'">';

							    oEditors.getById["tag"].exec("PASTE_HTML", [sHTML]); 
							}


							function writeCheck() {
								var form = document.modifyform;
								var sHTML = oEditors.getById["tag"].getIR();
								 if (!form.writer.value) {
									alert("�̸��� �����ּ���.");
									form.writer.focus();
									return;
								}
								if (!form.title.value) {
									alert("������ �����ּ���.");
									form.title.focus();
									return;
								}
								/* if (!sHTML) {
									alert("������ �����ּ���.");
									form.editor.focus();
									return;
								}  */
								oEditors.getById["tag"].exec(
										"UPDATE_CONTENTS_FIELD", []);
								//editor ����� iframe ������ �Էµ� ������ textarea�� �ݿ��϶�� ��ɾ�
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
								onclick="javascript:writeCheck()" type="button" value="����">
								<input onclick="javascript:history.back(-1)" type="button"
								value="���">
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
