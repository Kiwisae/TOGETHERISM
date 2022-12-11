<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 목록</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link href="<%=request.getContextPath()%>/css/hidden_text.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/middle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/center.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/search.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/fullimage.css" rel="stylesheet" type="text/css" />
<style>
.big{
text-decoration: none;
color: black;
font-size:40px;
margin: 10px;
font-weight: bold;
}
    .cover{
    display: flex;
    justify-content: space-between;
    }
</style>
</head>
<c:if test="${club_num == 0}">
<br><br><br><br><br>
<jsp:include page="../include/header.jsp"></jsp:include>
</c:if>
<c:if test="${club_num != 0 && empty preview}">
<br><br><br><br><br>
<jsp:include page="../include/header.jsp"></jsp:include>
</c:if>
<body>
<div class="wrapper">
<div class="content">
<c:if test="${club_num == 0}"> <!-- 모임 내에서 이벤트를 볼때는 검색창 없음 -->
<br><br><br>
	<form action="<%=request.getContextPath()%>/event_list.do" method="get">
		<input class="search-input" type="text" name="keyword">
		<input class="search-button btn btn-warning" type="submit" value="검색" style="border-radius:20px;">
	</form>
	<br>
	
	<%-- 검색 결과 페이지 일떄--%>
	<c:choose>
	<c:when test="${not empty keyword}">
	<h5>'${keyword}' 이벤트 검색 결과</h5>
	<a href="<%=request.getContextPath()%>/club_list.do?keyword=${keyword}" class="big" style="color:gray">Groups</a>
	<a href="<%=request.getContextPath()%>/event_list.do?keyword=${keyword}" class="big">Events</a>
	<br><br>
	</c:when>
	<%-- 특정 지역 모임 페이지 일때 --%>
	<c:when test="${not empty event_region}">
   	<c:choose>
     	<c:when test="${event_region == 'Seoul_Metropolitan'}"><h5>수도권 지역 이벤트</h5></c:when>
     	<c:when test="${event_region == 'Gangwon'}"><h5>강원 지역 이벤트</h5></c:when>
     	<c:when test="${event_region == 'Gyeongsang'}"><h5>경상 지역 이벤트</h5></c:when>
     	<c:when test="${event_region == 'Jeolla'}"><h5>전라 지역 이벤트</h5></c:when>
     	<c:when test="${event_region == 'Chungcheong'}"><h5>충청 지역 이벤트</h5></c:when>
     	<c:when test="${event_region == 'Jeju'}"><h5>제주 지역 이벤트</h5></c:when>
     	<c:when test="${event_region == 'Abroad'}"><h5>해외 지역 이벤트</h5></c:when>
    	</c:choose>
	<a href="<%=request.getContextPath()%>/club_list.do?club_region=${event_region}" class="big" style="color:gray">Groups</a>
	<a href="<%=request.getContextPath()%>/event_list.do?event_region=${club_region}" class="big">Events</a>
	<br><br>
	</c:when>	
	<%-- 전체 목록의 페이지 일때 --%>
	<c:otherwise>
	<h5>전체 이벤트 보기</h5>
	<a href="<%=request.getContextPath()%>/club_list.do" class="big" style="color:gray">Groups</a>
	<a href="<%=request.getContextPath()%>/event_list.do" class="big">Events</a>
	<br><br>
	</c:otherwise>
	</c:choose> 
	</c:if>
	
<c:if test="${club_num != 0}"> <!-- 모임 페이지 내에서 모임내 이벤트를 볼때 -->

	<c:if test="${not empty preview}"> <!--  모임 내에서 이벤트를 볼때 preview 상태면 더보기 출력 -->
		<button onclick="location='<%=request.getContextPath()%>/event_createform.do?club_num=${club_num}'"
 		class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">이벤트 생성하기</button>
		
		<button onclick="location='<%=request.getContextPath()%>/event_list.do?club_num=${club_num}'"
 		class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">더보기</button>
	</c:if>
	<c:if test="${empty preview}"> <!--  모임 내에서 이벤트를 볼때 preview 상태가 아니면 모임으로 돌아가기 출력-->
	<br><br>
	<div class="cover">
	<button onclick="location='<%=request.getContextPath()%>/event_createform.do?club_num=${club_num}'"
 	class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">이벤트 생성하기</button>
		
	<button onclick="location='<%=request.getContextPath()%>/club_ct.do?club_num=${club_num}'"
 		class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">해당 모임으로 돌아가기</button>
	</div>
	</c:if>
	<br><br>
	<h5>이 모임의 이벤트(정모)</h5>
	<br>
</c:if>

