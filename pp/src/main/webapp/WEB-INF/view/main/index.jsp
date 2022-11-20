<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title%></title>      
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script>
$(document).ready(function(){
	$(".trade_type").each(function(idx, item) {
		if ($(".trade_type").eq(idx).prop("checked")) {	// 라디오박스 체크된 경우
			var val = $("input:radio[name='trade_type']").eq(idx).val();
			selectNation("export");
		}
    });
	
	$(".trade_type").on('ifChecked', function(){
		$(".trade_type").each(function(idx, item) {
			if ($(".trade_type").eq(idx).prop("checked")) {	// 라디오박스 체크된 경우
				var val = $("input:radio[name='trade_type']").eq(idx).val();
				selectNation(val);
			}
	    });
    });
	
});

function selectPort(source, target, sel) {
	$("#"+target+" option").remove();
	
	var korea_city = ["BUSAN", "INCHEON", "PYONGTAEK", "KWANGYANG"];
	var korea_value = ["KRPUS", "KRINC", "KRPTK", "KRKAN"];
	var japan_city = ["CHIBA", "HIROSHIMA", "KOBE", "NAGOYA", "OSAKA", "SHIMIZU", "TOKYO", "YOKOHAMA"];
	var japan_value = ["JPCHB", "JPHIJ", "JPUKB", "JPNGO", "JPOSA", "JPSMZ", "JPTYO", "JPYOK"];
	var china_city = ["NINGBO", "QINGDAO", "SHANGHAI", "TAICANG", "XINGANG", "ZHANGJIAGANG"];
	var china_value = ["CNNBG", "CNTAO", "CNSHA", "CNTAG", "CNTXG", "CNZJG"];
	
	var nation = $("#"+source+" option:selected").val();
	if (nation == "korea") {
		for (var i=0; i<korea_city.length; i++) {
			var isSel = "";
			if (korea_value[i] == sel) isSel = "selected";
			$("#"+target).append("<option value="+korea_value[i]+" "+isSel+">"+korea_city[i]+"</option>");
		}
	} else if (nation == "japan") {
		for (var i=0; i<japan_city.length; i++) {
			var isSel = "";
			if (japan_value[i] == sel || (sel == "" && japan_value[i] == "JPTYO")) isSel = "selected";
			$("#"+target).append("<option value="+japan_value[i]+" "+isSel+">"+japan_city[i]+"</option>");
		}
	} else if (nation == "china") {
		for (var i=0; i<china_city.length; i++) {
			var isSel = "";
			if (china_value[i] == sel || (sel == "" && china_value[i] == "CNSHA")) isSel = "selected";
			$("#"+target).append("<option value="+china_value[i]+" "+isSel+">"+china_city[i]+"</option>");
		}
	}
	$('#'+target).data('selectric').refresh();
}

function changeTab(v) {
	$("#curbl_free").removeClass("on");
	$("#curbl_member").removeClass("on");
	$("#curbl_"+v).addClass("on");
	
	$("#free_tab").hide();
	$("#member_tab").hide();
	$("#"+v+"_tab").show();
}

function selectNation(v) {
	if (v == "export") {
		$("#nation1 option").remove();
		$("#nation1").append("<option value='korea'>KOREA</option>");
		$("#nation1").data('selectric').refresh();
		selectPort('nation1','port1', '');
		
		$("#nation2 option").remove();
		$("#nation2").append("<option value='japan'>JAPAN</option>");
		$("#nation2").append("<option value='china'>CHINA</option>");
		$("#nation2").data('selectric').refresh();
		selectPort('nation2','port2', 'JPTYO');
		
	} else if (v == "import") {
		$("#nation1 option").remove();
		$("#nation1").append("<option value='japan'>JAPAN</option>");
		$("#nation1").append("<option value='china'>CHINA</option>");
		
		$("#nation1").data('selectric').refresh();
		selectPort('nation1','port1', 'JPTYO');
		
		$("#nation2 option").remove();
		$("#nation2").append("<option value='korea'>KOREA</option>");
		$("#nation2").data('selectric').refresh();
		selectPort('nation2','port2', '');
	}
}

function goSchedule() {
	var n1 = $("#nation1").val();
	var n2 = $("#nation2").val();
	var p1 = $("#port1").val();
	var p2 = $("#port2").val();
	var trade_type = $("input:radio[name=trade_type]:checked").val();
	var pYear = $("#pYear").val();
	var pMonth = $("#pMonth").val();
	
	parent.clickMenu('schedule1', '스케쥴', '/schedule/index.do?nation1='+n1+'&nation2='+n2+'&port1='+p1+'&port2='+p2+'&trade_type='+trade_type+'&pYear='+pYear+'&pMonth='+pMonth);
}

function goCargo() {
	var stype = $("#cargo_stype").val();
	var sval = $("#cargo_sval").val();
	
	parent.clickMenu('cargo1', '화물추적', '/cargo/index.do?stype='+stype+'&sval='+sval)
}

