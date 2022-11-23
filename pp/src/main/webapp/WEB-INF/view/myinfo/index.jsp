<%@ page contentType="text/html; charset=utf-8" %>
<!doctype html>
<html lang="ko">
<head>
<title><%=util.Property.title %></title>
<%@ include file="/WEB-INF/view//include/headHtml.jsp" %>
</head>
<body>
<div id="boardWrap" class="bbs">
	<div class="pageTitle">
		<h2>테스트</h2>
	</div>
	<!--//pageTitle-->
	<div class="write">
		<table>
			<colgroup>
				<col style="width:150px"/>
				<col style="width:*"/>
				<col style="width:150px"/>
				<col style="width:*"/>
			</colgroup>
			<tbody>
				<tr>
					<th>이름</th>
					<td>김형욱</td>
					<th>나이</th>
					<td>27세</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>010-7724-2340</td>
					<th>이메일</th>
					<td>rlaguddnr2340@naver.com</td>
				</tr>
				<tr>
					<th>주소</th>
					<td colspan="3">
						인천광역시 부평구 주부토로 262번길 19-36
					</td>
				</tr>
				<tr>
					<th rowspan="3">학력</th>
					<td colspan="3">
						작전 고등학교
					</td>
				</tr>
				<tr>
					<td colspan="3">
						명지전문대학교 전자과(컴퓨터 전자과)
					</td>
				</tr>
				<tr>
					<td colspan="3">
						학점은행제 정보통신학과
					</td>
				</tr>
				<tr>
					<th >이력</th>
					<td colspan="3">
						이글루코퍼레이션 보안관제팀 (9개월) - 보안 이벤트 탐지 및 처리, 개인정보 유출 방지
					</td>
				</tr>
				<tr>
					<th rowspan="5">자격증</th>
					<td colspan="3">
						정보처리기사(최종합격)
					</td>
				</tr>
				<tr>
					<td colspan="3">
						SQL개발자(SQLD자격)
					</td>
				</tr>
				<tr>
					<td colspan="3">
						정보보안기사(필기합격)
					</td>
				</tr>
				<tr>
					<td colspan="3">
						네트워크관리자 2급
					</td>
				</tr>
				<tr>
					<td colspan="3">
						리눅스마스터 2급
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<!--//boardWrap-->
</body>
</html>