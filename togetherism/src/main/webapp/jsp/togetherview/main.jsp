<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>홈</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link href="<%=request.getContextPath()%>/css/middle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/center.css" rel="stylesheet" type="text/css" />
<style>
    .center{
      text-align:center;
      align-items:center;
      display: flex;
      justify-content: center;
    }
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap');
@import url("https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700&family=Roboto+Flex:opsz,wght@8..144,600;8..144,900&family=Roboto+Serif:opsz,wght@8..144,600;8..144,700&display=swap");
@import url('https://fonts.googleapis.com/css2?family=Gowun+Batang:wght@400;700&display=swap');
/* body {
  min-height: 100vh;
  display: grid;
  place-content: center;
  text-align: center;
  margin: 0 1.125rem;
  background-color: #f3f4f6;
} */



.statictitle {
  font-weight: 900;
  text-transform: uppercase;
  margin-bottom: 1.5rem;
  font-family: 'Do Hyeon', sans-serif;
}

.movingtitle {
  display: inline-block;
  margin-bottom: 1rem;
  letter-spacing: 2px;
  font-weight: 600;
  white-space: nowrap;
  overflow: hidden;
  width: 0;
  font-family: 'Do Hyeon', sans-serif;
  border-right: 3px solid;
  font-size: clamp(3rem, 6vw + 1rem, 5rem);
  line-height: 1.5;
  animation: type 3s steps(45) 1s forwards infinite, blink 0.5s steps(1) infinite;

}

.title2 {
  font-size: clamp(1rem, 1vw + 1rem, 1.5rem);
  color: #475569;
}

@keyframes type {
  to {
    width: 22ch;
  }
}

@keyframes blink {
  0%,
  100% {
    border-color: transparent;
  }

  50% {
    border-color: black;
  }
}


</style>
<script>
$(document).ready(function(){
	$('#hot').load('<%=request.getContextPath()%>/club_pre_list.do?preview=hot');
	$('#new').load('<%=request.getContextPath()%>/club_pre_list.do?preview=new');
	$('#pre').load('<%=request.getContextPath()%>/club_pre_list.do?preview=pre');
});
</script>
</head>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<body>
<div class="wrapper"><div class="content">
    <div id="all" style="width:1000px;height:3200px;">
    <br><br><br>
    <div class="center">
    <section id="togetherism" class="p-5">
			<p class="movingtitle">누구나, 언제나, 어디서나,</p> <h1 class="statictitle">Togetherism</h1>
			<p class="lead text-center text-black mb-5"></p>
			
			<hr class="order-2 m-0 w-auto" style="color:#C8C8DC; width:80%;"></hr>
			<p class="lead text-center mb-5"></p>
			<div class="lead text-center" text-align="center" id="ourservice">
				TOGETHERISM 은 오프라인 중심 모임 플랫폼 TOGETHERISM입니다. 
				<br> <strong>누구나, 언제나, 어디서나</strong> 모임을 만들고 가입할 수 있습니다.
				<br><br> 지금, 시작해볼까요?
			
			</div>
			<p class="lead text-center text-black mb-5"></p>
    <button onclick="location='<%=request.getContextPath()%>/club_list.do'"
 		class="btn btn-warning center" style="width:400px; height:50px; border-radius:20px;font-size:20px; color:white">지금 시작하기
 	</button>
 	</section>
 	</div>
 	<br><br><br>
    <div style="font-size:30px;">
    <img src="<%=request.getContextPath()%>/images/fire.png" style="width:35px;height:35px;">
    &nbsp;HOT
    </div><br>
      <div id="hot" class="center" style="border:6px solid #ffc107;height:380px;"></div>
     <br><br>
      
        <div style="font-size:30px;">
      <img src="<%=request.getContextPath()%>/images/diamond.png" style="width:35px;height:35px;">
      &nbsp;NEW
      </div><br>
      <div id="new" class="center" style="border:6px solid #ffc107;height:400px;"></div>
    <br><br>  
    <h2>모임 둘러보기</h2><br>
      <div id="pre" style="border:6px solid #ffc107;height:1000px;"></div>
    </div>
</div></div>
</body>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</html>