<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link href="<%=request.getContextPath()%>/css/hidden_text.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/middle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/center.css" rel="stylesheet" type="text/css" />
<style>
.host{
    float: left;
  }
.cover{
display: flex;
justify-content: space-between;
 }
</style>
</head>
<body>

<%-- 핫 --%>
<c:if test="${preview == 'hot'}">
<%-- 리스트 출력 --%>
<c:if test="${not empty clubprelist}">
<div style="display: flex;">
<c:forEach var="i" items="${clubprelist}">
<div class="card" style="width:300px;float:left;margin:20px;">
<a href="<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}">
  <img src="<%=request.getContextPath() %>/upload/${i.club_image}" style="width:300px;height:300px;" class="card-img-top" alt="...">
</a>
  <div class="card-body">
    <p class="card-text"><a href="<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}" style="text-decoration: none;color:black;">${i.club_name}</a></p>
  </div>
</div>

</c:forEach>
</div>
</c:if>
</c:if>

<%-- 뉴 --%>
<c:if test="${preview == 'new'}">
<%-- 리스트 출력 --%>
<c:if test="${not empty clubprelist}">
<div style="display: flex;">
<c:forEach var="i" items="${clubprelist}"> 
<div class="card" style="width:300px;float:left;margin:20px;">
<a href="<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}">
  <img src="<%=request.getContextPath() %>/upload/${i.club_image}" style="width:300px;height:300px;" class="card-img-top" alt="...">
</a>
<div class="card-body">
    <p class="card-text"><a href="<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}" style="text-decoration: none;color:black;">${i.club_name}</a></p>
  </div>
</div>
</c:forEach>
</div>
</c:if>
</c:if>

<c:if test="${preview == 'pre'}">
<div class="wrapper"><div class="content">
<div style="float:right">
<button onclick="location='<%=request.getContextPath()%>/club_list.do'"
 class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">더보기</button>
</div>
<br><br><br>
<%-- 미리보기 리스트 출력 --%>
<c:if test="${not empty clubprelist}">
<c:forEach var="i" items="${clubprelist}"> 


<div class="card mb-3 border-warning" style="width: 800px; height: 250px;line-height:3;border-width: 2px;">
  <div class="row no-gutters">
    <div class="col-md-4">
    <a href="<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}">
    <img src="<%=request.getContextPath() %>/upload/${i.club_image}" class="card-img full" style="width:100%; height:245px" alt="${i.club_image}"/>
    </a>
    </div>
    <div class="col-md-8">
      <div class="card-body" style="height:250px;">
      <div class="center cover" style="height:50px;">
        <h5 class="card-title hidden" style="float:left;"><a href="<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}" style="text-decoration:none;">${i.club_name}</a></h5>	
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
          <div class="cover">
        <div style="float:left;">
		<p class="card-text">${i.club_member_count} 명 / ${i.club_member_limit} 명</p></div>
       	<div style="float:right;">
		<button onclick="location='<%=request.getContextPath()%>/club_ct.do?club_num=${i.club_num}'"
 		class="btn btn-warning" style="width:200px; height:40px; border-radius:20px;">모임 보기</button>
       	</div>
       	</div>
      </div>
    </div>
  </div>
</div>
</c:forEach>
</c:if>
</div></div>
</c:if>


</body>

</html>