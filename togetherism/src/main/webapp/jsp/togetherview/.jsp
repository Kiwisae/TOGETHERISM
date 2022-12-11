<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<style>
	.linkstyle {text-decoration: none; color: black; hover: red;}
	.currentPage {font-style: bold;}
	.member_del {color:#A6A6A6; text-decoration:line-through; text-align:"center";}
	.del_date {text-decoration:none;}
</style>
<script src="manager_listSelect.jsp"></script>
<script>
$(function(){
	
	$("#toptable").load("manager_listSelect.jsp");
});

</script>
</head>
<body>

<div id="toptable"></div>

<!-- 회원 목록 테이블 -->
<div id="dlist">
<div align="center">
	<table class="table table-hover w-auto">
		<thread class="table-light">
			<tr>
				<th style="width: 170px"> 이메일 </th>
				<th style="width: 140px"> 닉네임 </th>
				<th style="width: 140px"> 가입일자 </th>
				<th style="width: 140px" align="center"> 탈퇴일자 </th>
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
							<c:if test="${ m.member_del_yn == 'Y' }"> ${m.member_del_date }</c:if>
							<c:if test="${ m.member_del_yn == 'N' }"></c:if>
						</td>
						<td>
							<!-- 탈퇴한 회원일 경우 [강제탈퇴] 버튼 비활성화 -->
							<c:if test="${m.member_del_yn == 'Y' }">
								<button class="btn btn-danger" text-align="center" disabled> 강제탈퇴 </button>
							</c:if>
							
							<!-- 탈퇴하지 않은 회원은 [강제탈퇴] 버튼 활성화 -->
							<c:if test="${m.member_del_yn == 'N' }">
								<button class="btn btn-danger" text-align="center" 
								onClick="location.href='manager_deleteForm.do?member_email=${m.member_email}&page=${page }' "> 강제탈퇴 </button>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>


<div align="center">
	<table class="table table-borderless w-auto">
		<tr>
			<td style="width: 350px" >
			<button class="btn btn-success" onClick="location.href='manager_main.do' ">메인화면</button></td>
			<td align="right" style="width: 350px">
			<input type="button" class="btn btn-warning" value="Q&A" onClick="location.href='qna.do' ">
			</td>
		</tr>
	</table>
</div>

<div align="center">
	<!-- 게시판에 글이 존재할 때 -->
	<c:if test="${ memberCount > 0 }">
		
		<!-- 최신 페이지 -->
		<a href ="manager_delMemberlist.do?page=1" class="linkstyle"> 처음 </a>
		
		<!-- 이전 블럭 이동 -->
		<c:if test="${startPage > 10 }">
			<a href="manager_delMemberlist.do?page=${startPage-10 }" class="linkstyle"> << </a>
		</c:if>
		
		<!-- 1블럭당 출력되는 페이지 : 10 -->
		<c:forEach var="i" begin="${startPage }" end="${endPage }">
			<!-- 현재 페이지 -->
			<c:if test="${i == page }">	<b>${i }</b></c:if>
			
			<!-- 현재 페이지가 아닐 때 -->
			<c:if test="${i != page }">
				<a href="manager_delMemberlist.do?page=${i }" class="linkstyle">${i }</a>
			</c:if>
		</c:forEach>
		
		<!-- 다음 블럭 이동 -->
		<c:if test="${ endPage < pageCount }">
			<a href="manager_delMemberlist.do?page=${startPage+10 }" class="linkstyle"> >> </a>
		</c:if>
		
		<!-- 마지막 페이지 -->
		<a href="manager_delMemberlist.do?page=${pageCount }" class="linkstyle"> 끝 </a>
		
	</c:if>
</div>
</div> <!-- dlist end -->
</body>
</html>