<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div style="margin: auto; float:left">
<div class="list-group" style="width:200px">
  <a href="<%=request.getContextPath()%>/joined_club.do" class="list-group-item list-group-item-action active" aria-current="true">
    가입한 모임
  </a>
  <a href="#" class="list-group-item list-group-item-action">관심있는 모임</a>
  <a href="<%=request.getContextPath()%>/my_club.do" class="list-group-item list-group-item-action">운영하는 모임</a>
  <a href="#" class="list-group-item list-group-item-action">정보 변경</a>
  <a class="list-group-item list-group-item-action disabled">비밀번호 변경</a>
  <a class="list-group-item list-group-item-action disabled">회원 탈퇴</a>
</div>
</div>
</body>
</html>