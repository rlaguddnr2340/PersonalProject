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
	
	if($('input[name="profile_chk"]').is(":checked")){
		console.log($("#profile_chk").val());
	}
	if($('input[name="contentfile_chk"]').is(":checked")){
		console.log($("#contentfile_chk").val());
	}
	$('#frm').submit();
}
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>책소개</h2>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="write">
		<form name="frm" id="frm" action="/pp/portfolio/gallery/editproc.do" method="POST" enctype="multipart/form-data">
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
						<input type="text" id="title" name="title" value="${data[0].title}" />
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea id="contents" name="content" rows="25">${data[0].content}</textarea>
					</td>
				</tr>
				<tr>
					<th>프로필 이미지</th>
					<td>
						<p>기존파일 : ${data[0].filename_org }<br>
								<input type="checkbox" id="profile_chk" name="profile_chk" value="1" title="첨부파일을 삭제하시려면 체크해주세요" />
								<label for="profile_chk">기존파일삭제</label>
							</p>
						<input type="file" name="filename">
					</td>
				</tr>
				<tr>
					<th>내용 이미지</th>
					<td>
						<p>기존파일 : ${data[1].filename_org }<br>
								<input type="checkbox" id="contentfile_chk" name="contentfile_chk" value="1" title="첨부파일을 삭제하시려면 체크해주세요" />
								<label for="contentfile_chk">기존파일삭제</label>
							</p>
						<input type="file" name="filename" >
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
