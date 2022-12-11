<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

<c:if test="${result ==1 }">
	<script>
		alert("글이 수정되었습니다.");
		location.href="notice_content.do?notice_num=${noticeDto.notice_num}&page=${page}";
	</script>
</c:if>
<c:if test="${result != 1 }">
	<script>
		alert("글 수정에 실패했습니다.");
		history.go(-1);
	</script>
</c:if>

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>