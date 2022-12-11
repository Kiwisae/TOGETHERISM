<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<!-- 관리자 로그아웃 --> <script src="./js/manager_logout.js"></script>
<style>
	.linkstyle {text-decoration: none; color: black; hover: red;}
	.currentPage {font-style: bold;}
	.member_del {color:#A6A6A6; text-decoration:line-through; text-align:"center";}
	.del_date {text-decoration:none;}
	 #linkstyle{text-decoration:none; color:black;}
	#linkstyle:hover {text-decoration: none; color: #5e17eb; }
	.currentPage {font-style: bold;}
</style>
<!-- 검색창 유효성 검사 -->
<script src="./js/manager_listSearch.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<br>
<p>
<!-- 관리자 메뉴 -->

<div class="container">
	<div class="row">
	<div class="col" style="text-align:center; padding:20px;">
		<p><h3>관리자 > 회원관리 </h3></p>
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
	<table class="table table-borderless w-auto" style="align:center">
		<tr>
			<!-- 현재 활동 회원 목록만 보기 체크박스 -->
			<td align="left" style="width: 400px">
			<form name="check" id="check">
				<div class="form-check">
					<input class="form-check-input" type="checkbox" value="" id="delMember" name="delMember" checked onClick="location.href='manager_list.do' "">
					<label class="form-check-label" for="delMember"> 탈퇴 회원 포함 </label>
				</div>
			</form>
			</td>
					
			<!-- 검색창 -->
			<form method=post action="manager_listSearch.do" id="frm">
			<td align="right" style="width: 150px">
				<select class="form-select form-select-sm" aria-label=".form-select-sm example" name="search" id="search" style="width:110px">
					<option value="member_nickname">닉네임</option>
					<option value="member_email">이메일</option>
				</select>
			</td>
			<td align="center" style="width: 200px">
				<input type="search" class="form-control form-control-sm" name="keyword" id="keyword" style="width:200px">
			</td>
			<td align="right" style="width: 50px">
				<input type="submit" class="btn btn-outline-warning btn-sm" id="findout" value="찾기">
			</td>
			</form>
		</tr>
	</table>
</div>
<!-- 검색창 종료 -->

<!-- 회원 목록 테이블 -->
<div id="dlist">
<div align="center">
	<table class="table table-hover w-auto">
		<thread class="table-light">
			<tr>
				<th style="width: 240px"> 이메일 </th>
				<th style="width: 170px"> 닉네임 </th>
				<th style="width: 170px"> 가입일자 </th>
				<th style="width: 170px" align="center"> 탈퇴일자 </th>
				<th style="width: 110px" align="center"> </th>
			</tr>
		</thread>
		<tbody>
			<!-- 가입한 회원이 없을 때 -->
	 		<c:if test="${empty memberList }">
				<tr style="text-align:center">
					<td colspan=6>
						<br>회원이 존재하지 않습니다.<br><br>
					</td>
				</tr>
			</c:if>
			
			<!-- 가입한 회원이 존재할 때 -->
			<c:if test="${not empty memberList }"> 
				<c:forEach var="m" items="${memberList }">
				
				<!-- 탈퇴한 회원 목록에 줄을 그어줌 -->
				<c:if test="${ m.member_del_yn == 'Y' }"> 
					<tr class="member_del">
				</c:if>
						<td>${m.member_email } </td>
						<td> ${m.member_nickname } </td>
						<td> <fmt:formatDate value="${m.member_reg_date }"  
											pattern="yyyy-MM-dd"/> </td>
						<td>
							<!-- 탈퇴한 회원일 경우 탈퇴일자를 표시 -->
							<c:if test="${ m.member_del_yn == 'Y' }"> <fmt:formatDate value="${m.member_reg_date }"  
											pattern="yyyy-MM-dd"/></c:if>
							<c:if test="${ m.member_del_yn == 'N' }"></c:if>
						</td>
						<td>
							<!-- 탈퇴한 회원일 경우 [상세정보] outline 효과 -->
							<c:if test="${m.member_del_yn == 'Y' }">
								<button class="btn btn-outline-warning" text-align="center" 
								onClick="location.href='manager_deleteForm.do?member_email=${m.member_email}&page=${page }' "> 상세정보 </button>
							</c:if>
							
							<!-- 탈퇴하지 않은 회원의 [상세정보]  -->
							<c:if test="${m.member_del_yn == 'N' }">
								<button class="btn btn-warning" text-align="center" 
								onClick="location.href='manager_deleteForm.do?member_email=${m.member_email}&page=${page }' "> 상세정보 </button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>


<div align="center">
	<!-- 게시판에 글이 존재할 때 -->
	<c:if test="${ memberCount > 0 }">
		
		<!-- 최신 페이지 -->
		<a href ="manager_delMemberlist.do?page=1" id="linkstyle"> 처음 </a>
		
		<!-- 이전 블럭 이동 -->
		<c:if test="${startPage > 10 }">
			<a href="manager_delMemberlist.do?page=${startPage-10 }" id="linkstyle"> << </a>
		</c:if>
		
		<!-- 1블럭당 출력되는 페이지 : 10 -->
		<c:forEach var="i" begin="${startPage }" end="${endPage }">
			<!-- 현재 페이지 -->
			<c:if test="${i == page }">	<b>${i }</b></c:if>
			
			<!-- 현재 페이지가 아닐 때 -->
			<c:if test="${i != page }">
				<a href="manager_delMemberlist.do?page=${i }" id="linkstyle">${i }</a>
			</c:if>
		</c:forEach>
		
		<!-- 다음 블럭 이동 -->
		<c:if test="${ endPage < pageCount }">
			<a href="manager_delMemberlist.do?page=${startPage+10 }" id="linkstyle"> >> </a>
		</c:if>
		
		<!-- 마지막 페이지 -->
		<a href="manager_delMemberlist.do?page=${pageCount }" id="linkstyle"> 끝 </a>
		
	</c:if>
</div>
</div> <!-- dlist end -->

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>