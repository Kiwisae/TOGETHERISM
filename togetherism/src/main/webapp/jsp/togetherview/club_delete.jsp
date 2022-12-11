<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/club_delete_popup.js">

</script>
<title>모임 삭제</title>
</head>
<body>

  <form method="post" action="club_delete.do" >
  <input type="hidden" name="club_num" value="${club_num}"/>
<%-- 삭제할 모임을 확인해주세요 : ${clubdto.club_name} <br> --%>
삭제시 모든 정보가 사라지고 복구할 수 없습니다. <br>
정말 삭제하시겠습니까? <br>
<button type="submit" >네</button>
<a onSubmit="location.href='<%=request.getContextPath()%>/my_club.do';">뒤로가기</a>
</form>
</body>
</html>