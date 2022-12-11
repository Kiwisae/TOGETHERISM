<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 관심있는 모임</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link href="<%=request.getContextPath()%>/css/heartlist.css"
	rel="stylesheet" type="text/css" />

</head>
<jsp:include page="../include/header.jsp"></jsp:include><br>
<br>
<br>
<br>
<br>
<body>
	<div class="wrapper">
		<div class="content">
			<br> <br>
			<table>
				<tr>
					<td valign=top><jsp:include page="../include/sidemenu.jsp"></jsp:include>
					</td>
					<td><c:if test="${empty heartlist}">
							<div class="alert alert-warning" role="alert"
								style="width: 800px;">현재 관심있는 모임이 없습니다.</div>
						</c:if> <%-- 리스트 출력 --%> <c:if test="${!empty heartlist}">
							<h2 class="heartlist_title" style="text-align: center; font-weight:bold;'">내가
								관심있는 모임</h2>
							<br>
							<br>
							<c:forEach var="ch" items="${heartlist}">
								<%-- 여기부터 카드 시작 --%>
								<div class="card mb-3 border-warning"
									style="width: 800px; height: 250px; line-height: 3; border-width: 2px;">
									<div class="row no-gutters">
										<div class="col-md-4">
											<img
												src="<%=request.getContextPath() %>/upload/${ch.club_image}"
												class="card-img full" style="width: 100%; height: 245px"
												alt="${ch.club_image}" />
										</div>
										<div class="col-md-8">
											<div class="card-body" style="height: 250px;">
												<div class="center cover" style="height: 50px;">
													<h5 class="card-title hidden" style="float: left;">
														<a
															href="<%=request.getContextPath()%>/club_ct.do?club_num=${ch.club_num}"
															style="text-decoration: none;">${ch.club_name}</a>
													</h5>

												</div>

												<p class="card-text hidden">${ch.club_info}</p>
												<p class="card-text">
													<c:choose>
														<c:when test="${ch.club_region == 'Seoul_Metropolitan'}">수도권</c:when>
														<c:when test="${ch.club_region == 'Gangwon'}">강원</c:when>
														<c:when test="${ch.club_region == 'Gyeongsang'}">경상</c:when>
														<c:when test="${ch.club_region == 'Jeolla'}">전라</c:when>
														<c:when test="${ch.club_region == 'Chungcheong'}">충청</c:when>
														<c:when test="${ch.club_region == 'Jeju'}">제주</c:when>
														<c:when test="${ch.club_region == 'Abroad'}">해외</c:when>
													</c:choose>
												</p>

												<!-- <p class="card-text"><small class="text-muted">${i.club_reg_date}</small></p>  -->
												<div class="cover">
													<div style="float: left;">
														<p class="card-text">${ch.club_member_count}명/
															${ch.club_member_limit} 명</p>
													</div>
													<div style="float: right;" id="heart2_div">
						
		<button id="heart2" class="heart_button_cancel" type="button" style="border:0; background-color:transparent;" onclick="location='<%=request.getContextPath() %>/remove1_heart.do?club_num=${ch.club_num }'">
		<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart-fill" style="color:red;" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
</svg></button> 
	</div>
												</div>

											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if> <%-- 페이징 처리 시작--%>
						<nav class="center" aria-label="Page navigation example">
							<ul class="pagination">
								<%-- 전체 목록의 페이징 처리 --%>

								<c:if test="${heartPage > 1 }">
									<li class="page-item"><a class="page-link"
										href="<%=request.getContextPath()%>/heart_list.do?page=${heartPage-1}">Previous</a></li>
								</c:if>
								<c:forEach var="a" begin="${startpage}" end="${endpage}">
									<c:if test="${a == heartpage }">
										<li class="page-item active" aria-current="page"><a
											class="page-link"
											href="<%=request.getContextPath()%>/heart_list.do?page=${a}">${a}</a></li>
									</c:if>
									<c:if test="${heartPage >= maxpage }">
										<li class="page-item"><a class="page-link"
											href="<%=request.getContextPath()%>/heart_list.do?page=${heartPage+1}">${a}</a></li>
									</c:if>
								</c:forEach>
								<c:if test="${heartPage < maxpage}">
									<li class="page-item"><a class="page-link"
										href="<%=request.getContextPath()%>/heart_list.do?page=${heartPage+1}">Next</a></li>
								</c:if>
							</ul>
						</nav></td>
				</tr>
			</table>
		</div>
	</div>


</body>
<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</html>