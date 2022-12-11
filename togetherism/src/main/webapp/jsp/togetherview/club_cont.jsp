<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 페이지</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link href="<%=request.getContextPath()%>/css/club_cont.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/middle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/center.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/fullimage.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/fontj.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/border.css" rel="stylesheet" type="text/css" />

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44a98d8b63fb071cda538e0fedd4970c"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44a98d8b63fb071cda538e0fedd4970c&libraries=services,clusterer,drawing"></script>

<script>
$(document).ready(function(){
 //버튼 클릭시 ajax 실행  
	console.log("ajax 불림");

 	$("#photoPaging").hide();
 	if(${club.club_region == 'Abroad'}){
		$(".hide").hide();
 	} else if(${empty eventlist}){
 		$(".hide").hide();
 	}
 
	// 모임내 이벤트 리스트
	$("#event_list").click(function(){
		$('#container').load('<%=request.getContextPath()%>/event_list.do?club_num=${club.club_num}&preview=Y'); // 나중엔 모임번호는 리스트에서 넘어옴, 지금은 임의로 2 로 설정
		$(".hide").hide();
		$("#photoPaging").hide();
	});
	
	// 가입된 회원
	$("#join_member").click(function(){
		$('#container').load('<%=request.getContextPath()%>/club_member.do?club_num=${club.club_num}'); // 나중엔 모임번호는 리스트에서 넘어옴, 지금은 임의로 22 로 설정
		$(".hide").hide();
		$("#photoPaging").hide();
	});
	// 모임 상세 정보
	$("#club_info").click(function(){
		location.href="<%=request.getContextPath()%>/club_ct.do?club_num=${club.club_num}";
	});
	
	// 사진첩
	$("#photo_board").click(function(){
		$('#container').load('<%=request.getContextPath()%>/photo_list.do?club_num=${club.club_num}');
		$('#map').hide();
		$(".hide").hide();
		$("#photoPaging").show();
	});
	
});
function pPage(startRow, endRow, club_num){
	$('#map').hide();
	$(".hide").hide();
	$("#photoPaging").show();
	$('#container').load("<%=request.getContextPath()%>/photo_list.do?club_num=" + club_num + "&startRow=" + startRow + "&endRow=" + endRow);
}

function copy_to_clipboard() {    
	  var copyText = document.getElementById('kakao');
	  copyText.select();
	  copyText.setSelectionRange(0, 99999);
	  document.execCommand("Copy");
	  alert('복사되었습니다');
	}

</script>
<style>
    .host{
      float: left;
    }

</style>
</head>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<body>


<c:if test="${empty club}">
<div class="alert alert-warning" role="alert" style="width: 800px;">
 	없거나 삭제된 모임입니다
</div>
</c:if>

<c:if test="${not empty club}">
<div class="wrapper">
<div class="content">
<br>
 <div class="center yellow-border" style="height:300px;background-color:white;">
    <div class="host" style="width:500px; height:270px;">
    	<img class="full" src="<%=request.getContextPath()%>/upload/${club.club_image}" alt="${club.club_image}"/>
    </div>
    <div class="host" style="width:500px; height:270px;">
      <div class="center" style="width:500px;height:80px;font-size:30px;font-weight:bold;">${club.club_name}</div>
      
      <div class="beige-full" style="width:500px; height:100px;border:4px dashed #ffc107;border-radius: 40px;">
        <div class="host" style="width:90px; height:90px;">
			<img class="img-circle full" src="<%=request.getContextPath() %>/upload/${memberdto.member_image}" alt="${memberdto.member_image}"/>
		</div>
        <div class="host" style="width:400px; height:90px;">
        <div class="center" style="height:50px;"><img src="<%=request.getContextPath()%>/images/crown.png" style="width:20px;height:20px" alt="모임장">&nbsp; ${memberdto.member_nickname}</div>
        <div class="center" style="height:40px;">${club.club_keyword}</div>
        </div>

      </div>
      <div class="center" style="width:500px; height:90px;">
		<button type="button" class="btn btn-warning center" 
		style="width:400px;height:50px;border-radius:20px;font-size:30px;font-weight:bold;color:white"
		 data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">JOIN NOW</button>
	  </div>
    </div>
</div>
<br>
<hr width="900px">

