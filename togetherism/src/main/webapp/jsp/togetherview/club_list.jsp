<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모임 목록</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link href="<%=request.getContextPath()%>/css/hidden_text.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/middle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/center.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/search.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/fullimage.css" rel="stylesheet" type="text/css" />

<script>
$(document).ready(function(){
	$("div[id^='heart1_div']").hide();
	// heart 테이블 검색해서 데이터가 있으면 빨간 하트 띄우기
});
function heart2(club_num){ // 빈 하트 클릭
       var data = {"club_num":club_num}
       $.post("<%=request.getContextPath()%>/insert_heart.do", data, function(result){
    	  if(result == -1){
    		  alert("이미 좋아요한 모임입니다");
    	  } 
		  $("#heart2_div" + club_num).hide();
          $("#heart1_div" + club_num).show();
       });    
}

function heart1(club_num){ // 빨간하트 클릭
         var data = {"club_num":club_num}
           $.post("<%=request.getContextPath()%>/remove_heart.do", data, function(result){
               $("#heart1_div" + club_num).hide();
               $("#heart2_div" + club_num).show();
           });     

}
</script>
<style>
.big{
text-decoration: none;
color: black;
font-size:40px;
margin: 10px;
font-weight: bold;
}
    .host{
      float: left;
    }
    .cover{
    display: flex;
    justify-content: space-between;
    }
</style>
</head>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
<body>
<div class="wrapper">
<div class="content">
<!-- 검색창 -->
<br><br><br>
<form action="<%=request.getContextPath()%>/club_list.do" method="get">
	<input class="search-input" type="text" name="keyword">
	<input class="search-button btn btn-warning" type="submit" value="검색" style="border-radius:20px;">
</form>
<br>
<%-- 검색 결과 페이지 일떄--%>
<c:choose>
<c:when test="${not empty keyword}">
<h5>'${keyword}' 모임 검색 결과</h5>
<div class="cover">
<div style="float: left;">
<a href="<%=request.getContextPath()%>/club_list.do?keyword=${keyword}" class="big">Groups</a>
<a href="<%=request.getContextPath()%>/event_list.do?keyword=${keyword}" class="big" style="color:gray">Events</a>
</div>
<div style="float:right;" class="center">
<button onclick="location='<%=request.getContextPath()%>/club.do'"
 class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">모임만들기</button>
 </div>
 </div>
<br>
</c:when>
<%-- 특정 지역 모임 페이지 일때 --%>
<c:when test="${not empty club_region}">
   <c:choose>
     <c:when test="${club_region == 'Seoul_Metropolitan'}"><h5>수도권 지역 모임</h5></c:when>
     <c:when test="${club_region == 'Gangwon'}"><h5>강원 지역 모임</h5></c:when>
     <c:when test="${club_region == 'Gyeongsang'}"><h5>경상 지역 모임</h5></c:when>
     <c:when test="${club_region == 'Jeolla'}"><h5>전라 지역 모임</h5></c:when>
     <c:when test="${club_region == 'Chungcheong'}"><h5>충청 지역 모임</h5></c:when>
     <c:when test="${club_region == 'Jeju'}"><h5>제주 지역 모임</h5></c:when>
     <c:when test="${club_region == 'Abroad'}"><h5>해외 지역 모임</h5></c:when>
    </c:choose>
<div class="cover">
<div style="float: left;">
<a href="<%=request.getContextPath()%>/club_list.do?club_region=${club_region}" class="big">Groups</a>
<a href="<%=request.getContextPath()%>/event_list.do?event_region=${club_region}" class="big" style="color:gray">Events</a>
</div>
<div style="float:right;" class="center">
<button onclick="location='<%=request.getContextPath()%>/club.do'"
 class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">모임만들기</button>
 </div>
 </div>
<br>
</c:when>	
<%-- 전체 목록의 페이지 일때 --%>
<c:otherwise>
<h5>전체 모임 보기</h5>
<div class="cover">
<div style="float: left;">
<a href="<%=request.getContextPath()%>/club_list.do" class="big">Groups</a>
<a href="<%=request.getContextPath()%>/event_list.do" class="big" style="color:gray">Events</a>
</div>
<div style="float:right;" class="center">
<button onclick="location='<%=request.getContextPath()%>/club.do'"
 class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">모임만들기</button>
 </div>
</div>
<br>
</c:otherwise>
</c:choose>


<!-- 모임이 없을때 처리 -->
<c:if test="${empty clublist}">
 	<c:choose>
	<c:when test="${not empty keyword}">
		<div class="alert alert-warning" role="alert" style="width: 800px;">
 			검색된 모임이 없습니다! <a href="<%=request.getContextPath()%>/club.do" class="alert-link">만들러가기</a>
		</div>
	</c:when>
	<c:when test="${not empty club_region}">
		<div class="alert alert-warning" role="alert" style="width: 800px;">
 			해당 지역에 모임이 없습니다! <a href="<%=request.getContextPath()%>/club.do" class="alert-link">만들러가기</a>
		</div>
	</c:when>
	<c:otherwise>
		<div class="alert alert-warning" role="alert" style="width: 800px;">
 			모임이 없습니다! <a href="<%=request.getContextPath()%>/club.do" class="alert-link">만들러가기</a>
		</div>
	</c:otherwise>
	</c:choose>