<!-- 이벤트가 없을때 처리 -->
<c:if test="${empty eventlist}">
 	<c:choose>
	<c:when test="${club_num != 0}">
		<div class="alert alert-warning" role="alert" style="width: 800px;">
 			현재 이 모임에 생성된 이벤트가 없습니다!
		</div>
	</c:when>
	<c:when test="${not empty keyword}">
		<div class="alert alert-warning" role="alert" style="width: 800px;">
 			검색된 이벤트가 없습니다!
		</div>
	</c:when>
	<c:when test="${not empty event_region}">
		<div class="alert alert-warning" role="alert" style="width: 800px;">
 			해당 지역에 이벤트가 없습니다!
		</div>
	</c:when>
	<c:otherwise>
		<div class="alert alert-warning" role="alert" style="width: 800px;">
 			이벤트가 없습니다!
		</div>
	</c:otherwise>
	</c:choose>
</c:if>

<%-- 리스트 출력 --%>
<c:if test="${not empty eventlist}">
<c:set var="no1" value="${no}"></c:set><!-- 화면출력번호 -->
<c:forEach var="i" items="${eventlist}"> 
<div class="card mb-3 border-warning" style="width: 800px; height: 250px;line-height:3;border-width: 2px;">
  <div class="row no-gutters">
    <div class="col-md-4"><!-- 파일 확장자가 jpg,png같은걸로 끝나면 사진 표시, 아니면 기본사진 표시 -->
    <c:if test="${not empty i.event_file}">
    	<c:set var="filename" value="${i.event_file}" />
		<c:set var="fileNm" value="${fn:toLowerCase(filename)}" />
		<c:forTokens var="token" items="${fileNm}" delims="."
    		varStatus="status">
    		<c:if test="${status.last }">
        		<c:choose>
            		<c:when test="${token eq 'jpg' }">
            			<a href="<%=request.getContextPath()%>/event_cont.do?club_num=${club_num}&event_num=${i.event_num}&eventPage=${eventPage}&state=cont"> 
            			<img src="<%=request.getContextPath() %>/upload/${i.event_file}" class="card-img full"  style="width:100%; height:245px" alt="${i.event_file}"/>
            			</a>
            		</c:when>
            		<c:when test="${token eq 'png'}">
            		    <a href="<%=request.getContextPath()%>/event_cont.do?club_num=${club_num}&event_num=${i.event_num}&eventPage=${eventPage}&state=cont"> 
            			<img src="<%=request.getContextPath() %>/upload/${i.event_file}" class="card-img full"  style="width:100%; height:245px" alt="${i.event_file}"/>
            			</a>
            		</c:when>
            		<c:when test="${token eq 'gif'}">
            		    <a href="<%=request.getContextPath()%>/event_cont.do?club_num=${club_num}&event_num=${i.event_num}&eventPage=${eventPage}&state=cont"> 
            			<img src="<%=request.getContextPath() %>/upload/${i.event_file}" class="card-img full"  style="width:100%; height:245px" alt="${i.event_file}"/>
            			</a>
            		</c:when>
            		<c:otherwise>
            		    <a href="<%=request.getContextPath()%>/event_cont.do?club_num=${club_num}&event_num=${i.event_num}&eventPage=${eventPage}&state=cont"> 	
            			<img src="<%=request.getContextPath()%>/images/logo_square.png" class="card-img full"  style="width:100%; height:245px" alt="defalutimage">
            			</a>
            		</c:otherwise>
        		</c:choose>
        	</c:if>
		</c:forTokens>
	</c:if>
	<c:if test="${empty i.event_file}">
	    <a href="<%=request.getContextPath()%>/event_cont.do?club_num=${club_num}&event_num=${i.event_num}&eventPage=${eventPage}&state=cont">
		<img src="<%=request.getContextPath()%>/images/logo_square.png" class="card-img"  style="width:100%; height:245px" alt="defalutimage">
		</a>
	</c:if>

    </div>
    <div class="col-md-8">
      <div class="card-body">
      	<div class="cover center" style="height:50px;">
        <h5 class="card-title hidden" style="float:left;"><a href="<%=request.getContextPath()%>/event_cont.do?club_num=${club_num}&event_num=${i.event_num}&eventPage=${eventPage}&state=cont" style="text-decoration: none">${i.event_title}</a></h5>
        </div>
        <p class="card-text hidden">${i.event_info}</p>
        <p class="card-text">
        <c:choose>
        	<c:when test="${i.event_region == 'Seoul_Metropolitan'}">수도권</c:when>
        	<c:when test="${i.event_region == 'Gangwon'}">강원</c:when>
        	<c:when test="${i.event_region == 'Gyeongsang'}">경상</c:when>
        	<c:when test="${i.event_region == 'Jeolla'}">전라</c:when>
        	<c:when test="${i.event_region == 'Chungcheong'}">충청</c:when>
        	<c:when test="${i.event_region == 'Jeju'}">제주</c:when>
        	<c:when test="${i.event_region == 'Abroad'}">해외</c:when>
        </c:choose>

        </p>
        <div class="cover">
        <div style="float:left;">
        <p class="card-text"><fmt:formatDate value="${i.event_date}" pattern="yy년  MM월  dd일  a hh:mm"/></p>
       	</div>
       	<div style="float:right;">
    <c:if test="${club_num == 0}">
		<button onclick="location='<%=request.getContextPath()%>/event_cont.do?club_num=${club_num}&event_num=${i.event_num}&eventPage=${eventPage}&state=cont'"
 		class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">자세히 보기</button>
	</c:if>
       	</div>
       	</div>
        <!-- <p class="card-text"><small class="text-muted">${i.event_date}</small></p>  -->
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
	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${pp.startPage - 1}&keyword=${keyword}">Previous</a></li>
	</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<c:if test="${pp.page == i}">
			<li class="page-item active" aria-current="page"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${i}&keyword=${keyword}">${i}</a></li>
			</c:if>
			<c:if test="${pp.page != i}">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${i}&keyword=${keyword}">${i}</a></li>
			</c:if>
		</c:forEach>
	<c:if test="${pp.endPage < pp.totalPage}"> <%-- 끝 페이지가 아닐때 다음버튼 출력 --%>
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${pp.endPage + 1}&keyword=${keyword}">Next</a></li>
	</c:if>
