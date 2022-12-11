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

<c:if test="${result == 1}">
	<script>
	alert("가입 성공했습니다.");
	location.href="<%=request.getContextPath()%>/club_ct.do?club_num=${club_num}";
	</script>
</c:if>
<c:if test="${result == 2}">
	<script>
	alert("이미 가입된 모임입니다");
	location.href="<%=request.getContextPath()%>/club_ct.do?club_num=${club_num}";

	</script>
</c:if>
<c:if test="${result == 3}">
	<script>
	alert("정원이 다 찼습니다");
	location.href="<%=request.getContextPath()%>/club_ct.do?club_num=${club_num}";

	</script>
</c:if>

</body>
</html>