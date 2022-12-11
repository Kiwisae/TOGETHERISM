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
<c:if test="${result == 3}">
<script>
	alert("가입된 모임이 아니거나 가입에 실패했습니다.");
	history.go(-1);
</script>
</c:if>
<c:if test="${result == 2}">
<script>
	alert("모임장은 모임 탈퇴가 불가능합니다, 모임을 삭제해주세요");
	history.go(-1);
</script>
</c:if>
<c:if test="${result == 1}">
<script>
	alert("모임 탈퇴가 완료되었습니다");
	location.href="<%=request.getContextPath()%>/joined_club.do?club_num=${club_num}";
</script>
</c:if>
</body>
</html>