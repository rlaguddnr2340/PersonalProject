<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<link rel="stylesheet" href="<%=util.Property.contextPath%>/css/join.css">
</head>
<body>
<script>
var check=0;
$(function(){
	$("#id").focusout(function(){
		check=0;
	})
})
function goSave(id){
	if($("#id").val()==''){
		alert("아이디를 입력하세요.");
		$("#id").focus();
		return false;
	}
	var reg_pwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
	if( !reg_pwd.test($("#password").val()) ) {
		alert("비밀번호는 영문,숫자,특수문자 조합으로 8자 이상 입력하세요.");
		return false;
	}
	
	if(check==0){
		alert("아이디 중복체크바랍니다.");
		return false;
	}
	
	$("#frm").submit();
}

function idcheck(){
	if($("#id").val()==''){
		alert("아이디를 입력하세요.");
		$("#id").focus();
		return false;
	}else{
		$.ajax({
			url : "/pp/portfoil/member/idcheck.do",
			async: false,
			data : {
				id : $("#id").val()
			},
			success : function(res){
				if(res !=0){
					alert("중복된 아이디입니다.");
					check=0;
				}else{
					alert("사용 가능한 아이디입니다.");
					check=1;
				}
			}
		});
	}
}

</script>
<div class="sub">
            <div class="size">
                <h3 class="sub_title">회원가입</h3>
                <form name="frm" id="frm" action="joinproc.do" method="post">
                <table class="board_write">
                    <caption>회원가입</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                    	<tr>
                            <th>*ID</th>
                            <td>
                                <input type="text" name="id" id="id" class="inNextBtn" style="float:left;">
                                <span class="id_check"><a href="javascript:;" onclick="idcheck();"  class="btn bgGray" style="float:left; width:auto; clear:none;" id="idupCheckBtn">중복확인</a></span>
                            </td>
                        </tr>
                        <tr>
                            <th>*비밀번호</th>
                            <td><input type="password" name="password" id="password" style="float:left;"> <span class="ptxt">비밀번호는 숫자, 영문, 특수문자 조합으로 8자 이상으로 입력해주세요.</span> </td>
                        </tr>
                        <tr>
                            <th>*이름</th>
                            <td><input type="text" name="name" id="name" style="float:left;" maxlength="5" required> </td>
                        </tr>                   
                        <tr>
                            <th>*휴대폰 번호</th>
                            <td>
                                <input type="text" name="hp" id="hp	" value=""  maxlength="15" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <th>*생년월일</th>
                            <td><input type="date" name="birthday" id="birthday" style="float:left;" autocomplete="off"></td>
                        </tr>   
                    </tbody>
                </table>
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                	<div>
                    	<a class="btn bgGray" href="javascript:;"  onclick="goSave()">가입</a> &nbsp;&nbsp;
                    	<a class="btn bgGray" href="/pp/index.do">돌아가기</a> &nbsp;&nbsp;
                    	<a class="btn bgGray" href="/pp/login">로그인</a>
                    </div>
                </div>
                
            </div>
        </div>
</body>
</html>