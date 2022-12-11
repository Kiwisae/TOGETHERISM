<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 실패</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<c:if test="${result == -1}">
	<script>
		alert("계정이 존재하지 않습니다")
		history.go(-1);
	</script>
</c:if>
<c:if test="${result == 1}">
	<script>
		alert("계정 정보를 다시 입력해 주세요")
		history.go(-1);
	</script>
</c:if>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</html>