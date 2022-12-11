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
	alert("수정 성공했습니다."); // 이후 모임페이지 가는걸로 수정
	location.href="<%=request.getContextPath()%>/club_ct.do?club_num=${club_num}";
// 삭제 메세지 뿌린 후 location 객체로 리스트로로 돌아가기 이떄 리스트는 특정 모임의 리스트이므로club_num 과 eventPage 필요
</script>
</c:if>
<c:if test="${result == 3}">
<script>
	alert("사진 크기 초과");
	history.go(-1);
</script>
</c:if>
</body>
</html>