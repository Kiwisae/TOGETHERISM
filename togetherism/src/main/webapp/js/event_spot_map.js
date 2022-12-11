
var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = {
	center : new kakao.maps.LatLng(37.53288514135262, 126.99055287202485), // 지도의
	// 중심좌표
	level : 3
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

	// 위경도를 화면에 표시만 하기
	var resultLat = document.getElementById('event_spot_lat0');
	var resultLng = document.getElementById('event_spot_long0');
	resultLat.innerHTML = latlng.getLat();
	resultLng.innerHTML = latlng.getLng();

	var lat_string = latlng.getLat().toString();
	var lng_string = latlng.getLng().toString();

	// 위경도를 hidden 값으로 넘기기
	document.getElementById('event_spot_lat').setAttribute('value',
			latlng.getLat().toString());
	document.getElementById('event_spot_long').setAttribute('value',
			latlng.getLng().toString());
	
	
});