</c:when>
<%-- 특정 모임의 이벤트 페이지 페이징 처리 --%>
<c:when test="${club_num != 0}">
	<c:if test="${empty preview}"> <%-- 프리뷰가 아닐때만 페이징 처리 --%>
	<c:if test="${pp.startPage > pp.pagePerBlk}"> <%-- 첫 페이지가 아닐 때 이전버튼 출력 --%>
	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${pp.startPage - 1}&club_num=${club_num}">Previous</a></li>
	</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<c:if test="${pp.page == i}">
			<li class="page-item active" aria-current="page"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${i}&club_num=${club_num}">${i}</a></li>
			</c:if>
			<c:if test="${pp.page != i}">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${i}&club_num=${club_num}">${i}</a></li>
			</c:if>
		</c:forEach>
	<c:if test="${pp.endPage < pp.totalPage}"> <%-- 끝 페이지가 아닐때 다음버튼 출력 --%>
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${pp.endPage + 1}&club_num=${club_num}">Next</a></li>
	</c:if>
	</c:if>
</c:when>
<%-- 특정 지역 클릭시 이벤트 페이지 페이징 처리 --%>
<c:when test="${not empty event_region}">
	<c:if test="${pp.startPage > pp.pagePerBlk}"> <%-- 첫 페이지가 아닐 때 이전버튼 출력 --%>
	<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${pp.startPage - 1}&event_region=${event_region}">Previous</a></li>
	</c:if>
		<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
			<c:if test="${pp.page == i}">
			<li class="page-item active" aria-current="page"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${i}&event_region=${event_region}">${i}</a></li>
			</c:if>
			<c:if test="${pp.page != i}">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${i}&event_region=${event_region}">${i}</a></li>
			</c:if>
		</c:forEach>
	<c:if test="${pp.endPage < pp.totalPage}"> <%-- 끝 페이지가 아닐때 다음버튼 출력 --%>
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${pp.endPage + 1}&event_region=${event_region}">Next</a></li>
	</c:if>
</c:when>		
<%-- 전체 목록의 페이징 처리 --%>
<c:otherwise>
	<c:if test="${pp.startPage > pp.pagePerBlk }">
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${pp.startPage - 1}">Previous</a></li>
	</c:if>
	<c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
		<c:if test="${pp.page == i}">
		<li class="page-item active" aria-current="page"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${i}">${i}</a></li>
		</c:if>
		<c:if test="${pp.page != i}">
		<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${i}">${i}</a></li>
		</c:if>
	</c:forEach>
		<c:if test="${pp.endPage < pp.totalPage}">
			<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/event_list.do?eventPage=${pp.endPage + 1}">Next</a></li>
		</c:if>
</c:otherwise>
</c:choose>
</ul>
</nav>
</div></div>
</body>
<c:if test="${club_num == 0}">
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</c:if>
<c:if test="${club_num != 0 && empty preview}">
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</c:if>
</html>