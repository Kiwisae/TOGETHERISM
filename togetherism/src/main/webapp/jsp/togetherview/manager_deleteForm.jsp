<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${memberDto.member_nickname } 상세정보</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<!-- 관리자 로그아웃 --> <script src="./js/manager_logout.js"></script>
<script src="./js/manager_deleteForm.js"></script>
<style>
	.linkstyle {text-decoration: none; color: black; hover: red;}
	.currentPage {font-style: bold;}
	.member_del {text-decoration:line-through; color:"#d5d5d5"; text-align:"center";}
	.del_date {text-decoration:none;}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

<form method=post action="manager_delete.do">
<input type="hidden" value="${page }">
<p>
<!-- 관리자 메뉴 -->

<div class="container">
	<div class="row">
	<div class="col-md-auto" style="text-align:center; padding:20px;">
		<p><h3>회원관리 > <font color="#5e17eb" >${ memberDto.member_nickname } </font> 상세정보 </h3></p>
	</div>
	<div class="col">
	</div>
	<div class="col" id="sidemenu">
			<button class="btn text-dark" id="logout" style="width:350px; border-color:#fff;">${sessionScope.manager_email }에서 로그아웃</button>
		<br>
		<div class="btn-group">
			<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='manager_main.do' ">관리자 메인</button>
	  		<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='manager_list.do' ">회원 관리</button>
	  		<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='notice_list.do' ">공지사항</button>
		</div>
	</div>
	</div>
</div>

</p>

<p class="lead text-center text-black mb-5"></p>
<div align="center">
	<table class="table table w-auto">
		<tr>
			<c:if test="${ memberDto.member_del_yn == 'Y' }">
			<td rowspan=6 style="width: 200px">
					<img src="./images/logo_white_sm.png" class="img-thumbnail" style="height:200px"><br>
			</c:if>
			<c:if test="${ memberDto.member_del_yn == 'N' }">
			<td rowspan=6 style="width: 200px">
				<img src="./upload/${memberDto.member_image }" class="img-thumbnail"><br>
			</c:if> 
			</td>
			<th style="width: 200px"> 회원 이메일 </th>
			<c:if test="${ memberDto.member_del_yn == 'Y' }"> <td style="width: 400px" class="member_del"> </c:if> 
			<c:if test="${ memberDto.member_del_yn == 'N' }"> <td style="width: 400px"> </c:if> 
			<input type="text" class="form-control-plaintext" name="member_email" value="${memberDto.member_email }" readonly>
			</td>
		</tr>
		<tr>
			<th> 신고 횟수 </th>
			<c:if test="${ memberDto.member_del_yn == 'Y' }"> <td class="member_del"> </c:if> 
			<c:if test="${ memberDto.member_del_yn == 'N' }"> <td> </c:if> 
			<input type="text" class="form-control-plaintext" name="member_nickname" value="${reportCount }" readonly>
		</tr>
		<tr>
			<th> 개설 모임 </th>
			<c:if test="${ memberDto.member_del_yn == 'Y' }"> <td class="member_del"> </c:if> 
			<c:if test="${ memberDto.member_del_yn == 'N' }"> <td> </c:if> 
			<input type="text" class="form-control-plaintext" name="club_host_count" value="${clubList }" readonly>
		</tr>
		<c:if test="${not empty clubDto }">
		<tr>
			<th> 개설 모임 목록</th>
			<c:if test="${ memberDto.member_del_yn == 'Y' }"> <td class="member_del"> </c:if> 
			<c:if test="${ memberDto.member_del_yn == 'N' }"> <td> </c:if> 
 					<c:forEach var="c" items="${clubDto}">
						<input type="text" class="form-control-plaintext" name="club_host_name" value="${c.club_name }" readonly>
					</c:forEach>
		</tr>
		
		<tr>
			<th> 가입 모임 </th>
			<td> <input type="text" class="form-control-plaintext" name="join_club_count" value="${cjiList }" readonly> </td>
		</tr>
		
		<tr>
			<th> 가입 모임 목록</th>
			<td>
				<c:if test="${ memberDto.member_del_yn == 'N' }">
					<c:forEach var="cji" items="${cjiDto }">
						<input type="text" class="form-control-plaintext" name="member_nickname" value="${ cji.club_name}" readonly>
					</c:forEach>
				</c:if>
			</td>
		</tr>
		
		</c:if>
		<tr>
			<c:if test="${not empty clutDto && memberDto.member_del_yn == 'N' }">
				<th> 강제탈퇴 사유 </th>
				<td>
					<input type="text" class="form-control" name="member_del_reason" placeholder="개설한 모임이 있어 강제탈퇴 할 수 없습니다" id="member_del_reason" disabled>
				</td>
			</c:if>
			<c:if test="${empty clubDto && memberDto.member_del_yn == 'Y' }">
				<th> 강제탈퇴 사유</th>
				<td>
					<input type="text" class="form-control" name="member_del_reason" placeholder="이미 탈퇴한 회원입니다" id="member_del_reason" disabled>
				</td>
			</c:if>
			<c:if test="${empty clubDto && memberDto.member_del_yn == 'N'}">
				<th> 강제탈퇴 사유 </th>
				<td>
					<input type="text" class="form-control" name="member_del_reason" placeholder="탈퇴 사유를 입력해 주세요" id="member_del_reason">
				</td>
			</c:if>
		</tr>
	</table>
</div>
<br>

</p>
<div align="center">
	<table>
		<tr>
			<td align="center" style="width: 700px">
			<c:if test="${not empty clubDto or memberDto.member_del_yn == 'Y'}">
				<button class="btn btn-danger" id="memberdelbtn" disabled> 강제탈퇴 </button>
			</c:if>
			<c:if test="${empty clubDto and memberDto.member_del_yn == 'N'}">
				<button class="btn btn-danger" id="memberdelbtn"> 강제탈퇴 </button>
			</c:if>
			<input type="button" class="btn btn-warning" value="회원목록"onClick="history.go(-1)">
				</td>
		</tr>
	</table>
</div>
<%-- <div align="center">
	<!-- 게시판에 글이 존재할 때 -->
	<c:if test="${ noticeCount > 0 }">
		
		<!-- 최신 페이지 -->
		<a href ="notice_list.do?page=1" class="linkstyle"> 처음 </a>
		
		<!-- 이전 블럭 이동 -->
		<c:if test="${startPage > 10 }">
			<a href="notice_list.do?page=${startPage-10 }" class="linkstyle"> << </a>
		</c:if>
		
		<!-- 1블럭당 출력되는 페이지 : 10 -->
		<c:forEach var="i" begin="${startPage }" end="${endPage }">
			<!-- 현재 페이지 -->
			<c:if test="${i == page }">	<b>${i }</b></c:if>
			
			<!-- 현재 페이지가 아닐 때 -->
			<c:if test="${i != page }">
				<a href="notice_list.do?page=${i }" class="linkstyle">${i }</a>
			</c:if>
		</c:forEach>
		
		<!-- 다음 블럭 이동 -->
		<c:if test="${ endPage < pageCount }">
			<a href="notice_list.do?page=${startPage+10 }" class="linkstyle"> >> </a>
		</c:if>
		
		<!-- 마지막 페이지 -->
		<a href="notice_list.do?page=${pageCount }" class="linkstyle"> 끝 </a>
		
	</c:if>
</div> --%>
</form>

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>