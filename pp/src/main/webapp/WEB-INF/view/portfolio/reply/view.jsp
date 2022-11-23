<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>

function goReply(no) {
	location.href = "replywrite.do?no="+no;
}

function goEdit(pageNum,no) {
	if (confirm("수정하시겠습니까?")) {
		location.href = "/pp/portfolio/reply/edit.do?pageNum="+pageNum+"&no="+no;
	}
}

function goDelete(no) {
	if (confirm("삭제하시겠습니까?")) {
		location.href = "/pp/portfolio/reply/delete.do?no="+no;
	}
}
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>Q&A</h2>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="write">
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
						${data.regdate }
					</td>
					<th>조회수</th>
					<td>
						${data.viewcount }
					</td>
				</tr>
				<tr>
					<th>제목</th>
					<td>
						${data.title }
					</td>
					<th>작성자</th>
					<td>
						${data.writer }
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						${data.content }
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<c:forEach items="${image }" var="list">
							${list.filename_org }<br>
						</c:forEach>
					</td>
				</tr>
			</tbody>
		</table>
		
		<div class="btnSet">
			<div class="right">
				<a href="index.do?pageNum=${pageinfo.pageNum}" class="btn" >목록</a>
				<c:if test="${loginInfo.id eq data.writer}">
					<a href="javascript:;" class="btn" onclick="goEdit(${param.pageNum },${param.no});">수정</a>
					<a href="javascript:;" class="btn" onclick="goDelete(${param.no});">삭제</a>
				</c:if>
				<c:if test="${loginInfo.authority eq 'ROLE_ADMIN' }">
					<a href="javascript:;" class="btn" onclick="goReply(${param.no});">답변작성</a>
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
