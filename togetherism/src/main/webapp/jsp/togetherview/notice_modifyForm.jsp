<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<!-- 관리자 로그아웃 --> <script src="./js/manager_logout.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="./js/notice_writeForm.js"></script>
<script>
	$(function() {
		$("#imgdelbtn").click(function(){
			if(confirm("첨부한 이미지를 삭제하시겠습니까?")) {
				var data = { "notice_num" : ${noticeDto.notice_num} }
				
				$.post("notice_modifyFile.do", data, function(result) {
					if(result == 1 ) {
						$(".fileDelete").text("");
					}
				});// post end
			} 
		}); // click end
	}); //main function end
</script>
<style>
  	#linkstyle{text-decoration:none; color:black;}
	#linkstyle:hover {text-decoration: none; color: #5e17eb; }
	.currentPage {font-style: bold;}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

	<form method=post action="notice_modify.do" enctype="multipart/form-data">
	<input type="hidden" name="notice_num" value="${noticeDto.notice_num }">
	<input type="hidden" name="page" value="${page }">
		<p><br>
<!-- 관리자 메뉴 -->

<div class="container">
	<div class="row">
	<div class="col" style="text-align:center; padding:20px;">
		<p><h3>공지사항 > 공지사항 수정 </h3></p>
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

		<p>
		<div align="center">
		<table class="table table-borderless w-auto">
			<tr>
				<th align="right" style="width: 200px"> 작성자 </th>
				<td align="left" style="width: 700px">
					<input type="text" name="manager_email" id="manager_email" value="관리자" class="form-control" style="width: 700px" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th> 제목 </th> 
				<td> 
					<input type="text" name="notice_title" id="notice_title" value="${noticeDto.notice_title }" class="form-control" style="width: 700px">
				</td>
			</tr>
			<tr>
				<th> 내용 </th>
				<td>
					<textarea name="notice_content" id="notice_content" class="form-control" rows="10" cols="10">${noticeDto.notice_content }</textarea><br>
				</td>
			</tr>
			<tr>
				<th> 첨부파일 </th>
				<td>
					<input type="file" name="notice_file1" class="form-control form-control-sm" style="width: 700px">
				</td>
				
			<c:if test="${empty noticeDto.notice_file }">	
				&nbsp;
			</c:if>
				
			<!-- 첨부한 파일이 있을 경우 -->
			<c:if test="${ not empty noticeDto.notice_file }">
			<tr class="fileDelete">
				<th> 기존 첨부파일 </th>
				<td>
					${noticeDto.notice_file }
					<%-- <input id=img class="form-control" type="text" value="${noticeDto.notice_file }" aria-label="readonly input example" readonly style="width: 450px">
					 --%>
					<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" id="imgdelbtn" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
  <path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z"/>
</svg>
				</td>
			</tr>
			</c:if>
			</table>
		</p>
			<div align="center">
				<button type="submit" class="btn text-white" style="background-color: #5e17eb; font-color:#ffffff;">수정</button>
				<button type="reset" class="btn btn-warning" onClick="history.go(-1)">취소</button>
			</div>
	</form>
	
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>