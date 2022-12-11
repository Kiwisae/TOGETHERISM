<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 메일 미리보기</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br>

<!-- 메일 폼 미리보기 -->
<form action="mail.do" method="post">
<input type="hidden" value="${qna_category }">


<section class="p-5"></section>
<div class="container">
	<p><h3>1:1 문의 메일 전송 미리보기</h3></p>
	<p><h6>작성하신 메일을 전송하기 전 한번 더 확인해주세요<br>
	</h6></p>
	<br><br>
	
	<p><table class="table table-borderless w-auto">
		<tr>
			<th style="width:200px"> 분류 </th>
			<td>
				<select class="form-select" aria-label="Default select example" name="qna_category" id="qna_category"
				readonly style='background-color:#E9ECEF' onFocus='this.initialSelect = this.selectedIndex;' onChange='this.selectedIndex = this.initialSelect;'>
				  <option>선택해주세요</option>
				  <option value="회원" <c:if test="${qna_category eq '회원' }"> selected</c:if>>회원</option>
				  <option value="모임/이벤트" <c:if test="${qna_category eq '모임/이벤트' }"> selected</c:if>>모임/이벤트</option>
				  <option value="제안" <c:if test="${qna_category eq '제안' }"> selected</c:if>>제안</option>
				  <option value="기타" <c:if test="${qna_category eq '기타' }"> selected</c:if>>기타</option>
				</select>
			</td>
		</tr>
		<tr>
			<th style="width:200px"> 작성자 </th>
			<td style="width:700px"><input type="text" name="member_nickname" id="member_nickname" value=${member_nickname } class="form-control" placeholder="제목을 입력해주세요" style="width: 700px" readonly></td>
		</tr>
		<tr>
			<th> 메일 주소 </th>
			<td> <input type="email" name="member_email" id="member_email" value="${member_email }" class="form-control" placeholder="답변 받을 이메일 주소를 입력해주세요" style="width: 700px" readonly></td>
		</tr>
		<tr>
			<th> 제목 </th>
			<td> <input type="text" name="mail_subject" id="mail_subject" value="${ mail_subject}" class="form-control" placeholder="제목을 입력해주세요" style="width: 700px" readonly></td>
		</tr>
		<tr>
			<th> 내용 </th>
			<td> <textarea type="text" name="mail_content" id="mail_content" class="form-control" placeholder="내용을 입력해주세요" rows="10" cols="10" readonly>${mail_content }</textarea>
			</td>
		</tr>
	</table></p>
	
	<p><div align="center">
			<input type="submit" class="btn" style="background-color:#5e17eb; color:#ffffff;" id="mailbtn" value="전송">
			<input type="reset" class="btn btn-warning" value="취소" onClick="history.go(-1)">
	</p></div>
</div>
</form>
</section>

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>