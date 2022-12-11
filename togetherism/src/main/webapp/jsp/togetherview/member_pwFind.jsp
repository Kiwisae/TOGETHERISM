<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<title>Togetherism 계정 비밀번호 찾기</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
function check(){
	 if($.trim($("#member_email").val())==""){
		 alert("이메일을 입력하세요!");
		 $("#member_email").val("").focus();
		 return false;
	 }
	 if($.trim($("#member_mobile1").val())==""){
		 alert("휴대폰 번호 앞자리를 입력하세요!");
		 $("#member_mobile1").val("").focus();
		 return false;
	 }
	 if($.trim($("#member_mobile2").val())==""){
		 alert("휴대폰 번호 중간자리를 입력하세요!");
		 $("#member_mobile2").val("").focus();
		 return false;
	 }
	 if($.trim($("#member_mobile3").val())==""){
		 alert("휴대폰 번호 마지막 자리를 입력하세요!");
		 $("#member_mobile3").val("").focus();
		 return false;
	 }
}
</script>


</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

<c:if test="${empty pwdok}"> 
<form action="<%=request.getContextPath()%>/member_pwfind_ok.do" method="post" onSubmit="return check()">

<br><br>
<h1 align="center" style="font-weight: bold; color: #5e17eb">Togetherism</h1>
<h2 align="center" style="font-weight: bold;">비밀번호 찾기</h2>
<br><br>


	<table align="center" cellpadding="2" width="650px" height="300px">
		<tr>
			<th style="font-size: 21px;">이메일</th>
		</tr>
		
		<tr>
			<td>
				<input type="text" name="member_email" id="member_email" style= "width:645px"
				placeholder="도메인을 포함하여 이메일 주소 전체를 입력하세요(예:togetherism@gmial.com)" / >
			</td>
		</tr>
		<tr><td><br></td></tr>
		
		<tr>
			<th style="font-size: 21px;">휴대폰번호</th>
			<td>
		</tr>
		<tr>
			<td>	
				<input type="text" name="member_mobile1" id="member_mobile1" style= "width:205px"
				placeholder="숫자만 입력하세요"/> -
				<input type="text" name="member_mobile2" id="member_mobile2" style= "width:205px"
				placeholder="숫자만 입력하세요"  /> -
				<input type="text" name="member_mobile3" id="member_mobile3" style= "width:205px"
				placeholder="숫자만 입력하세요" />
			</td>
		</tr>	
		<tr><td><br></td></tr>
			
 		<tr>
 		<td align="center">
 			<input type="submit" value="찾기" class="btn btn-primary">
			<input type="reset" value="취소"  class="btn btn-danger" >
			<input type="button" value="로그인" onClick="location='<%=request.getContextPath()%>/member_login.do'"
			class="btn btn-warning">
		</td>
 		</tr>
	</table>
</form>
</c:if>

<c:if test="${!empty pwdok}">
<br><br>
<h1 align="center" style="font-weight: bold; color: #5e17eb">Togetherism</h1>
<h2 align="center" style="font-weight: bold;">비밀번호 찾기 결과</h2>
<br><br>

    <table align="center" cellpadding="2" width="650px" height="200px">
     <tr>
      <td align="center" >${pwdok}</td>
     </tr>
     
      <tr><td><br></td></tr>

      
     <tr>
      <td align="center"><input type="button" value="로그인" 
      onClick="location='<%=request.getContextPath()%>/member_login.do'" class="btn btn-primary"/></td>
     </tr>
     <tr><td><br></td></tr>
    </table>
    
</c:if> 


<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>