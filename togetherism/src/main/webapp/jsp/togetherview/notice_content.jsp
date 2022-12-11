<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 내용</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<!-- 관리자 로그아웃 --> <script src="./js/manager_logout.js"></script>
<script>
$(function(){
	$('#delbtn').click(function(){
		if(confirm("정말 삭제하시겠습니까?")){
			self.location.href="notice_delete.do?notice_num=${noticeDto.notice_num}"
		}
	});
});
</script>
<style>
  	#linkstyle {text-decoration:none; color:black;}
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

<p></p>
<p></p>
<div align="center">
	<table class="table w-auto">
		<thread class="table-light">
			<tr>
				<th style="width: 950px" colspan=2> <h3>${noticeDto.notice_title } </h3>
				<c:if test="${not empty n.notice_file }">
					&nbsp;&nbsp;
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-earmark-image" viewBox="0 0 16 16">
						<path d="M6.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z"/>
						<path d="M14 14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5L14 4.5V14zM4 1a1 1 0 0 0-1 1v10l2.224-2.224a.5.5 0 0 1 .61-.075L8 11l2.157-3.02a.5.5 0 0 1 .76-.063L13 10V4.5h-2A1.5 1.5 0 0 1 9.5 3V1H4z"/>
					</svg>
				</c:if>
				</th>
			</tr>
			<tr>
				<td>관리자</td>
				<td align="right">
					<fmt:formatDate value="${noticeDto.notice_reg_date }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
				<c:if test="${noticeDto.notice_file != null }">
					<tr>
						<td colspan=2>
							첨부파일 : <a href="./jsp/togetherview/file_down.jsp?file_name=${noticeDto.notice_file }" id="linkstyle">${noticeDto.notice_file }</a>
						</td>
					</tr>
				</c:if>
		</thread>
		<tbody>
			<td colspan=2 ><br><br><br><br><br>
				${notice_content }
				<c:if test="${noticeDto.notice_file != null }">
					<br><br><br><img src="./upload/${noticeDto.notice_file }" width="30%" height="30%">
				</c:if><br><br><br><br><br>
			</td>
		</tbody>
	</table>
</div>
</p>
<div align="center">
	<button class="btn btn-warning" onClick="location.href='notice_list.do?notice_num=${noticeDto.notice_num }&page=${page}' "> 목록 </button>
	<c:if test="${not empty sessionScope.manager_email }">
		<button class="btn text-white" style="background-color: #5e17eb; font-color:#ffffff;" onClick="location.href='notice_modifyForm.do?notice_num=${noticeDto.notice_num}&page=${page}' "> 수정 </button>
		<button class="btn btn-danger" id="delbtn"> 삭제 </button>
	</c:if>
	<c:if test="${empty sessionScope.manager_email }"></c:if>
	
</div>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>