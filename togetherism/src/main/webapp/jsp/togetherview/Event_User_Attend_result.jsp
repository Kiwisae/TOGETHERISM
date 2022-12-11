<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />

<c:if test="${result == 0}">
	<script>
		alert("이벤트 참석을 희망하실 경우, 모임 가입 후 이벤트 참석이 가능합니다.");
		history.go(-1);
	</script>
</c:if> 

<c:if test="${result == 1}">
	<script>
		alert("참여 등록되었습니다.");
		history.go(-1);
	</script>
</c:if>   

<c:if test="${result == 2}">
	<script>
		alert("이미 참석 등록하신 이벤트입니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 3}">
	<script>
		alert("이벤트 참석이 취소되었습니다.");
		location.href = "<%=request.getContextPath()%>/event_user_attend_mylistPaging.do";
	</script>
</c:if> 