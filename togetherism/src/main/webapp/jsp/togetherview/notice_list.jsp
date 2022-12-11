<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<!-- 관리자 로그아웃 --> <script src="./js/manager_logout.js"></script>
<style>
  	#linkstyle{text-decoration:none; color:black;}
	#linkstyle:hover {text-decoration: none; color: #5e17eb; }
	.currentPage {font-style: bold;}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<p><br>
<!-- 관리자 메뉴 -->

<div class="container">
	<div class="row">
	<div class="col" style="text-align:center; padding:20px;">
		<p><h3>
		<c:if test="${empty sessionScope.manager_email }">
		공지사항 
		</c:if>
		<c:if test="${not empty sessionScope.manager_email }">
		관리자 > 공지사항 
		</c:if>
		</h3></p>
	</div>
	<div class="col">
	</div>
	<div class="col" id="sidemenu">
		<c:if test="${not empty sessionScope.manager_email }">
			<button class="btn text-dark" id="logout" style="width:350px; border-color:#fff;">${sessionScope.manager_email }에서 로그아웃</button>
		<br>
		<div class="btn-group">
			<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='manager_main.do' ">관리자 메인</button>
	  		<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='manager_list.do' ">회원 관리</button>
	  		<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='notice_list.do' ">공지사항</button>
		</div>
		</c:if>
	</div>
	</div>
</div>

</p>

<p class="lead text-center text-black mb-5"></p>

<br>
<div align="center">
	<table class="table table-hover w-auto">
		<thread class="table-light">
			<tr>
				<th align="center" style="width: 150px">  </th>
				<th style="width: 600px"> 제목 </th>
				<th style="width: 200px"> 작성일 </th>
			</tr>
		</thread>
		<tbody>
			<c:forEach var="n" items="${noticeList }">
				<tr>
					<td align="center"> ${n.notice_num }
						<c:set var="num" value="${n.notice_num-1 }"/></td>
					<td>
						<a href="notice_content.do?notice_num=${n.notice_num }&page=${page}" id="linkstyle">${n.notice_title }</a>
						<c:if test="${not empty n.notice_file }">
							&nbsp;&nbsp;
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
							  <path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
							  <path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
							</svg>
						</c:if>
						</td>
					<td><fmt:formatDate value="${n.notice_reg_date }"
										pattern="yyyy-MM-dd HH:mm"/>
						</td>
			</c:forEach>
		</tbody>
	</table>
</div>
<div align="center">
	<table class="table table-borderless w-auto">
		<tr>
			<td style="width:450px">
			<c:if test="${not empty sessionScope.manager_email }">
			<td align="right" style="width: 400px">
				<button class="btn text-white" style="background-color: #5e17eb; font-color:#ffffff;'" onClick="location.href='notice_writeForm.do' ">작성</button>
			</c:if>
			<c:if test="${empty sessionScope.manager_email }"></c:if>
		   </td>
		</tr>
	</table>
</div>
<div align="center">
	<!-- 게시판에 글이 존재할 때 -->
	<c:if test="${ noticeCount > 0 }">
		
		<!-- 최신 페이지 -->
		<a href ="notice_list.do?page=1" id="linkstyle"> 처음 </a>
		
		<!-- 이전 블럭 이동 -->
		<c:if test="${startPage > 10 }">
			<a href="notice_list.do?page=${startPage-10 }" id="linkstyle"> << </a>
		</c:if>
		
		<!-- 1블럭당 출력되는 페이지 : 10 -->
		<c:forEach var="i" begin="${startPage }" end="${endPage }">
			<!-- 현재 페이지 -->
			<c:if test="${i == page }">	<b>${i }</b></c:if>
			
			<!-- 현재 페이지가 아닐 때 -->
			<c:if test="${i != page }">
				<a href="notice_list.do?page=${i }" id="linkstyle">${i }</a>
			</c:if>
		</c:forEach>
		
		<!-- 다음 블럭 이동 -->
		<c:if test="${ endPage < pageCount }">
			<a href="notice_list.do?page=${startPage+10 }" id="linkstyle"> >> </a>
		</c:if>
		
		<!-- 마지막 페이지 -->
		<a href="notice_list.do?page=${pageCount }" id="linkstyle"> 끝 </a>
		
	</c:if>
</div>
</div>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>