<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>답변게시판</h2>
			<div class="right">
				<a href="write.do" class="btn">글작성</a>
			</div>
	</div>
	<!--//pageTitle-->
	<!--//search-->
	<div class="list">
			<table>
				<caption> 목록 </caption>
				<colgroup>
					<col width="50px" />
					<col width="*" />
					<col width="10%" />
					<col width="10%" />
					<col width="10%" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="5">등록된 글이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="list" items="${list}" varStatus="status">
					<tr style='cursor:pointer;'>
					<!-- 계산식 = "총개수 - 인덱스 - (현재 페이지 번호 - 1) * 페이지당 개수" -->
						<td>${totalcount - status.index - (data.pageNum-1)*data.pageRow}</td>
						<td class="title">
							<a href="/pp/portfolio/reply/view.do?pageNum=${data.pageNum}&no=${list.no}">
								<c:if test="${list.nested !=0 }">
									<c:forEach begin="1" end="${list.nested}">
										&nbsp;&nbsp;&nbsp;
									</c:forEach>
									<img src="<%=util.Property.contextPath%>/img/ico_re.png">
								</c:if>${list.title}
							</a>
							
						</td>
						<td>연동x</td>
						<td>${list.regdate }</td>
						<td>${list.viewcount }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		<div class="pagenate clear">
			<ul class='page'>
				<c:if test="${pageinfo.prev == true}">
						<li><a href="/pp/portfolio/reply/index.do?pageNum=${data.startPage - 1}">이전</a></li>
				</c:if>
				
				<c:forEach var="page" begin="${data.startPage}" end="${data.endPage}">
					<li><a href='/pp/portfolio/reply/index.do?pageNum=${page}' 
							<c:if test="${page == data.pageNum}">class='current'</c:if> >${page}
						</a>
					</li>
				</c:forEach>
				<c:if test="${pageInfo.next == true }">
						<li><a href="/pp/portfolio/reply/index.do?pageNum=${endPage + 1 }">다음</a></li> 
				</c:if>
			</ul> 
		</div>
	</div>
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
