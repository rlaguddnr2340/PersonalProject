<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<link rel="stylesheet" href="<%=util.Property.contextPath%>/css/join.css">
</head>
<body>
<script>
$(function(){
	if(${refer == "http://localhost:8081/pp/index.do"}){
		alert("로그인후 이용가능합니다.");
		parent.delTabCur();
	}
	else{
		alert("로그인후 이용가능합니다.");
		location.href="${refer}";
	}
})
</script>
</body>
</html>