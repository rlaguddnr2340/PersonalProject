<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="util.*" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %>:1</title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
function directionTop() {
	$('html, body').animate({scrollTop: 0 }, 'slow');
}
var tabWidth = 120;		// 탭넓이

// iframe height 자동 조절
function calcHeight(id){
	//find the height of the internal page
	
	var the_height=
	document.getElementById(id).contentWindow.
	document.body.scrollHeight;
	
	//change the height of the iframe
	document.getElementById(id).height=
	the_height+100;
	//document.getElementById('the_iframe').scrolling = "no";
	document.getElementById(id).style.overflow = "hidden";
}

//iframe height 자동 조절(수동)
function calcHeightManual(id, m_height){
	
	//change the height of the iframe
	document.getElementById(id).height=m_height;
	
	//document.getElementById('the_iframe').scrolling = "no";
	document.getElementById(id).style.overflow = "hidden";
}

//iframe height 자동 조절(Row추가)
function calcHeightAddRow(id){
	
	var the_height=
	document.getElementById(id).contentWindow.
	document.body.scrollHeight;
	
	//change the height of the iframe
	document.getElementById(id).height=
	the_height+100;
	
	//document.getElementById('the_iframe').scrolling = "no";
	document.getElementById(id).style.overflow = "hidden";
}


$(document).ready(function(){
    $(".gnb_menu").click(function(){
    	//alert($(this).next(".gnb_submenu").css("display"));
    	if ($(this).next(".gnb_submenu").css("display") == "none") {
    		$(".gnb_submenu").slideUp();
    	}
    	$(this).addClass("imgActive");
        $(this).next(".gnb_submenu").slideToggle();
    });
    
    clickMenu('main1', 'Main', '/main/index.do', true);
    
    $("#pass").bind("keydown", function(e) {
		if (e.keyCode == 13) { // enter key
			login();
			return false
		}
	});
    
});

// 즐겨찾기 메뉴 toggle
function favoriteToggle() {
	$('#favoriteList').slideToggle();
}

// 메뉴클릭 tab+iframe 추가
function clickMenu(id, title, url, reload) {
	url = '<%=util.Property.contextPath%>'+url;
	var nl = "";
	if (title.indexOf("<br>") < 0) {
		nl = "class=\"line1\"";
	}
	if ($("#"+id+"_tab").length == 0) {
		$(".tab > ul:last").append("<li style='width:"+tabWidth+"px;' id=\""+id+"_tab\" onclick=\"activeTab('"+id+"');\" "+nl+">"+title+"<span><img id=\""+id+"_closeImg\" src=\"/img/tab_close_on.png\" onclick=\"delTab(event,'"+id+"')\"/></span></li>");
		$(".contents:last").append("<iframe src="+url+" id=\""+id+"_ifrm\" onload=\"calcHeight('"+id+"_ifrm');\" name=\"WrittenPublic\" title=\"\" frameborder=\"0\" scrolling=\"no\" style=\"overflow-x:hidden; width:100%; min-height:500px; \"></iframe>");
	} else {
		if (reload) $("#"+id+"_ifrm").attr("src",url);
	}
	
	activeTab(id);
}

// tab+iframe 삭제
function delTab(e, id) {
	e.stopPropagation();
	var isCurTab = $("#"+id+"_tab").hasClass("on");	// 삭제한탭이 현재활성화된 탭인지여부 확인
	var idx = $("#"+id+"_tab").index();
	$("#"+id+"_tab").remove();	// tab 삭제
	$("#"+id+"_ifrm").remove();	// iframe 삭제
	
	$(".tab > ul").css("width",($(".tab > ul > li").length*tabWidth)+"px");
	
	// 현재탭이 한개이상 존재하고, 해당id탭이 현재활성화된탭인 경우 마지막탭 활성화
	if ($(".tab > ul > li").length >= 1 && isCurTab) {
		//var tId = $(".tab > ul > li:last").attr("id");
		var tId = "";
		if (idx == 0) {
			tId = $(".tab > ul > li").eq(0).attr("id");
		} else {
			tId = $(".tab > ul > li").eq(idx-1).attr("id");
		}
		tId = tId.substr(0, tId.indexOf("_"));
		activeTab(tId);
	} 
}

