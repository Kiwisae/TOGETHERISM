<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link href="<%=request.getContextPath()%>/css/clubmember_list.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/middle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/center.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/hidden_text.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/fullimage.css" rel="stylesheet" type="text/css" />
<script>
function kickout(member_email, club_num){
	if(!confirm("정말 해당 회원을 탈퇴시키시겠습니까?")){
	} else{
		location.href = "<%=request.getContextPath()%>/kick_out.do?member_email=" 
			+ member_email + "&club_num=" + club_num;
	}
}
</script>
<style>
    .host{
      float: left;
    }
    .cover{
    display: flex;
    justify-content: space-between;
    }
</style>
</head>
<body>

<c:if test="${result == 2}">
		<div class="alert alert-warning" role="alert" style="width: 800px;">
 			현재 이 모임에 가입된 회원이 없습니다!
		</div>
</c:if>
<c:if test="${empty result}">

	<c:forEach var="m" items="${cmilist}">    
	
<div style="border:5px solid #ffc107; width:410px; height:110px;margin:20px;border-radius:40px;background-color:white;" class="host center">
  <div class="host" style=" width:100px; height:100px;">
  		<img class="img-circle full" src="<%=request.getContextPath() %>/upload/${m.member_image}" alt="Card image cap">
  </div>
  <div class="host" style=" width:300px; height:100px;">
    <div class="center" style=" width:300px; height:30px;border-bottom:4px dashed #ffc107;">
           <c:if test="${m.club_host_yn eq 'Y'}"><img src="<%=request.getContextPath()%>/images/crown.png" style="width:20px;height:20px" alt="모임장"></c:if>
           ${m.member_nickname}
    </div>
    <div class="hidden center" style=" width:300px; height:45px;">${m.join_hello}</div>
    <div class="center" style=" width:300px; height:25px;">
     <a href="<%=request.getContextPath()%>/report_check.do?member_email=${m.member_email}" style="text-decoration:none;color:black;">신고하기</a>
     <c:if test="${m.club_host_yn eq 'N'}"><a href="javascript:void(0);" onclick="kickout('${m.member_email}',${club_num});" style="text-decoration:none;color:black;">&nbsp;&nbsp;내보내기</a></c:if> 	
    </div>
  </div>

</div>
	</c:forEach>

</c:if>

</body>
</html>