<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 수정 폼</title>
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
	// 유효성 검사
 	$("#check").click(function(){
		if($("#event_region").val() == ""){
			alert("이벤트 지역을 선택해주세요");
			return false;
		}
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
		if($("event_spot_lat").val() == ""){
			alert("지도를 설정해주세요");
			return false;
		}
		if($("event_spot_long").val() == ""){
			alert("지도를 설정해주세요");
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
alert("모임장만 수정 가능합니다");
history.go(-1);
</script>
</c:if>
<c:if test="${empty result}">
	<form name="event_form"
		action="<%=request.getContextPath()%>/event_edit.do" method="post"
		enctype="multipart/form-data">
		<input type="hidden" value="${event.club_num}" name="club_num">
		<input type="hidden" value="${event.event_num}" name="event_num">
		<input type="hidden" value="${eventPage}" name="eventPage">
		<input type="hidden" value="${event.club_host_email}" name="club_host_email"> <!-- Merge 이후 넘어올 값 -->
		<input type="hidden" id="event_spot_lat" name="event_spot_lat" value="${event.event_spot_lat}">
		<input type="hidden" id="event_spot_long" name="event_spot_long" value="${event.event_spot_long}">


			<h2 style="text-align: center">이벤트 수정</h2><br>
			<div style="width:700px;">
			<div class="host" style=" width:200px; height:40px;">
  			<div class= "center" style="border-bottom:4px solid #ffc107;border-right:4px solid #ffc107; width:200px; height:50px;"><b>이벤트 제목</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107;border-right:4px solid #ffc107; width:200px; height:50px;"><b>이벤트 날짜</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107;border-right:4px solid #ffc107; width:200px; height:50px;"><b>이벤트 시간</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107;border-right:4px solid #ffc107; width:200px; height:50px;"><b>이벤트 지역</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107;border-right:4px solid #ffc107; width:200px; height:150px;"><b>이벤트 내용</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107;border-right:4px solid #ffc107; width:200px; height:200px;"><b>첨부파일 및 사진 확인</b></div>
  			<div class= "center" style="border-bottom:4px solid #ffc107;border-right:4px solid #ffc107; width:200px; height:100px;"><b>첨부파일 및 사진 수정</b></div>
			</div>

			<div class="host" style="width:500px;">
  			<div style="width:500px; height:50px;border-bottom:4px solid #ffc107;">
  			<div class="mb-3">
  			<input type="text" class="form-control center" name="event_title" id="event_title" value="${event.event_title}">
  
			</div>
  			</div>

  			<div style="border-bottom:4px solid #ffc107; width:500px; height:50px;">
  			<input type="date" class="center" id="event_date_date" 
  			value="<fmt:formatDate value="${event.event_date}" pattern="YYYY-MM-dd"/>"
  			name="event_date_date" style="width:500px;height:40px;border-radius:8px;">
  			</div>
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:50px;">
  			<input type="time" class="center" id="event_date_time" 
  			value="<fmt:formatDate value="${event.event_date}" pattern="HH:mm"/>"
  			name="event_date_time" style="width:500px;height:40px;border-radius:8px;">
  			</div>
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:50px;">
			
  			<select class="form-select center" aria-label="Default select example" name="event_region" id="event_region">
			<option value="Seoul_Metropolitan" <c:if test="${event.event_region == 'Seoul_Metropolitan'}">selected
            </c:if>>수도권</option>
			<option value="Gangwon" <c:if test="${event.event_region == 'Gangwon'}">selected
            </c:if>>강원</option>
			<option value="Gyeongsang" <c:if test="${event.event_region == 'Gyeongsang'}">selected
            </c:if>>경상</option>
			<option value="Jeolla" <c:if test="${event.event_region == 'Jeolla'}">selected
            </c:if>>전라</option>
			<option value="Chungcheong" <c:if test="${event.event_region == 'Chungcheong'}">selected
            </c:if>>충청</option>
			<option value="Jeju" <c:if test="${event.event_region == 'Jeju'}">selected
            </c:if>>제주</option>
			<option value="Abroad" <c:if test="${event.event_region == 'Abroad'}">selected
            </c:if>>해외</option>
			</select>
			

  			</div>
  			<div style="border-bottom:4px solid #ffc107; width:500px; height:150px;">
  			<div class="mb-3">
  			<textarea class="form-control center" name="event_info" id="event_info" style="height:140px;">${event.event_info}</textarea>
			</div>
  			</div>
				
  			<div class="center" style="border-bottom:4px solid #ffc107; width:500px; height:200px;">

				<c:if test="${not empty event.event_file}">
    			<c:set var="filename" value="${event.event_file}" />
				<c:set var="fileNm" value="${fn:toLowerCase(filename)}" />
				<c:forTokens var="token" items="${fileNm}" delims="."
    				varStatus="status">
    				<c:if test="${status.last }">
        				<c:choose>
            				<c:when test="${token eq 'jpg' }">
            					<img src="<%=request.getContextPath() %>/upload/${event.event_file}" style="height:200px; weight:200px;" alt="${event.event_file}"/>
            				</c:when>
            				<c:when test="${token eq 'png'}">
            						<img src="<%=request.getContextPath() %>/upload/${event.event_file}" style="height:200px; weight:200px;"alt="${event.event_file}"/>
            				</c:when>
            				<c:when test="${token eq 'gif'}">
            						<img src="<%=request.getContextPath() %>/upload/${event.event_file}" style="height:200px; weight:200px;" alt="${event.event_file}"/>
            				</c:when>
            				<c:otherwise><%-- 첨부파일이 사진이 아닐떄 --%>
            					<a href="<%=request.getContextPath()%>/file_down.do?file_name=${event.event_file}">${event.event_file}</a>
            				</c:otherwise>
        				</c:choose>
        			</c:if>
				</c:forTokens>
				</c:if>
		<c:if test="${empty event.event_file}"> <%-- 첨부파일이 없을때 --%>
			<div class="alert alert-warning center" role="alert" style="width: 500px;height:150px;">
 				첨부파일이 없습니다
			</div>
		</c:if>
			
  			</div>
  		<div class="center" style="border-bottom:4px solid #ffc107; width:500px; height:100px;">
  			<div class="input-group mb-3">
				<input type="file" name="event_file0" class="form-control center">
				<label class="input-group-text" for="inputGroupFile02">Upload</label>
				</div>
  		</div>
			</div>
			<br>
			<p style="text-align:center">장소를 지도에서 선택해주세요</p>
			<!-- 맵이 표시될 위치 -->
			<div id="map" style="clear:both;width:700px; height:700px;border-bottom:4px solid #ffc107;"></div>
			<div id="clickLatlng"></div>
			<br>
			<br>
			<input type="submit" class="btn btn-warning" id="check" 
			style="width:700px; height:40px; border-radius:20px;" value="수정">
			</div>


		
		<!-- 맵 작업 코드 -->
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(${event.event_spot_lat}, ${event.event_spot_long}), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};

//지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

//지도를 클릭한 위치에 표출할 마커입니다
var marker = new kakao.maps.Marker({
// 지도 중심좌표에 마커를 생성합니다
position : map.getCenter()
});
//지도에 마커를 표시합니다
marker.setMap(map);

//지도에 클릭 이벤트를 등록합니다
//지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
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
</div></div>
</body>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</html>