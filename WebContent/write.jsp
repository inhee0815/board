<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>�Խ���</title>
<script type="text/javascript"
	src="/project4/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
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

	<form id="writeform" name="writeform" method="post" action="send.jsp">
		<table>
			<tr>
				<td>
					<table width="800">
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="76">�ۼ���</td>
							<td><input width="500" type="text" value="" name="writer" /></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>
						<tr>
							<td width="0">&nbsp;</td>
							<td align="center" width="76">����</td>
							<td><input width="500" type="text" value="" name="title" /></td>
							<td width="0">&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4" width="407"></td>
						</tr>
						<tr>
							<td align="center" width="76">����</td>
							<td width="700"><textarea name="tag"  id="tag"
									style="HEIGHT: 220px; WIDTH: 610px" rows="10" cols="30"
									></textarea></td>
						</tr>

						<!-- action�� ���� ���۵Ǿ��� �� �Ѿ�� �������� url -->

						<script type="text/javascript">
							var oEditors = [];

							nhn.husky.EZCreator
									.createInIFrame({

										oAppRef : oEditors,
										elPlaceHolder : "tag",
										sSkinURI : "/project4/editor/SmartEditor2Skin.html",
										htParams : {
											// ���� ��� ���� (true:���/ false:������� ����)
											bUseToolbar : true,
											// �Է�â ũ�� ������ ��� ���� (true:���/ false:������� ����)
											bUseVerticalResizer : true,
											// ��� ��(Editor | HTML | TEXT) ��� ���� (true:���/ false:������� ����)
											bUseModeChanger : true,
										}
									});
							
							function writeCheck() {
								var form = document.writeform;
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
								/* if (!form.editor.value) {
									alert(oEditors);
									alert("������ �����ּ���.");
									form.editor.focus();
									return;
								} */
								oEditors.getById["tag"].exec("UPDATE_CONTENTS_FIELD", []);
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
								<input onclick="javascript:cancelCheck()" type="button" value="���">
							<td width="0">&nbsp;</td>
						</tr>


					</table>
				</td>
			</tr>
		</table>
	</form>
	
</script>
</body>
</html>
