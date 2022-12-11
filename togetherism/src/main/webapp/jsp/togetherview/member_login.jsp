<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<title class="title">Togetherism 로그인하기</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/member_login.css" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<!-- <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.15.0/jquery.validate.min.js"></script>


<script>
function check(){
	if($.trim($("#login_email").val())==""){
		alert("아이디를 입력하세요!");
		$("#login_email").val("").focus();
		return false;
		}	
	if($.trim($("#login_pw").val())==""){
		alert("비밀번호를 입력하세요!");
		$("#login_pw").val("").focus();
		return false;
		}
}

/*비번찾기 공지창*/
function pwd_find(){
	 window.open("pwd_find.do","비번찾기","width=450,height=500");
	 //자바 스크립트에서 window객체의 open("공지창경로와 파일명","공지창이름","공지창속성")
	 //메서드로 새로운 공지창을 만듬.폭이 400,높이가 400인 새로운 공지창을 만듬.단위는 픽셀
}

</script>


</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>



<div class="wrapper">
<br><br>
<h1 align="center" style="font-weight: bold; color: #5e17eb">Togetherism</h1>
<h2 align="center" style="font-weight: bold;">로그인</h2>
<br><br>
	<div class="inner-warpper text-center">
			<form action="<%=request.getContextPath()%>/member_login_ok.do" method="post" onsubmit="return check()">
				<div class="input-group">
					<input type="text" class="form-control" name="login_email" id="login_email" placeholder="이메일주소" /> 
					<span class="lighting"></span>
				</div>
				<div class="input-group">
					<input type="password" class="form-control" name="login_pw" id="login_pw" placeholder="비밀번호" />
					<span class="lighting"></span>
				</div>
				<br>
				
				<button type="submit" id="login" style="background-color: #5e17eb">로그인하기</button>
				
				<div class="clearfix supporter">

					<a class="forgot pull-left" 
					href="<%=request.getContextPath()%>/member_emailfind.do">이메일 찾기</a> 
					<a class="forgot pull-right" 
					href="<%=request.getContextPath()%>/member_pwfind.do">비밀번호 찾기</a>
				</div>
			</form>
			
	</div>
	<div class="signup-wrapper text-center">
		<a href="<%=request.getContextPath()%>/member_signup.do">계정이 없으신가요? <span class="text-primary">회원가입하기</span>
		</a>
	</div>
</div>

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>
