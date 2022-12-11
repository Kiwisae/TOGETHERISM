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
alert("사진 수정 완료");
location.href="<%=request.getContextPath()%>/club_ct.do?club_num=${club_num}";
</script>
</c:if>
<c:if test="${result == 2}">
<script>
alert("사진을 등록한 사람만 사진을 수정할 수 있습니다");
history.go(-1);
</script>
</c:if>
<c:if test="${result == 3}">
<script>
alert("사진 크기 1MB 초과");
history.go(-1);
</script>
</c:if>
<c:if test="${result == 3}">
<script>
alert("사진 크기 1MB 초과");
history.go(-1);
</script>
</c:if>
<c:if test="${result == 4}">
<script>
	alert("jpg,png,gif 사진 파일만 업로드 가능합니다");
	history.go(-1);
</script>
</c:if>
</body>
</html>