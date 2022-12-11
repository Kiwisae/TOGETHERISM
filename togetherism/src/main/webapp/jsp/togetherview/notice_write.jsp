<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 > 공지사항</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>
<body>
	<c:if test="${ result == 1 }">
		<script>
			alert("공지사항 작성을 완료했습니다");
			location.href="notice_list.do";
		</script>
	</c:if>
	<c:if test="${ result != 1 }">
		<script>
			alert("공지사항 작성에 실패했습니다");
			history.go(-1);
		</script>
	</c:if>

</body>
</html>