<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<!-- 관리자 로그아웃 --> <script src="./js/manager_logout.js"></script>
<script src="./js/notice_writeForm.js"></script>
<style>
  	#linkstyle{text-decoration:none; color:black;}
	#linkstyle:hover {text-decoration: none; color: #5e17eb; }
	.currentPage {font-style: bold;}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

	<form method=post action="notice_write.do" enctype="multipart/form-data">
	<input type="hidden" value="<fmt:formatDate value="${ noticeDto.notice_reg_date }" pattern="yyyy-MM-dd HH:mm:ss"/>">
	<p><br>
<!-- 관리자 메뉴 -->

<div class="container">
	<div class="row">
	<div class="col" style="text-align:center; padding:20px;">
		<p><h3> 공지사항 > 작성</h3></p>
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

		<br>
		<br>
		<p>
		<div align="center">
		<table class="table table-borderless w-auto">
			<tr>
				<th style="width: 200px"> 작성자 </th>
				<td align="left" style="width: 700px"> 
					<input type="text" name="manager_email" id="manager_email" value="${sessionScope.manager_email }" class="form-control" style="width: 700px" readonly>
				</td>
			</tr>
			<tr>
				<th> 제목 </th>
				<td> 
					<input type="text" name="notice_title" id="notice_title" placeholder="한글 50자, 영문 100자 이내로 입력해주세요" class="form-control" style="width: 700px">
				</td>
			</tr>
			<tr>
				<th> 내용 </th>
				<td>
					<textarea name="notice_content" id="notice_content" class="form-control" rows="10" cols="10" placeholder="한글 1000자, 영문 2000자 이내로 입력해주세요"></textarea>
				</td>
			</tr>
			<tr>
				<th> 첨부파일 </th>
				<td>
					<input type="file" name="notice_file1" class="form-control form-control-sm" style="width: 700px">
				</td>
			</tr>
			</table>
		</p>
			<div align="center">
				<input type="submit" class="btn text-white" style="background-color:#5e17eb;" value="작성">
				<input type="button" class="btn btn-warning" value="취소" onClick="history.go(-1)">
			</div>
	</form>
	
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>