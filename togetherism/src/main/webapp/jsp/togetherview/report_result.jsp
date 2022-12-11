<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<title>신고 결과</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>


<c:if test="${!empty insertR}"> 
	<script>
		alert("신고 완료되었습니다.");
		location.href="<%=request.getContextPath()%>/main.do";
	</script>
</c:if>

<c:if test="${!empty checkR}">
	<script>
		alert("이미 신고한 회원입니다.");
		history.go(-1);
	</script>
</c:if> 

</body>
</html>