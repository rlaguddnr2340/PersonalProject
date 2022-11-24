<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>공지사항</h2>
		<div align="right">
			<c:if test="${loginInfo.authority eq 'ROLE_ADMIN'}">
				<a href ="/pp/portfolio/notice/write.do"><button class="btn">글작성</button></a>
			</c:if>
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
					<tr>
					<!-- 계산식 = "총개수 - 인덱스 - (현재 페이지 번호 - 1) * 페이지당 개수" -->
						<td>${totalcount - status.index - ((pageNum - 1) * pageRow)}</td>
						<td><a href="/pp/portfolio/notice/view.do?no=${list.no}">${list.title }</a></td>
						<td>${list.writer }</td>
						<td>${list.regdate }</td>
						<td>${list.viewcount}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<div class="pagenate clear">
				<ul class='page'>
				<c:if test="${prev == true}">
						<li><a href="/pp/portfolio/notice/index.do?pageNum=${startPage - 1}&sword=${param.sword }&stype=${param.stype }">이전</a></li>
				</c:if>
				
				<c:forEach var="page" begin="${startPage}" end="${endPage}">
					<li><a href='/pp/portfolio/notice/index.do?pageNum=${page}&sword=${param.sword }&stype=${param.stype }' 
							<c:if test="${pageNum == page}">class='current'</c:if> >${page}
						</a>
					</li>
				</c:forEach>
				<c:if test="${next == true }">
						<li><a href="/pp/portfolio/notice/index.do?pageNum=${endPage + 1 }&sword=${param.sword }&stype=${param.stype }">다음</a></li> 
				</c:if>
				</ul> 
			</div>
			<div class="bbsSearch">
					<form method="get" name="searchForm" id="searchForm" action="/pp/portfolio/notice/index.do">
						<select id="stype" name="stype" class="dSelect" align="center">
								<option value="all"  <c:if test="${param.stype eq 'all'}"> selected="selected" </c:if> >전체</option>
								<option value="title" <c:if test="${'title' eq param.stype  }">selected="selected" </c:if> >제목</option>
								<option value="content" <c:if test="${param.stype eq 'content' }">selected="selected" </c:if> >내용</option>
						</select>
						<span class="searchWord"> <input type="text" id="sword" name="sword" value="${param.sword }" title="검색어 입력"> 
						<input class="btn" type="submit"  value="검색" title="검색">
						</span>
					</form>
			</div>
		</div>
</div>
	<!--//list-->
<!--//boardWrap-->
</body>
</html>
