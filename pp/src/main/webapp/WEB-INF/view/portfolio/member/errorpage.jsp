<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
</head>
<body>
<script>
$(function(){

	//if문 추가 (refer == index.do 면 iframe닫기)
	if(${refer == "http://localhost:8081/pp/index.do"}){
		console.log(${refer == "http://localhost:8081/pp/index.do"});
		alert("관리자만 접근 가능합니다.");
		parent.delTabCur();
	}
})
</script>
</body>
</html>