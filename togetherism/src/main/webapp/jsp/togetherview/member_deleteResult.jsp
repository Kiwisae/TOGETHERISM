<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />



<c:if test="${result == 0}">
	<script>
		alert("모임장일 경우, 모임장인 모임을 모두 삭제 후 회원 탈퇴가 가능합니다.");
		history.go(-1);
	</script>
</c:if> 


<c:if test="${result == 1}">
	<script>
		alert("비밀번호가 등록된 정보와 일치하지 않습니다.");
		history.go(-1);
	</script>
</c:if>   


<c:if test="${result == 2}">
	<script>
		alert("Togetherism 회원 탈퇴가 완료되었습니다.");
		location.href="member_login.do";
	</script>
</c:if>  