<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 참석 버튼</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
 
 	<input type="button" value="참석하기" 
 	onclick="location='<%=request.getContextPath()%>/event_user_attend_ok.do?event_num=${event_num }&club_num=${club_num}'"/>


</body>
</html>