<div>
  <div style="background-color:blue; width=450px; height=80px;"></div>
  <div>
    <div class="host center" style="width:100px;height:80px;"><h4>모임정보</h4></div>
    <div class="host" style=" width:200px; height:80px;">
      <div class="center" style="width:200px; height:40px;"><b>지역</b></div>
      <div class="center" style="width:200px; height:40px;">
      <c:choose>
        	<c:when test="${club.club_region == 'Seoul_Metropolitan'}">수도권</c:when>
        	<c:when test="${club.club_region == 'Gangwon'}">강원</c:when>
        	<c:when test="${club.club_region == 'Gyeongsang'}">경상</c:when>
        	<c:when test="${club.club_region == 'Jeolla'}">전라</c:when>
        	<c:when test="${club.club_region == 'Chungcheong'}">충청</c:when>
        	<c:when test="${club.club_region == 'Jeju'}">제주</c:when>
        	<c:when test="${club.club_region == 'Abroad'}">해외</c:when>
        </c:choose>
      </div>
    </div>
    <div class="host" style="width:200px; height:80px;">
      <div class="center" style="width:200px; height:40px;"><b>관심사</b></div>
      <div class="center" style=" width:200px; height:40px;">${club.club_interest}</div>
    </div>
    <div class="host" style=" width:200px; height:80px;">
      <div class="center" style=" width:200px; height:40px;"><b>정원</b></div>
      <div class="center" style=" width:200px; height:40px;">${club.club_member_limit}</div>
    </div>
    <div class="host" style="width:200px; height:80px;">
      <div class="center" style=" width:200px; height:40px;"><b>가입자수</b></div>
      <div class="center" style=" width:200px; height:40px;">${club.club_member_count}</div>
    </div>
    <div class="host" style=" width:100px; height:80px;">
    <button onclick="copy_to_clipboard()" style="background-color: transparent;border:0"><svg xmlns="http://www.w3.org/2000/svg" width="100" height="50" fill="currentColor" class="bi bi-chat-dots-fill" viewBox="0 0 16 16">
 		<path d="M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM5 8a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
		</svg></button>
		<p class="box01">
        <input id="kakao" value="${club.club_chat}" readonly>
    	</p>    
    </div>

  </div>
</div>

<br><br><br>
<hr width="900px">
<br>
<button type="button" class="btn btn-warning" id="club_info" style="width:250px; height:40px; border-radius:20px;">상세정보</button>
<button type="button" class="btn btn-warning" id="event_list" style="width:250px; height:40px;border-radius:20px;">이벤트(정모)</button>
<button type="button" class="btn btn-warning" id="join_member" style="width:250px; height:40px; border-radius:20px;">가입된 회원</button>
<button type="button" class="btn btn-warning" id="photo_board" style="width:250px; height:40px; border-radius:20px;">사진첩</button>


<form action="<%=request.getContextPath()%>/club_join.do" method="get">
<input type="hidden" name="club_num" value="${club.club_num}"> <!-- 임의로 22로지정 -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">모임 가입하기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3"> <!-- 이후 유효성검사 -->
            <label for="recipient-name" class="col-form-label">가입인사:</label>
            <input type="text" class="form-control" name="join_hello" id="join_hello" required="required" maxlength="10">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
        <button type="submit" class="btn btn-primary" id="joinclick">가입하기</button>
      </div>
    </div>
  </div>
</div>
</form>

<br>
<div id="container" style="width:1000px; padding:10px; margin:auto;word-break:break-all;">${clubInfobr}</div>


<div style="width:1000px; padding:10px;">
<h4 class="hide"><hr>이벤트 장소</h4>

<!-- 맵이 표시될 위치 -->
<div id="map" class="hide" style="width: 500px; height: 400px;"></div>
</div>

<c:if test="${empty eventlist}">
<div class="alert alert-warning hide" role="alert" style="width: 800px;">
 	현재 이 모임에 등록된 이벤트(정모)가 없습니다
</div>
</c:if>
<!-- 맵 작업 코드 -->
<script>

<c:if test="${not empty eventlist}">
var count = 0;
var sum_event_spot_lat = 0
var sum_event_spot_long = 0
<c:forEach items="${eventlist}" var="event">
var sum_event_spot_lat = sum_event_spot_lat + ${event.event_spot_lat};
var sum_event_spot_long = sum_event_spot_long + ${event.event_spot_long};
var count = count + 1;
</c:forEach>
var avg_event_spot_lat = sum_event_spot_lat / count;
var avg_event_spot_long = sum_event_spot_long / count;
console.log(avg_event_spot_lat);
console.log(avg_event_spot_long);
</c:if>
<c:if test="${empty eventlist}">
var avg_event_spot_lat = 38.439801;
var avg_event_spot_long = 127.127730;
</c:if>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
		
    center: new kakao.maps.LatLng(avg_event_spot_lat, avg_event_spot_long), // 지도의 중심좌표
    level: 9 // 지도의 확대 레벨
	
	
};

//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

//마커를 표시할 위치와 title 객체 배열입니다 
var positions = [
	<c:forEach items="${eventlist}" var="event">
    {
        title: '${event.event_title}', 
        latlng: new kakao.maps.LatLng(${event.event_spot_lat}, ${event.event_spot_long})
    },
    </c:forEach>
];

//마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
}
</script>

</c:if>

<!-- 사진첩 ajax 페이지네이션 -->
<nav class="center" aria-label="Page navigation example" id="photoPaging">
  <ul class="pagination">
  	
<c:forEach var="v" begin="1" end="${pt}">
<li class="page-item"><a href="javascript:void(0);" class="page-link" onclick="pPage(${3*(v-1) + 1}, ${v* 3} ,${club.club_num});">${v}</a></li>
</c:forEach>
  </ul>
</nav>

</div>
</div>

</body>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</html>