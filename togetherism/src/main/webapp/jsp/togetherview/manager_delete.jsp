<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강제탈퇴 완료</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<script>
	alert("삭제가 완료되었습니다");
	location.href="manager_list.do";
</script>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</html>