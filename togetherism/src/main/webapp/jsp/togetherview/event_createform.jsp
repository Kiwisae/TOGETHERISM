<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 생성 폼</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44a98d8b63fb071cda538e0fedd4970c"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=44a98d8b63fb071cda538e0fedd4970c&libraries=services,clusterer,drawing"></script>
<link href="<%=request.getContextPath()%>/css/middle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/center.css" rel="stylesheet" type="text/css" />
<script>

$(document).ready(function(){
	// 해외지역 모임일땐 맵 지원 불가 안내
	if(${club_region == 'Abroad'}){
		alert("해외 지역은 지도를 지원하지 않음을 유의해주세요");
		$("#event_region_abroad").attr("selected", "selected");
	}
	// 유효성 검사
 	$("#check").click(function(){
		if($("#event_title").val() == ""){
			alert("이벤트 명을 입력해주세요");
			$("#event_title").focus();
			return false;
		}
		if($("#event_title").val().length > 20){
			alert("이벤트 명을 20자 이내로 입력해주세요");
			$("#event_title").focus();
			return false;
		}
		if($("#event_date_date").val() == ""){
			alert("이벤트 날짜를 입력해주세요");
			return false;
		}
		if($("#event_date_time").val() == ""){
			alert("이벤트 시간을 입력해주세요");
			return false;
		}
		if($("#event_region").val() == ""){
			alert("이벤트 지역을 선택해주세요");
			return false;
		}
		if($("#event_info").val() == ""){
			alert("이벤트 설명을 입력해주세요");
			$("#event_info").focus();
			return false;
		}
		if($("#event_info").val().length > 100){
			alert("이벤트 설명을 100자 이내로 입력해주세요");
			$("#event_title").focus();
			return false;
		}
		if($("#event_spot_lat").val() == ""){
			alert("지도를 선택해주세요");
			return false;
		}
		if($("#event_spot_long").val() == ""){
			alert("지도를 선택해주세요");
			return false;
		}
		
	});
});

</script>
<style>
    .host{
      float: left;
    }
