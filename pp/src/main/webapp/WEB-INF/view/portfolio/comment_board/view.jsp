<%@ page contentType="text/html; charset=utf-8" %>

<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>

function goEdit(boardno,pageNum) {
	if (confirm("수정하시겠습니까?")) {
		location.href = "/pp/portfolio/comment/edit.do?boardno="+boardno;
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

function replywrite(){
	$.ajax({
		url : "/pp/portfolio/comment/replywrite",
		data : {
			content : $('#replycontent').val(),
			boardno : ${data.boardno},
			writer : "${loginInfo.name}"
		},
		type : "post",
		success: function(res){
			if(res.boardno > 0){
				alert("작성완료");
				$('#replycontent').val('');
				comment(1);
				//댓글페이지 새로고침 함수 적기
			}else{
				alert("작성 실패");
			}
		}
		
	});
}

function comment(no){
	$.ajax({
		url : "/pp/portfolio/comment/commentlist",
		tpye : "get",
		data :{
			boardno : ${data.boardno},
			pagenum : no
		},
		success : function(res){
			console.log(res);
			var i=0;
			var html ="";
			html+="<h4> 총"+res.totalElements +"개 | "+(res.number+1) + "/" +res.totalPages +"페이지";
			html+="<class='btn1' onclick='comment(1)' style='float: right'><img src='/pp/img/refresh.png'>";				
			html+="</h4><br><hr>";
			for(var i=0; i<res.content.length; i++){
				html += "<div>" +res.content[i].writer+ "</div>";
				html += "<div>" +res.content[i].regdate+"</div>";
				html += "<div>" +res.content[i].content+ "</div>";
				html += "<hr><br>";
			};
			var endpage = Math.ceil((res.number+1)/10)*10;
			var startpage = endpage - 9;
			if(endpage >= res.totalPages){
				endpage = res.totalPages;
				console.log("1:"+endpage);
			}else{
				endpage = (startpage+9);
				console.log("2:"+endpage);
			}
			console.log("3:"+startpage);
			console.log("4:"+endpage);
			html+= " <div class='pagenate clear'> ";
			html+= "<ul class='paging'>";
			if((startpage-9) > 1){
				html+= "<li><a href='javascript:comment(" +(startpage-1)+ ") ;'>이전</a></li>";
			}
			for (var i=startpage; i<=endpage; i++) {
				html += "<li><a href='javascript:comment("+i+");'";
				if(res.number == i-1){
					html += "class='current'>";
				}else{
					html += ">";
				}
				html += +i+"</a></li>";
			}
			if(res.totalPages > endpage){
				html+= "<li><a href='javascript:comment(" +(endpage+1)+ ") ;'>다음</a></li>";
			}
			html += "</div>";
			$(".replyarea").html(html);			
		}
	});
}
$(function(){
	comment(1);
})
</script>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>자유게시판</h2>
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
					<c:forEach items="${data.image }" var="image">
						<a href="" target="_blank">${image.filename_org }</a><br>
					</c:forEach>
						
					</td>
				</tr>
				
			</tbody>
		</table>
		</form>
		<div class="btnSet">
			<div class="right">
				<a href="javascript:;" class="btn" onclick="location.href='index.do?pagenum=${param.pagenum}&stype=${param.stype}&sword=${param.sword }';">목록</a>
				<a href="javascript:;" class="btn" onclick="goEdit(${param.boardno},${param.pagenum});">수정</a>
				<a href="javascript:;" class="btn" onclick="goDelete(${param.no});">삭제</a>
			</div>
		</div>
		<div style="height:300px;">
			<hr>
			<h2>댓글 작성</h2>
			<hr><br>
			<textarea id='replycontent' rows='4' cols='128'></textarea>
			<a href='javascript:;' class='btn' onclick='replywrite();'>작성</a><br>
			<br><hr><h4>댓글</h4>
			
			<div class="replyarea">
			
			
			</div>
		</div>
	
		

	</div>
	<!--//list-->

	<!-- 댓글 -->
	
</div>
<!--//boardWrap-->
</body>
</html>