//tab+iframe 삭제 자식 iframe에서 호출될때 사용
function delTabForChild(id) {
	var isCurTab = $("#"+id+"_tab").hasClass("on");	// 삭제한탭이 현재활성화된 탭인지여부 확인
	var idx = $("#"+id+"_tab").index();
	$("#"+id+"_tab").remove();	// tab 삭제
	$("#"+id+"_ifrm").remove();	// iframe 삭제
	
	$(".tab > ul").css("width",($(".tab > ul > li").length*tabWidth)+"px");
	
	// 현재탭이 한개이상 존재하고, 해당id탭이 현재활성화된탭인 경우 마지막탭 활성화
	if ($(".tab > ul > li").length >= 1 && isCurTab) {
		//var tId = $(".tab > ul > li:last").attr("id");
		var tId = "";
		if (idx == 0) {
			tId = $(".tab > ul > li").eq(0).attr("id");
		} else {
			tId = $(".tab > ul > li").eq(idx-1).attr("id");
		}
		tId = tId.substr(0, tId.indexOf("_"));
		activeTab(tId);
	} 
}

//현재탭 삭제
function delTabCur() {
	var curTabIdx;	// 현재활성화된 탭
	$(".tab > ul > li").each(function(idx, item) {
		if ($(".tab > ul > li").eq(idx).hasClass("on")) {
			curTabIdx = idx;
		}
	});
	
	var curTabId = $(".tab > ul > li").eq(curTabIdx).attr("id");
	curTabId = curTabId.substr(0, curTabId.indexOf("_"));
	delTabForChild(curTabId);
	
}

// tab 활성화(iframe 노출)
function activeTab(id) {
	$(".tab > ul > li").removeClass("on");
	$(".tab > ul > li > span > img").attr("src", "<%=util.Property.contextPath%>/img/tab_close_off.png");	// tab close img 전체 off
	$(".contents > iframe").hide();
	
	$("#"+id+"_tab").addClass("on");							// tab 활성화
	$("#"+id+"_closeImg").attr("src", "<%=util.Property.contextPath%>/img/tab_close_on.png");	// tab close img on
	$("#"+id+"_ifrm").show();									// iframe 노출

	$(".gnb_menu").removeClass("on");
	$(".gnb_submenu ul > li").removeClass("on");
	$("#"+id.substr(0, id.length-1)).addClass("on");	// 대메뉴 활성화
	$("#"+id+"_submenu").addClass("on");				// 소메뉴 활성화
	
	// ul 넓이를 탭갯수만큼 넓힘(좁으면 2줄로 떨어지는 문제)
	$(".tab > ul").css("width",($(".tab > ul > li").length*tabWidth)+"px");
	tabWidthCon();	// 탭영역 조절
}

// left메뉴 노출/미노출
function menuToggle() {
	var obj = $("#menuWrap").offset();
	var time = 0;	// 효과동작에 문제가 있어 0으로 고정
	if (obj.left == 0) {
		$("#menuWrap").animate({"margin-left":"-220"}, time);
		$("#contentsWrap").animate({"width":1200},time);
		$(".tabWrap").animate({"width":1200},time);
		$(".tab").animate({"width":1120},time);
	} else {
		$("#menuWrap").animate({"margin-left":"0"}, time);		
		$("#contentsWrap").animate({"width":980},time);
		$(".tabWrap").animate({"width":980},time);
		$(".tab").animate({"width":900},time);
	}
}

// 이전탭 활성화
function goPrevTab() {
	var tabLength = $(".tab > ul > li").length;
	
	if (tabLength > 1) {
		var curTabIdx;	// 현재활성화된 탭
		$(".tab > ul > li").each(function(idx, item) {
			if ($(".tab > ul > li").eq(idx).hasClass("on")) {
				curTabIdx = idx;
			}
		});
		var prevTabIdx = 0;
		if (curTabIdx == 0) {
			prevTabIdx = tabLength-1;	// 첫번째탭이라면 마지막탭idx로 설정
		} else {
			prevTabIdx = curTabIdx-1;
		}
		
		// 이전탭 id구해서 활성화
		var tabId = $(".tab > ul > li").eq(prevTabIdx).attr("id");
		tabId = tabId = tabId.substr(0, tabId.indexOf("_"));
		activeTab(tabId);
	}
}

// 다음탭 활성화
function goNextTab() {
	var tabLength = $(".tab > ul > li").length;
	
	if (tabLength > 1) {
		var curTabIdx;	// 현재활성화된 탭
		$(".tab > ul > li").each(function(idx, item) {
			if ($(".tab > ul > li").eq(idx).hasClass("on")) {
				curTabIdx = idx;
			}
		});
		var nextTabIdx = 0;
		if (curTabIdx == tabLength-1) {
			nextTabIdx = 0;	// 마지막탭이라면 첫번째탭idx로 설정
		} else {
			nextTabIdx = curTabIdx+1;
		}
		
		// 다음탭id구해서 활성화
		var tabId = $(".tab > ul > li").eq(nextTabIdx).attr("id");
		tabId = tabId = tabId.substr(0, tabId.indexOf("_"));
		activeTab(tabId);
	}
}

