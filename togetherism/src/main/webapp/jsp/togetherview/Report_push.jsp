<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<title>Insert title here</title>
</head>
<body>

<input type="button" value="신고하기" 
 	onclick="location='<%=request.getContextPath()%>/report_check.do?member_email=${member_email}'"/>

</body>
</html>