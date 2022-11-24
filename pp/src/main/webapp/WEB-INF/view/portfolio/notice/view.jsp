<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

function goEdit(no) {
	if (confirm("수정하시겠습니까?")) {
		location.href = "edit.do?no="+no;
	}
}

function goDelete(no){
	if (confirm("정말 삭제하시겠습니까??")){
		$.ajax({
			url : "/pp/portfolio/notice/delete.do",
			data : {"no" : no},
			type : 'get',
			success :function(res){
				console.log(res)
				if(res==1){
					alert("삭제완료");
					  location.href = "/pp/portfolio/notice/index.do";
				}else{
					alert("삭제실패");
				}
			}
		})
	}
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
		<form name="frm" id="frm" action="process.do" method="POST" enctype="multipart/form-data">
		<input type="hidden" name="cmd" value="write">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>작성일</th>
					<td>
						${data.regdate}
					</td>
					<th>조회수</th>
					<td>
						${data.viewcount}
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						${data.title}
					</td>
					<th>작성자</th>
					<td>
						${data.writer}
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						${data.content}
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<a href="" target="_blank">${data.filename_org}</a>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		<div class="btnSet">
				
			<div class="right">
				<a href="javascript:;" class="btn" onclick="location.href='index.do';">목록</a>
				<c:if test="${loginInfo.authority eq 'ROLE_ADMIN'}">
					<a href="javascript:;" class="btn" onclick="goEdit(${param.no});">수정</a>
					<a href="javascript:;" class="btn" onclick="goDelete(${param.no});">삭제</a>
				</c:if>
			</div>
		</div>
		<div style="height:300px;"></div>
	</div>
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
