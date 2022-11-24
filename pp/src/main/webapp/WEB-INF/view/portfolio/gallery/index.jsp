<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script>
<script src="<%=util.Property.contextPath%>/js/imagesloaded.pkgd.js"></script>
<script>
 //폴다운 메뉴
 $(function(){
     $('.outer-menu').hover(function(){
         $(this).find('.inner-menu').css('display','block');
     },function(){
         $(this).find('.inner-menu').css('display','none');
     });
 })

 //페이지
 $(function(){
     $('#main-section').imagesLoaded(function(){
         $('#main-section').masonry({
             itemSelector:'.paper',
             columnWidth:230,
             isAnimated: true
         }); 
     });
 })
 
 $(function(){
	 if(${param.no != null}){
		 showLightbox(${param.no});
	 }
 })
 
 //삭제
 function deleteimg(no){
 	if (confirm("정말 삭제하시겠습니까??")){
 		$.ajax({
 			url : "/pp/portfolio/gallery/delete.do",
 			data : {"no" : no},
 			type : 'post',
 			success :function(res){
 				console.log(res)
 				if(res==1){
 					alert("삭제완료");
 					  location.href = "/pp/portfolio/gallery/index.do";
 				}else{
 					alert("삭제실패");
 				}
 			}
 		})
 		console.log(no);
 		
 	}else{
 		return false;
 	}
 }
 //수정
 function editimg(no){
 	if (confirm("수정하시겠습니까??")){
 		location.href="/pp/portfolio/gallery/edit.do?no="+no;
 	}
 }

 function showLightbox(no){	
 	if(${logininfo.name !=null}){
 	 $.ajax({
 		url :'/pp/portfolio/gallery/view.do',
 		type : 'post',
 		data : {
 			no:no
 		},
 		datatype : 'json',
 		success:function(res){
 			console.log(res);
 			var profileImage="";
 			var contentImage="";
 			$.each(res, function(i, e){
 				if(e["order_num"]==0){
 					profileImage = e["filename_real"];
 				}else{
 					contentImage = e["filename_real"];
 				}
 			})
 			$(".lightbox-img").attr({"src":'/pp/upload/'+contentImage,"style": "width:600px;"});
 			$(".user-information-image img").attr({"src":'/pp/upload/'+profileImage,"style": "width:40px; height:70px"});
 			var str ="";
          str+="<h3>"+res[0].title+"</h3>";
          str+="<p>"+res[0].content+"<p>"
 			$(".user-information-text").html(str);
          var str2 ="";
          if(res[0].writer=="${loginInfo.id}" || "${loginInfo.authority}" =="ROLE_ADMIN"){
           str2+="<button style='float: right; border : solid; color: red' onclick='deleteimg(" +res[0].no+");' >삭제</button>";	                	
           str2+="<button style='float: right; border : solid; color: blue' onclick='editimg(" +res[0].no+");' >수정</button>";	                	
          }
          $("#button-area").html(str2);
          $('#darken-background').show();
 $('#darken-background').css('top',$(window).scrollTop());
 $('body').css('overflow','hidden');            			
 		}
 	 });
 	}else{
 		alert("로그인후 이용 가능합니다.")
 	}
 	
} 
 //라이트 박스 구성
 $(function(){
     function hideLightbox(){
         $('#darken-background').hide();
         $('body').css('overflow','');
     }
 
     $('#darken-background').click(function(){
         hideLightbox();
     });

     //$('.paper').click(function(){ showLightbox();});

     $('#lightbox').click(function(event){
         event.stopPropagation();
     });
 });
