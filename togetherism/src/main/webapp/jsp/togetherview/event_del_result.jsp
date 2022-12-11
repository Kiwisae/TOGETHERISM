<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>
<body>
<c:if test="${result == 2}">
<script>
alert("모임장만 삭제 가능합니다");
history.go(-1);
</script>
</c:if>
</body>
</html>