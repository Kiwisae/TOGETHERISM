<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title class="title">관리자 로그인</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<script>

function check(){
   if($.trim($("#manager_email").val())==""){
      alert("메일 주소를 입력해주세요");
      $("#manager_email").val("").focus();
      return false;
      }   
   if($.trim($("#manager_pw").val())==""){
      alert("비밀번호를 입력해주세요");
      $("#manager_pw").val("").focus();
      return false;
      }
}

</script>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<br><br><br>

<div class="wrapper" align="center">
   <div class="inner-warpper text-center">
      <h2 class="title">TOGETHERISM <br> 관리자 로그인</h2><br>
   </div>
   <br>
   <div align="center">
   <table class="table table-borderless w-auto">
   	<tr>
   		</td>
         <form action="<%=request.getContextPath()%>/manager_login.do" method="post" onSubmit="return check()">
			<input type="email" class="form-control" name="manager_email" id="manager_email" value="together@ism.kr" style="width:400"/> 
			<input type="password" class="form-control" name="manager_pw" id="manager_pw" value="1234" style="width:400"/>
			<br><br><button type="submit" class="btn text-white" style="background-color:#5e17eb;" id="login">로그인</button>
         </form>
        </td>
    </tr>
   </table>
   </div>
</div>

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>