</script>
    
     <!-- 초기화하기 -->
     <style>
       * {
           margin: 0;
           padding: 0;
           font-family: 'Malgun Gotic', sans-serif;
       }
       a { text-decoration: none;}
       img { border: 0;}
       li { list-style: none;}
       html { background: #f7f5f5;}
    </style>
    <!-- 헤더  -->
    <style>
        #main-header{
            height: 40px;
            background: #faf7f7;
            position:relative;
        }
        .header-search-form {float: left;}
        .header-menu{float: right;}
        .header-title{
            position: absolute;
            width: 200px;
            height: 40px;
            left: -50%;
            margin-left: -100px;
            background: url('/img/logo.png');
            background-repeat: no-repeat;
            text-indent: -9999x;
            background-size: contain;
        }
    </style>
     <!-- 풀다운 -->
     <style>
       .outer-menu{
           float: left;
           width: 100px;
           height: 20px;
           line-height: 20px;
           padding: 10px 0;
           position: relative;
           text-align: center;

           font-size: 13px;
           font-weight: bold;

           z-index: 9999;
       }

       .outer-menu:hover{ background: #e1dfdf;}
       .inner-menu{
           display: none;
           background: #ffffff;
           margin-top: 10px;
           width: 100%;
           border-top: 1px solid #cccaca;
           box-shadow: 0 2px 4px rgba(34,25,25,0.5);
       }
       .inner-menu a {
           display: block;
           padding: 5px 10px;
           z-index: 5000;
       }
       .inner-menu a:hover{ background: #e1dfdf;}
    </style>

     <!-- 내비게이션 메뉴 -->
     <style>
       #main-navigation{
           height: 30px;
           background: #faf7f7;
           border-top: 1px solid #cfcaca;
           box-shadow: 1px 3px 3px rgba(34,25,25,0.4);
       }

       #main-navigation > ul{
           overflow: hidden;
           text-align: center;
       }
       #main-navigation >ul >li{
           display: inline;
           padding: 0 5px;
           line-height: 30px;
           font-size: 13px;
           color: #524d4d;
           text-shadow: 0 1px 1px white;
       }

       #main-navigation >ul >li >li:hover{
           background: #e1dfdf;
           border-radius: 2px;
       }
    </style>
     <!-- 검색양식 -->
     <style>
       .header-search-form{
           height: 26px;
           padding:7px;
       }
       .input-search{
           display: block;
           float:left;
           background-color: #ffffff;
           border: 1px solid #cccccc;
           border-radius: 15px 0 0 15px;
           box-shadow: inset 0 1px rgba(0,0,0 0.5);
           width: 120px;
           height: 24px;
           padding: 0 0 0 10px;
           font-size: 12px;
           color: #555555;
       }
       .input-search:focus{
           border-color: rgba(82,168,236,0.8);
           outline: 0;
           box-shadow: inset 0 1px 1px rgba(0,0,0 0.5);
       }
       .input-search-submit{
           display: block;
           float: left;
           width: 50px;
           height: 26px;
           border-radius: 0 15px 15px 0;
           border: 1px solid #cccccc;
           margin-left: -1px;
           vertical-align: top;
           display: inline-block;
       }
    </style>

     <!-- 종이 스타일 -->
     <style>
       .paper{
           width: 200px;
           margin-top: 10px;
           padding: 15px 15px 0;
           font-size: 11px;
           background: #ffffff;
           box-shadow: 0 1px 3px rgba(34, 25, 25, 0.4);
       }
       .paper-content{
           margin: 0 -15;
           margin-top: 10px;
           padding:  10px 15px;
           background: #f2f0f0;
           overflow: hidden;
       }
       .paper-description{
           margin: 10px 0;
       }
       .paper-link{
           display: block;
           float: left;
       }
       .paper-text{
           float: left;
           width: 150px;
           margin-left: 10px;
       }
    </style>

    <!-- 섹션 -->
    <style>
       #main-section{
           width: 920px;
           margin: 0 auto;
       }
       @media (max-width: 919px){
           #main-section{ width: 690px;}
       }

       @media (min-width: 930px) and (max-width:1149px){
           #main-section{ width: 920px;}
       }

       @media (min-width: 1150px) and (max-width:1379){
           #main-section{ width: 1150px;}
       }
       
       @media (min-width: 1380px){
           #main-section{ width: 1380px;}
       }
    </style>

    <!-- 라이트박스 -->
    <style>
        #darken-background{
            position: absolute;
            top:0;
            left: 0;
            right:0;
            height: 100%;

            display: none;
            background: rgba(0, 0, 0, 0.9);
            z-index: 10000;
            overflow-y: scroll;
        }
        #lightbox{
            width: 700px;
            margin: 20px auto;
            padding: 15px;

            border: 1px solid #333333;
            border-radius: 5px;
            background: white;
            box-shadow: 0 5px 5px rgba(34, 25,25, 0.4);
            text-align: center;

        }
        .user-information { overflow: hidden; text-align: left;}
        .user-information-image{ float: left; }
        .user-information-text{ float: right; width: 620px;}
        .lightbox-splitter { margin: 10px 0;}
    </style>    
</head>
<body>
    <!-- 헤더 -->
    <header id="main-header">
        <div class="btnSet">
			<div class="right">
				<a href="write.do" class="btn">작성</a>
			</div>
		</div>
        <h1 class="header-title">Interest</h1>
        <div class="header-menu">
        </div>
    </header>
    

    <!-- 본문 영역 -->
    <section id="main-section">
    	<c:if test="${empty list}">
    			<h3>등록된 사진이 없습니다.</h3>
    		</c:if>
    	<c:forEach var="list" items="${list}"  varStatus="index" >
    		<c:if test="${list.order_num !=0 }">
	    		<div class="paper" onclick="showLightbox(${list.no});">
		            <div class="paper-holder">
		            	<% double random = Math.floor(Math.random()*150)+30; %>
		                <a><img width="<%=random %>" src="/pp/upload/${list.filename_real }"></a>
		            </div>
		            <p class="paper-description">${list.title}</p>
		            
	        	</div>
	        </c:if>
    	</c:forEach>
    </section>
    
    <!-- 라이트 박스 -->
    <div id="darken-background">
        <div id="lightbox">
            <div class="user-information">
                <a class="user-information-image" href="#">
                    <img src="">
                </a>
                <div class="user-information-text">
                    
                </div>
            </div>
                <hr class="lightbox-splitter">
            <div id="button-area">
            	
            </div>
                <img class="lightbox-img" src="">
        </div>
    </div>
</body>
</html>