<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<!-- 관리자 로그아웃 --> <script src="./js/manager_logout.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js" integrity="sha512-ElRFoEQdI5Ht6kZvyzXhYG9NqjtkmlkfYk0wr6wHxU9JEHakS7UJZNeml5ALk+8IKlU6jDgMabC3vkumRokgJA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/chartjs-plugin-datalabels/2.0.0-rc.1/chartjs-plugin-datalabels.min.js" integrity="sha512-+UYTD5L/bU1sgAfWA0ELK5RlQ811q8wZIocqI7+K0Lhh8yVdIoAMEs96wJAIbgFvzynPm36ZCXtkydxu1cs27w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<style>
  	#linkstyle{text-decoration:none; color:black;}
	#linkstyle:hover {text-decoration: none; color: #5e17eb; }
	.currentPage {font-style: bold;}
</style>
</head>
<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br><br>
<p>
<!-- 관리자 메뉴 -->

<div class="container">
	<div class="row">
	<div class="col" style="text-align:center; padding:20px;">
		<p><h3>관리자 메인 </h3></p>
	</div>
	<div class="col">
	</div>
	<div class="col" id="sidemenu">
			<button class="btn text-dark" id="logout" style="width:350px; border-color:#fff;">${sessionScope.manager_email }에서 로그아웃</button>
		<br>
		<div class="btn-group">
	  		<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='manager_main.do' ">관리자 메인</button>
	  		<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='manager_list.do' ">회원 관리</button>
	  		<button type="button" class="btn text-white" style="background-color: #5e17eb;" onClick="location.href='notice_list.do' ">공지사항</button>
		</div>
	</div>
	</div>
</div>

</p>

<p class="lead text-center text-black mb-5"></p>
<div align="center">
	<div class="row">
		<div class="col">
		</div>
		<div class="col">
			<!-- 3일간 회원 수 그래프 -->
			<h4>3일간 회원 수</h4> <br>
			<div style="width:400px; height:auto; align:center">
				<canvas id="memberChart">
				</canvas>
			</div>
		</div>
		<div class="col">
			<!-- 신고 당한 회원 랭킹 -->
			<h4>신고 랭킹 TOP 6</h4><br>
			<div style="width:400px; height:auto; align:center">
				<canvas id="reportChart">
				</canvas>
			</div>
		</div>
		<div class="col">
		</div>
	</div>
</div>

<!-- 멤버차트 -->
<script>
  new Chart(document.getElementById("memberChart"), {
    type: 'pie',		//차트 형태
    data: {
      labels: ['2일전', '1일전', '오늘'],	//x축
      datasets: [{ 
			label: "",
			data: [${dago2Total}, ${dago1Total }, ${todayTotal }],
			borderColor: [
				'rgba(153, 102, 255, 1)',
				'rgba(255, 206, 86, 1)',
				'rgba(255, 99, 132, 1)'
			],
			backgroundColor: [
				'rgba(153, 102, 255, 0.2)',
				'rgba(255, 206, 86, 0.2)',
				'rgba(255, 99, 132, 0.2)'
			],
			fill: false,
			borderWidth:1,
			datalabels:{
				color:'black',
				fontSize:15,
			}
          }
      ],
    },	//data end
    options: {
    	legend: {
    		display: false
    	},
        scales: {
            y: {
                max: 10,
                min: 0,
                stepSize: 1
            }
        }
    },
    plugins: [ChartDataLabels],
    	options: {
    		color:'black',
      		anchor: 'end',
      		align: 'end',
      		offset: 10
    	}
});
</script>

<!-- 신고차트 -->
<script>
  new Chart(document.getElementById("reportChart"), {
    type: 'doughnut',		//차트 형태
    data: {
      labels: ['${reportName1 }', '${reportName2 }', '${reportName3 }', '${reportName4 }', '${reportName5 }', '${reportName6 }'],	//x축
      datasets: [
    	 { 
          label: "회원",
          data: [${reportRank1}, ${reportRank2 }, ${reportRank3 }, ${reportRank4}, ${reportRank5}, ${reportRank6}],
          borderColor: [
				'rgba(153, 102, 255, 1)',
				'rgba(255, 206, 86, 1)',
				'rgba(255, 99, 132, 1)',
				'rgba(153, 200, 255, 1)',
				'rgba(237, 160, 199, 1)',
				'rgba(227, 255, 220, 1)'
			],
			backgroundColor: [
				'rgba(153, 102, 255, 0.2)',
				'rgba(255, 206, 86, 0.2)',
				'rgba(255, 99, 132, 0.2)',
				'rgba(153, 200, 255, 0.2)',
				'rgba(237, 160, 199, 0.2)',
				'rgba(227, 255, 220, 0.2)'
			],
          fill: false,
          datalabels:{
				color:'black'
			}
          }
      ]
    },
    options: {
    	
    	responsive: true,
    	legend: false,
		title: {
        display: true,
        text: '신고당한 회원 랭킹',
        fontSize: 25
      }
    },
    plugins: [ChartDataLabels],
	  	options:{
	  		
	  	}
  });
</script>

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>