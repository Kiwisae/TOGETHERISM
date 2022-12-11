<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<style>
	#404 {
  		color:black;
  		font-size:large;
  		text-decoration:none;
	}
	
	#404img {
		width: 50%%;
		height: auto;
	}
</style>
</head>
<body>
<br><br><br><br>
<div class="wrapper" align="center">
   <div class="inner-warpper text-center">
      <img src="<%=request.getContextPath()%>/images/logo_square_removebg.png" id="404img">
   </div>
   <br>
   <div align="center">
   <table class="table table-borderless w-auto">
   	<tr>
   		</td><br>
<h6>
페이지를 찾을 수 없습니다<br>
에러가 지속될 경우 관리자 문의 부탁드립니다.<br>
감사합니다.<br>
</h6>         
        </td>
    </tr>
   </table>
   </div>
</div>

<br><br><br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>