function goContainer() {
	var stype = $("#con_stype").val();
	var sval = $("#con_sval").val();
	
	parent.clickMenu('export0', '컨테이너<br>중량 조회', '/export/container/index.do?stype='+stype+'&sval='+sval)
}
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
			<div class="main">
				<div class="wid48 fl_l">
					<div class="box notice">
						<h2>공지사항</h2>
						<ul>
							<li style="text-align:center;">등록된 공지사항이 없습니다.</li>
							<li><a href="javascript:;" onclick="parent.clickMenu('portfolio1', '공지사항', '/board/notice/view.do?idx=');">
								제목<span>조회수</span></a></li>
						</ul>
					</div>
					<div class="box notice">
						<h2>Q&A(인기글)</h2>
						<ul>
							<c:if test="${empty qnalist }">
								<li style="text-align:center;">등록된 Q&A가 없습니다.</li>							
							</c:if>
							<c:if test="${!empty qnalist }">
								<c:forEach items="${qnalist}" var="list">
								 	<li>
								 		<a href="javascript:;" onclick="parent.clickMenu('portfolio4', 'Q&A(인기글)', '/portfolio/reply/view.do?no=${list.no}');">${list.title } <span>${list.regdate}</span>
								 		</a>
								 	</li>
								</c:forEach>
							</c:if>
						</ul>
					</div>
					<div class="linkBox">
						<ul>
							<li class="link01"><a href="">Profile</a></li>
							<li class="link02"><a href="">Java</a></li>
							<li class="link03"><a href="">BigData</a></li>
						</ul>
					</div>
				</div>
				<div class="wid48 fl_r">
					<div class="box bl">
						<h2>책소개</h2>
						<table>
							<thead>
								<tr>
								<c:if test="${empty booklist }">
									<li style="text-align:center;">등록된 책 정보가 없습니다.</li>							
								</c:if>
								<c:if test="${!empty booklist }">
									<th>ID</th>
									<th>책이름</th>
									<th>책내용</th>
									<th>작성일</th>
								</c:if>
								</tr>
							</thead>
							<tbody>
							<c:forEach items="${booklist }" var="list">
								<tr>
									<td>${list.writer }</td>
									<td>
										<c:choose>
								           <c:when test="${fn:length(list.title) > 14}">
								           		<c:out value="${fn:substring(list.title,0,13)}"/>...
								           </c:when>
								           <c:otherwise>
								           		<c:out value="${list.title}"/>
								           </c:otherwise> 
							         	</c:choose>
						         	</td>
									<td>
										<a href="javascript:;" onclick="parent.clickMenu('portfolio2', '책소개', '/portfolio/gallery/index.do?no=${list.no}');">
											<c:choose>
									           <c:when test="${fn:length(list.content) > 14}">
									           		<c:out value="${fn:substring(list.content,333,340)}"/>...
									           </c:when>
									           <c:otherwise>
									           		<c:out value="${list.content}"/>
									           </c:otherwise> 
							         		</c:choose>
										</a>
									</td>
									<td>
										${fn:substring(list.regdate,0,10) } 
									</td>
								</tr>
							</c:forEach>
							</tbody>
						</table>
					</div>
					<!--//바로가기-->
					<div class="box bl">
						<h2>자유 게시판 / 3일 이내 가입자</h2>
						<div class="blTab">
							<ul>
								<li id="curbl_free" class="on" onclick="changeTab('free');">자유</li>
								<li id="curbl_member" onclick="changeTab('member');">회원</li>
							</ul>
						</div>
						<table id="free_tab">
							<thead>
								<tr>
								<c:if test="${empty freelist }">
									<li style="text-align:center;">등록된 글이 없습니다.</li>							
								</c:if>
								<c:if test="${!empty freelist }">
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
								</c:if>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${freelist.content }" var="list" >
									<tr>
										<td><a href="" onclick="parent.clickMenu('portfolio5', '자유게시판', '/portfolio/comment/view.do?boardno=${list.boardno}');">${list.title }</a></td>
										<td>${list.writer}</td>
										<td>${list.regdate}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						
						<table id="member_tab" style="display:none;">
							<thead>
								<c:if test="${empty memberlist }">
									<li style="text-align:center;">3일 이내 가입한 회원이 없습니다.</li>							
								</c:if>
								<c:if test="${!empty memberlist }">
									<tr>
										<th>ID</th>
										<th>이름</th>
										<th>가입일</th>
									</tr>
								</c:if>
							</thead>
							<tbody>
								<c:forEach items="${memberlist}" var="list">
									<tr>
										<td><a href="javascript:;" onclick="parent.clickMenu('portfolio6', '회원관리', '/portfolio/member/index.do?');">${list.id}</a></td>
										<td>${list.name }</td>
										<td>${list.regdate }</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
</div>
<!--//contentsWrap-->
</body>
</html>
