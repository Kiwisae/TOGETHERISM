<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<title>신고 폼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
function check(){
	 if($.trim($("#report_reason").val())==""){
		 alert("신고 사유를 선택하세요!");
		 $("#report_reason").val("").focus();
		 return false;
	 }
}
</script>



</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

<br><br>
<h1 align="center" style="font-weight: bold; color: #5e17eb">Togetherism</h1>
<h2 align="center" style="font-weight: bold;">유저 신고</h2>
<br><br>

<form method="post" action="<%=request.getContextPath()%>/report_ok.do"
	onSubmit="return check()">
<input type="hidden" name="report_member_email" value="${report.report_member_email}">
<input type="hidden" name="member_email" value="${report.member_email}">

<table align="center" cellpadding="2" width="650px" height="300px">
	<tr>
	  <th style="font-size: 21px;">신고 작성자</th>
	</tr>
	<tr>
	  <td>${report.report_member_email}</td>
	</tr>
	<tr><td><br></td></tr>
	
	<tr>
	  <th style="font-size: 21px;">신고 유저</th>
	</tr>
	<tr>
	  <td>${report.member_email }</td>
	</tr>
	<tr><td><br></td></tr>
	
	<tr>
	  <th style="font-size: 21px;">신고 사유</th>
	</tr>
	<tr>
		<td><select name="report_reason" id="report_reason" style= "width:645px">
				<option value="">=신고사유선택=</option>
				<option value="sexual_harassment">성희롱</option>
				<option value="insult">욕설</option>
				<option value="racism">인종차별</option>
				<option value="spam">스팸</option>
			</select>
		</td>
	</tr>
	<tr><td><br></td></tr>
	<tr><td><br></td></tr>
	
	<tr>
		<td align="center">
		<input type="submit" value="신고" class="btn btn-danger">
		<input type="reset" value="취소" class="btn btn-warning"> 
		</td>
	</tr>
	
	
	
</table>
</form>

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>