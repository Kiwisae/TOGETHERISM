<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의 메일 전송 완료</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>
<body>
<script>
	alert("메일 문의가 전송되었습니다.")
	location.href="qna.do";
</script>
</body>
</html>