<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<script>
var oEditors; // 에디터 객체 담을 곳
$(document).ready(function(e){
	oEditors = setEditor("<%=request.getContextPath()%>", "contents"); // 에디터 셋팅
});

function goSave() {
	if ($("#title").val() == "") {
		alert('제목을 입력해 주세요.');
		$("#title").focus();
		return false;
	}
	var sHTML = oEditors.getById["contents"].getIR();
	if (sHTML == "") {
		alert('내용을 입력해 주세요.');
		$("#contents").focus();
		return false;
	} else {
		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
	}
	if($("#profileImage").val()=='' || $("#contentImage").val() =='' ){
		alert('첨부파일은 필수입니다.');
		return false;
	}

	$('#frm').submit();
}
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>공지사항</h2>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="write">
		<form name="frm" id="frm" action="/pp/portfolio/gallery/writeproc.do" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="cmd" value="write">
		<input type="hidden" name="writer" value="${loginInfo.id }">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" id="title" name="title" value="" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="contents" name="content" rows="25"></textarea>
					</td>
				</tr>
				<tr>
					<th>프로필 이미지</th>
					<td>
						<input id ="profileImage" type="file" name="filename"  required>
					</td>
				</tr>
				<tr>
					<th>내용 이미지</th>
					<td>
						<input id ="contentImage" type="file" name="filename"  required>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="btnSet">
			<div class="right">
				<a href="/pp/portfolio/gallery/index.do" class="btn">취소</a>
				<a href="javascript:;" class="btn" onclick="goSave();">저장</a>
			</div>
		</div>
		<div style="height:300px;"></div>
	</div>
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