// 영역밖으로 벗어난 탭을 현재 화면에 맞추어 이동
function tabWidthCon() {
	var tLength = $(".tab").width();						// 전체영역 넓이
	var tabLength = $(".tab > ul > li").length*tabWidth;	// 실제탭영역 넓이
	
	//if (tabLength > tLength) {	// 실제탭영역이 전체영역보다 클경우
		var curTabIdx;	// 현재활성화된 탭
		$(".tab > ul > li").each(function(idx, item) {
			if ($(".tab > ul > li").eq(idx).hasClass("on")) {
				curTabIdx = idx;
			}
		});
		
		var obj1 = $(".tab").offset();			// 전체영역
		var obj2 = $(".tab > ul").offset();		// 실제탭영역
		var direction = "";
		var moveVal = 0;
		var curPosition = (curTabIdx*tabWidth)+parseInt(tabWidth)+parseInt(obj2.left);
		var curLeft = parseInt(obj2.left);
		
		// 현재탭*탭넓이 + 실제탭left < 전체탭left
		if ((curPosition-tabWidth) < obj1.left) {
			if (curTabIdx == 0) {
				moveVal = obj1.left;
			} else {
				moveVal = (curPosition - tabWidth);
			}
			$(".tab > ul").offset({left:moveVal});
		}
		if (curPosition > (obj1.left+tLength)) {
			moveVal = parseFloat(obj2.left) - (curPosition - (obj1.left+tLength));
			$(".tab > ul").offset({left:moveVal});
		}
		
	//}
}

function test() {
	$("#myinfo1_submenu").trigger("click");
	$("#myinfo2_submenu").trigger("click");
	$("#myinfo3_submenu").trigger("click");
	$("#myinfo4_submenu").trigger("click");
	$("#myinfo5_submenu").trigger("click");
	$("#export1_submenu").trigger("click");
	$("#export2_submenu").trigger("click");
	$("#export3_submenu").trigger("click");
	$("#export4_submenu").trigger("click");
	$("#export5_submenu").trigger("click");
}

function login(){
	if($("#username").val()==''){
		alert("아이디를 입력하세요");
		$("#username").focus();
		return false;
	}
	if($("#password").val()==''){
		alert("비밀번호를 입력하세요");
		$("#password").focus()
		return false;
	}

	$("#loginFrm").submit();
}
$(function(){
	if(${LoginFailMessage !=null}){
		alert("${LoginFailMessage}");
		$.ajax({
			url : "/pp/portfolio/member/sessiondel.do",
			type : "get"
		})
	}
})

</script>
<style>
	