</c:if>
<%-- 리스트 출력 --%>
<c:if test="${not empty clublist}">
<c:set var="no1" value="${no}"></c:set><!-- 화면출력번호 -->
<c:forEach var="i" items="${clublist}"> 
<div class="card mb-3 border-warning" style="width: 800px; height:250px;line-height:3;border-width: 2px;">
  <div class="row no-gutters">
    <div class="col-md-4">
    <a href="<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}"> 
    <img src="<%=request.getContextPath() %>/upload/${i.club_image}" class="card-img full" style="width:100%; height:245px" alt="${i.club_image}"/>
    </a>
    </div>
    <div class="col-md-8">
      <div class="card-body" style="height:250px;">
      <div class="cover center" style="height:50px;">
      <div style="float:left;">
        <h5 class="card-title hidden"><a href="<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}" style="text-decoration:none;">${i.club_name}</a></h5>
   	  </div>
   	  <div style="float:right;">
        <p class="card-text hidden">
	   	   <div id="heart1_div${i.club_num}"> <%--꽉찬하트 --%>
      		<button id="heart1${i.club_num}" onclick="heart1(${i.club_num});" class="heart_button_fill" type="button" style="border:0; background-color:transparent;">
      		<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart-fill" style="color:red;" viewBox="0 0 16 16">
  			<path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
			</svg></button>
   			</div>

   			<div id="heart2_div${i.club_num}">
      		<button id="heart2${i.club_num}" onclick="heart2(${i.club_num});" class="heart_button_cancel" type="button" style="border:0; background-color:transparent;">
      		<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
  			<path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
			</svg></button>
   			</div>
		</p>
	 </div>
		</div>
		
        <p class="card-text hidden">${i.club_info}</p>
        <p class="card-text">
        <c:choose>
        	<c:when test="${i.club_region == 'Seoul_Metropolitan'}">수도권</c:when>
        	<c:when test="${i.club_region == 'Gangwon'}">강원</c:when>
        	<c:when test="${i.club_region == 'Gyeongsang'}">경상</c:when>
        	<c:when test="${i.club_region == 'Jeolla'}">전라</c:when>
        	<c:when test="${i.club_region == 'Chungcheong'}">충청</c:when>
        	<c:when test="${i.club_region == 'Jeju'}">제주</c:when>
        	<c:when test="${i.club_region == 'Abroad'}">해외</c:when>
        </c:choose>
        </p>
        
        <!-- <p class="card-text"><small class="text-muted">${i.club_reg_date}</small></p>  -->
         <div class="cover">
        <div style="float:left;">
		<p class="card-text">${i.club_member_count} 명 / ${i.club_member_limit} 명</p></div>
       	<div style="float:right;">
		<button onclick="location='<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}'"
 		class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">자세히 보기</button>
       	</div>
       	</div>
       	
        </div>
      </div>
    </div>
  </div>

<c:set var="no1" value="${no1 - 1}"/>
</c:forEach>
</c:if>

<%-- 페이징 처리 시작--%>
<nav class="center" aria-label="Page navigation example">
  <ul class="pagination">
<%-- 검색 결과 페이지  페이징 처리 --%>
<c:choose>
<c:when test="${not empty keyword}">
	<c:if test="${pp.startPage > pp.pagePerBlk}"> <%-- 첫 페이지가 아닐 때 이전버튼 출력 --%>
	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${pp.startPage - 1}&keyword=${keyword}">Previous</a></li>
	</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<c:if test="${pp.page == i}">
			<li class="page-item active" aria-current="page"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${i}&keyword=${keyword}">${i}</a></li>
			</c:if>
			<c:if test="${pp.page != i}">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${i}&keyword=${keyword}">${i}</a></li>
			</c:if>
		</c:forEach>
	<c:if test="${pp.endPage < pp.totalPage}"> <%-- 끝 페이지가 아닐때 다음버튼 출력 --%>
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${pp.endPage + 1}&keyword=${keyword}">Next</a></li>
	</c:if>
</c:when>
<%-- 특정 지역 클릭시 이벤트 페이지 페이징 처리 --%>
<c:when test="${not empty club_region}">
	<c:if test="${pp.startPage > pp.pagePerBlk}"> <%-- 첫 페이지가 아닐 때 이전버튼 출력 --%>
	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${pp.startPage - 1}&club_region=${club_region}">Previous</a></li>
	</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<c:if test="${pp.page == i}">
			<li class="page-item active" aria-current="page"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${i}&club_region=${club_region}">${i}</a></li>
			</c:if>
			<c:if test="${pp.page != i}">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${i}&club_region=${club_region}">${i}</a></li>
			</c:if>
		</c:forEach>
	<c:if test="${pp.endPage < pp.totalPage}"> <%-- 끝 페이지가 아닐때 다음버튼 출력 --%>
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${pp.endPage + 1}&club_region=${club_region}">Next</a></li>
	</c:if>
</c:when>		
<%-- 전체 목록의 페이징 처리 --%>
<c:otherwise>
	<c:if test="${pp.startPage > pp.pagePerBlk }">
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${pp.startPage - 1}">Previous</a></li>
	</c:if>
	<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
		<c:if test="${pp.page == i}">
		<li class="page-item active" aria-current="page"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${i}">${i}</a></li>
		</c:if>
		<c:if test="${pp.page != i}">
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${i}">${i}</a></li>
		</c:if>
	</c:forEach>
		<c:if test="${pp.endPage < pp.totalPage}">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/club_list.do?clubPage=${pp.endPage + 1}">Next</a></li>
		</c:if>
</c:otherwise>
</c:choose>
</ul>
</nav>
</div></div>
</body>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</html>