</style>
</head>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<body>
<div class="wrapper">
<div class="content">
<br><br><br><br><br>
<c:if test="${result == 2}">
<script>
alert("모임장만 이벤트를 등록할 수 있습니다");
history.go(-1);
</script>
</c:if>
<c:if test="${empty result}">
<h2 style="text-align: center">이벤트 생성</h2><br>
	<form name="event_form"
		action="<%=request.getContextPath()%>/event_create.do" method="post"
		enctype="multipart/form-data">
		<input type="hidden" value="${club_num}" name="club_num">  <!-- Merge 이후 넘어올 값 -->
		<input type="hidden" value="${club_host_email}" name="club_host_email"> <!-- Merge 이후 Controller 에서 구해서 넘어올 값 -->
		<input type="hidden" id="event_spot_lat" name="event_spot_lat" value="">
		<input type="hidden" id="event_spot_long" name="event_spot_long" value="">
			
			<br>
			<div style="width:700px;">
			<div class="host" style="width:200px; height:40px;">
  			<div class= "center" style="border-bottom:4px solid #ffc107; border-right:4px solid #ffc107; width:200px; height:50px;"><b>이벤트 제목</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107; border-right:4px solid #ffc107; width:200px; height:50px;"><b>이벤트 날짜</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107; border-right:4px solid #ffc107; width:200px; height:50px;"><b>이벤트 시간</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107; border-right:4px solid #ffc107; width:200px; height:50px;"><b>이벤트 지역</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107; border-right:4px solid #ffc107; width:200px; height:150px;"><b>이벤트 내용</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107; border-right:4px solid #ffc107; width:200px; height:50px;"><b>첨부파일 및 사진</b></div>
			</div>

			<div class="host" style="width:500px; height:400px;">
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:50px;">
  			<div class="mb-3">
  			<input type="text" class="form-control center" id="event_title" name="event_title" maxlength="20">
			</div>
  			</div>
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:50px;">
  			<input type="date" class="center" id="event_date_date" name="event_date_date" style="width:500px;height:40px;border-radius:8px;">
  			</div>
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:50px;">
  			<input type="time" class="center" id="event_date_time" name="event_date_time" style="width:500px;height:40px;border-radius:8px;">
  			</div>
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:50px;">
  			
  			<select class="form-select center" aria-label="Default select example" name="event_region" id="event_region">
  			<option value="Seoul_Metropolitan" <c:if test="${club_region == 'Seoul_Metropolitan'}">selected
            </c:if>>수도권</option>
			<option value="Gangwon" <c:if test="${club_region == 'Gangwon'}">selected
            </c:if>>강원</option>
			<option value="Gyeongsang" <c:if test="${club_region == 'Gyeongsang'}">selected
            </c:if>>경상</option>
			<option value="Jeolla" <c:if test="${club_region == 'Jeolla'}">selected
            </c:if>>전라</option>
			<option value="Chungcheong" <c:if test="${club_region == 'Chungcheong'}">selected
            </c:if>>충청</option>
			<option value="Jeju" <c:if test="${club_region == 'Jeju'}">selected
            </c:if>>제주</option>
			<option value="Abroad" <c:if test="${club_region == 'Abroad'}">selected
            </c:if>>해외</option>
			</select>

  			</div>
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:150px;">
  			<div class="mb-3">
  			<textarea class="form-control center" name="event_info" id="event_info" style="height:140px;"></textarea>
			</div>
  			</div>
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:50px;">
  			<div class="input-group mb-3">
  			<input type="file" class="form-control center" name="event_file0">
  			<label class="input-group-text" for="inputGroupFile02">Upload</label>
			</div>
  			</div>
			</div>
			<br>
			<p style="text-align:center">장소를 지도에서 선택해주세요</p>
			<div id="map" style="clear:both;background-color:green; width:700px; height:700px;border-bottom:4px solid #ffc107;"></div>
			<div id="clickLatlng"></div>
			<br>
			<br>
			<input type="submit" class="btn btn-warning" id="check" 
			style="width:700px; height:40px; border-radius:20px;" value="이벤트 등록">
			</div>
			

		<!-- 맵 작업 코드 -->
		<script>
			if(${club_region == 'Seoul_Metropolitan'}){
				var lat = 37.569157545384996;
				var lng = 126.9773838190015;
			} else if(${club_region == 'Gangwon'}){
				var lat = 37.76217519573311;
				var lng = 128.29121162346573;
			} else if(${club_region == 'Gyeongsang'}){
				var lat = 35.98436267467598;
				var lng = 128.5326965564436;
			} else if(${club_region == 'Jeolla'}){
				var lat = 35.47254254265923;
				var lng = 127.20293009266267;
			} else if(${club_region == 'Chungcheong'}){
				var lat = 36.62537005034492;
				var lng = 127.46635571810502;
			} else if(${club_region == 'Jeju'}){
				var lat = 33.3868389158458;
				var lng = 126.54999615065364;
			} else if(${club_region == 'Abroad'}){
				var lat = 38.42987403306615;
				var lng = 129.3808605198872;
				
				// 해외인경우 지정된 위치를 저장
				document.getElementById('event_spot_lat').setAttribute('value',
						'38.42987403306615');
				document.getElementById('event_spot_long').setAttribute('value',
						'129.3808605198872');
			}

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
			center : new kakao.maps.LatLng(lat, lng), // 지도의
			// 중심좌표
				level : 9
			// 지도의 확대 레벨
			};

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			// 지도를 클릭한 위치에 표출할 마커입니다
			var marker = new kakao.maps.Marker({
			// 지도 중심좌표에 마커를 생성합니다
			position : map.getCenter()
			});
			// 지도에 마커를 표시합니다
			marker.setMap(map);

			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

			// 클릭한 위도, 경도 정보를 가져옵니다
			var latlng = mouseEvent.latLng;

			// 마커 위치를 클릭한 위치로 옮깁니다
			marker.setPosition(latlng);


			// 위경도를 hidden 값으로 넘기기
			document.getElementById('event_spot_lat').setAttribute('value',
					latlng.getLat().toString());
			document.getElementById('event_spot_long').setAttribute('value',
					latlng.getLng().toString());
	
	
		});
		</script>
		
	</form>

</c:if>
</div>
</div>
</body>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</html>