</style>
</head>
<body>
<div id="wrap">
	<div id="header">
		<h1><a href="<%=util.Property.contextPath%>/index.do">개인 포트폴리오</a><a href="javascript:;" onclick="test()">&nbsp;&nbsp;&nbsp;</a></h1>
	
	</div>
	<!--//header-->
	<div id="container">
		<div id="menuWrap">
			<div class="allmenu">전체메뉴
				<div class="allmenu_con">
					<dl style="width:13.666%;">
						<dt><a href="javascript:;">나의 정보</a></dt>
						<dd class="frist"><a href="javascript:;" onclick="clickMenu('myinfo1', '프로필', '/myinfo/index.do', false)">프로필</a></dd>
						<dd><a href="javascript:;" onclick="clickMenu('myinfo2', '자기소개', '/myinfo/myinfo.do', false)">자기소개</a></dd>
					</dl>
					<dl style="width:16.666%;">
						<dt><a href="javascript:;">팀프로젝트</a></dt>
						<dd class="frist"><a href="javascript:;" onclick="clickMenu('teamproject1', '둘이놀자', '/project/hotelppt.do', false)">둘이놀자(호텔서비스)</a></dd>
					</dl>
					<dl style="width:15.666%;">
						<dt><a href="javascript:;">개인프로젝트</a></dt>
						<dd class="frist"><a href="javascript:;" onclick="clickMenu('portfolio1', '공지사항', '/portfolio/notice/index.do', false)">공지사항</a></dd>
						<dd><a href="javascript:;" onclick="clickMenu('portfolio2', '책소개', '/portfolio/gallery/index.do', false)">책소개</a></dd>
						<dd><a href="javascript:;" onclick="clickMenu('portfolio4', 'Q&A', '/portfolio/reply/index.do', false)">Q&A</a></dd>
						<dd><a href="javascript:;" onclick="clickMenu('portfolio5', '자유게시판', '/portfolio/comment/index.do', false)">자유게시판</a></dd>
						<dd><a href="javascript:;" onclick="clickMenu('portfolio6', '회원관리', '/portfolio/member/index.do', false)">회원관리</a></dd>
					</dl>
					<dl style="width:13.666%;">
						<dt><a href="javascript:;">보안프로젝트</a></dt>
						<dd class="frist"><a href="javascript:;" onclick="clickMenu('project1', '보안 프로젝트', '/project/securityppt.do', false)">취약점보안솔루션</a></dd>
					</dl>
					
					
				</div>
			</div>
			
			<div class="login">
				<c:if test="${empty loginInfo}">
					<form action="/pp/login" method="post" id="loginFrm" name="loginFrm">
						<fieldset>
							<input type="text" id="username" name="username" value placeholder="ID" style="width: 95px;">
							<input type="password" id="password" name="password" value placeholder="PASSWORD" style="width: 95px;">
							<input type="button" class="btn" value="LOGIN" style="position: absolute; top: 0; right: 0; width: 75px; height: 100%" onclick="return login()" >
						</fieldset>
						<ul >
							<li class="homepage"><a href="/pp/portfolio/member/join.do" >회원가입${logininfo.name}</a></li>
						</ul>
					</form>
				</c:if>
				
				<c:if test="${!empty loginInfo}">
						<fieldset>
							${loginInfo.id}님 환영합니다.
						</fieldset>
						<ul >
							<li class="homepage"><a href="/pp/portfolio/member/logout.do">로그아웃</a></li>
						</ul>
				</c:if>
			</div>
			
			<div class="gnb">
				<dl>
					<dt id="main" class="gnb_menu">Main</dt>
					<dd class="gnb_submenu">
						<ul>
							<li id="main1_submenu" onclick="clickMenu('main1', '메인', '/main/index.do', false)">Main</li>
						</ul>
					</dd>
					<dt id="myinfo" class="gnb_menu">나의정보</dt>
					<dd class="gnb_submenu">
						<ul>	
							<li id="myinfo1_submenu" onclick="clickMenu('myinfo1', '프로필', '/myinfo/index.do', false)">프로필</li>
							<li id="myinfo2_submenu" onclick="clickMenu('myinfo2', '자기소개', '/myinfo/myinfo.do', false)">자기소개</li>
						</ul>
					</dd>
					<dt id="teamproject" class="gnb_menu">팀프로젝트</dt>
					<dd class="gnb_submenu">
						<ul>	
							<li id="teamproject1_submenu" onclick="clickMenu('teamproject1', '둘이놀자', '/project/hotelppt.do', false)">둘이놀자(호텔시스템)</li>
						</ul>
					</dd>
					<dt id="portfolio" class="gnb_menu">개인 프로젝트</dt>
					<dd class="gnb_submenu">
						<ul>	
							<li id="portfolio1_submenu" onclick="clickMenu('portfolio1', '공지사항', '/portfolio/notice/index.do', false)">공지사항</li>
							<li id="portfolio2_submenu" onclick="clickMenu('portfolio2', '책소개', '/portfolio/gallery/index.do', false)">책소개</li>
							<li id="portfolio4_submenu" onclick="clickMenu('portfolio4', 'Q&A', '/portfolio/reply/index.do', false)">Q&A</li>
							<li id="portfolio5_submenu" onclick="clickMenu('portfolio5', '자유게시판', '/portfolio/comment/index.do', false)">자유게시판</li>
							<li id="portfolio6_submenu" onclick="clickMenu('portfolio6', '회원관리', '/portfolio/member/index.do', false)">회원관리</li>
						</ul>
					</dd>
					<dt id="project" class="gnb_menu">보안 프로젝트</dt>
					<dd class="gnb_submenu">
						<ul>	
							<li id="project1_submenu" onclick="clickMenu('project1', '보안 프로젝트', '/project/securityppt.do', false)">취약점보안솔루션</li>
						</ul>
					</dd>
					
					
				</dl>
			</div>
			<div class="menuclose" onclick="menuToggle();"><img src="<%=util.Property.contextPath%>/img/menu_close.png" /></div>
			<div class="copy">Copyright (C) 2022<br />
				김형욱 Portfolio. 
			</div>
		</div>
		<!--//menuWrap-->
		<div id="contentsWrap">
			<div class="tabWrap">
				<div class="tab"> <!--  style="overflow:scroll;" -->
					<ul style="overflow:hidden;width:1500px;">
					</ul>
				</div>
				<div class="tabNavi">
					<ul>
						<li><img src="<%=util.Property.contextPath%>/img/tab_prev.png" onclick="goPrevTab();"/></li>
						<li><img src="<%=util.Property.contextPath%>/img/tab_next.png" onclick="goNextTab();"/></li>
					</ul>
				</div>
			</div>
			<!--//tab-->
			<div class="contents">
			</div>
		</div>
		<!--//contentsWrap-->
	</div>
	<div class="btnTop">
		<a href="#"><img src="<%=util.Property.contextPath%>/img/btn_top.png" alt="맨위로" /></a>
	</div>
	<!--//container-->
</div>
</body>
</html>
