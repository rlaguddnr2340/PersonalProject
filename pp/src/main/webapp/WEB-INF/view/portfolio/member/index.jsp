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
		<h2>회원목록</h2>
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
					<col width="25%" />
					<col width="25%" />
				</colgroup>
				<thead>
					<tr>
						<th>번호</th>
						<th>ID</th>
						<th>이름</th>
						<th>hp</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${empty list}">
					<tr>
						<td colspan="4">등록된 글이 없습니다.</td>
					</tr>
				</c:if>
				<c:forEach var="list" items="${list}" varStatus="status">
					<tr style='cursor:pointer;'>
					<!-- 계산식 = "총개수 - 인덱스 - (현재 페이지 번호 - 1) * 페이지당 개수" -->
						<td>${totalcount - status.index - (data.pageNum-1)*data.pageRow}</td>
						<td class="title"  style="text-align: center">
							<a href="">${list.id}</a>
						</td>
						<td>${list.name }</td>
						<td>${list.hp }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		<div class="pagenate clear">
			<ul class='page'>
				<c:if test="${pageinfo.prev == true}">
						<li><a href="/pp/portfolio/member/index.do?pageNum=${data.startPage - 1}">이전</a></li>
				</c:if>
				
				<c:forEach var="page" begin="${data.startPage}" end="${data.endPage}">
					<li><a href='/pp/portfolio/member/index.do?pageNum=${page}' 
							<c:if test="${page == data.pageNum}">class='current'</c:if> >${page}
						</a>
					</li>
				</c:forEach>
				<c:if test="${pageInfo.next == true }">
						<li><a href="/pp/portfolio/member/index.do?pageNum=${endPage + 1 }">다음</a></li> 
				</c:if>
			</ul> 
		</div>
		<div class="bbsSearch">
					<form method="get" name="searchForm" id="searchForm" action="/pp/portfolio/member/index.do">
						<select id="stype" name="stype" class="dSelect" align="center">
								<option value="all"  <c:if test="${param.stype eq 'all'}"> selected="selected" </c:if> > 전체</option>
								<option value="id" <c:if test="${param.stype eq 'id'}"> selected="selected" </c:if> > 아이디</option>
								<option value="name" <c:if test="${param.stype eq 'name'}"> selected="selected" </c:if> > 이름</option>
						</select>
						<span class="searchWord"> <input type="text" id="sword" name="sword" value="${param.sword }" title="검색어 입력"> 
						<input class="btn" type="submit"  value="검색" title="검색">
						</span>
					</form>
			</div>
	</div>
	<!--//list-->
</div>
<!--//boardWrap-->
</body>
</html>
