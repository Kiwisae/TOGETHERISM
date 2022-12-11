<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내보내기</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>
<body>
<c:if test="${result == 1}">
<script>
alert("해당 회원을 성공적으로 내보냈습니다");
location.href="<%=request.getContextPath()%>/club_ct.do?club_num=${club_num}";
</script>
</c:if>
<c:if test="${result == 2}">
<script>
alert("모임장만 다른 회원을 내보낼 수 있습니다");
history.go(-1);
</script>
</c:if>

</body>
</html>