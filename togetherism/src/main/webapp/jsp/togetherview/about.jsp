<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Togetherism</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
	#ourservice {
		font-color:#5e17eb;
		font-size:medium;
	}
	
	#mail {
		font-size:small;
		text-decoration:none;
		font-color:#000000;
	}
	
</style>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
	<section id="togetherism" class="p-5">
		<div class="container">
			<p class="lead text-center">우리 함께 TOGETHER</p>
			<h2 class="text-center">TOGETHERISM</h2>
			<p class="lead text-center text-black mb-5"></p>
			
			<hr class="order-2 m-0 w-auto" style="color:#C8C8DC; width:80%;"></hr>
			<p class="lead text-center mb-5"></p>
			<div class="lead text-center" text-align="center" id="ourservice">
				우리는 오프라인 중심 모임 플랫폼 <strong> TOGETHERISM </strong>입니다. <br> 
				누구나, 언제나, 어디서나 모임을 만들고 가입할 수 있습니다.<br><br>
				인접 지역을 중심으로 개인이 원하는 모임을 찾아 가입해 활동할 수도 있고,<br>
				직접 모임을 만들어 운영할 수도 있습니다.<br><br>
				지역 카테고리에 속한 모임을 통해 만난 사람들은 친구가 되어 <br>서로의 관심사와 취향을 알아갈 수 있습니다.<br><br>
				친구들은 모임장이 주최하는 이벤트를 통해 취미 생활을 공유할 수도 있고,<br> 다양한 활동을 함께 하며 친밀감을 공유할 수 있습니다.<br>
				<br><br> 지금, 시작해보세요!
			</div>
			<p class="lead text-center text-black mb-5"></p>
			<p class="lead text-center text-black mb-5"></p>
			<p class="lead text-center text-black mb-5"></p>
			
			<div class="row g-4">	
					
				<!-- 자기 소개 시작 -->
				<div class="col-md-6 col-lg-3" style="height:413;">
					<div class="card card-borderless bg-light" style="height:413;">
						<div class="card-body text-center">
							<img src="<%=request.getContextPath()%>/images/sooyoung.png"
								class="rounded-circle mb-3" alt="" /><br>
							<div class="card-title mb-3">
							<h3 class="card-title mb-3">Soo Young Park</h3><div id="mail"><h4><br></h4> </div>
							</div>
							<hr class="order-2 m-0 w-auto" style="color:#C8C8DC; width:80%;"></hr>
							<p class="card-text"></p>
							<div id="mail">
							<a href="mailto:pminj2002@naver.com">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
</svg>
							</a>
							pminj2002@naver.com
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-6 col-lg-3">
					<div class="card bg-light">
						<div class="card-body text-center">
							<img src="<%=request.getContextPath()%>/images/minji.png"
								class="rounded-circle mb-3" alt="" /><br>
							<div class="card-title mb-3">
							<h3 class="card-title mb-3">Min Ji Lee</h3><div id="mail"><h4><br></h4> </div>
							</div>
							<hr class="order-2 m-0 w-auto" style="color:#C8C8DC; width:80%;"></hr>
							<p class="card-text"></p>
							<div id="mail">
							<a href="mailto:skybluebbb@gmail.com">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
</svg>
							</a>
							skybluebbb@gmail.com
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-6 col-lg-3">
					<div class="card bg-light">
						<div class="card-body text-center">
							<img src="<%=request.getContextPath()%>/images/jayoung.png"
								class="rounded-circle mb-3" alt="" /><br>
							<div class="card-title mb-3">
							<h3 class="card-title mb-3">Ja Young Lee</h3><div id="mail"><h4><br></h4> </div>
							</div>
							<hr class="order-2 m-0 w-auto" style="color:#C8C8DC; width:80%;"></hr>
							<p class="card-text"></p>
							<div id="mail">
							<a href="mailto:moonvie831@gmail.com">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
</svg>
							</a>
							moonvie831@gmail.com
						</div>
						</div>
					</div>
				</div>

				<div class="col-md-6 col-lg-3">
					<div class="card bg-light">
						<div class="card-body text-center w-auto">
							<img src="<%=request.getContextPath()%>/images/minyoung.png"
								class="rounded-circle mb-3" alt="" /><br>
							<div class="card-title mb-3">
							<h3>Min Young Cho</h3><div id="mail">(Meadow)</div><br>
							</div>
							<p class="card-text"></p>
							<hr class="order-2 m-0 w-auto" style="color:#C8C8DC; width:80%;"></hr>
							<p class="card-text"></p>
							<div id="mail">
							<a href="mailto:moonvie831@gmail.com">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
  <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z"/>
</svg>						
							</a>
							minyoungcho.ca@gmail.com
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>