<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>모임 수정</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/club.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
	integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js"
	integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk"
	crossorigin="anonymous"></script>

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="<%=request.getContextPath()%>/js/club.js"></script>
</head>

<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>
	<div class="container  mt-5 mb-5">
		<h1 class="club-title">모임정보 수정하기</h1>
		<form class="bg-light p-4 m-auto"
			action="<%=request.getContextPath()%>/club_edit_save.do"
			onSubmit="return club_edit_check()" enctype="multipart/form-data"
			method="post">
			<input type="hidden" name="club_num" value="${club_num}" />
			<div class="row mb-3">
				<div class="col-lg-2" id="club">
					<p>모임 대표 사진</p>

				</div>
				<div class="col-lg-5">
					<img
						src="<%=request.getContextPath() %>/upload/${club_cont.club_image}" width="300" height="300"/>
					<input type="file" name="club_image1" id="club_image1" />
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-lg-2">
					<p>모임 명</p>

				</div>
				<div class="col-lg-5">
					<input type="text" name="club_name" value="${club_cont.club_name}"
						placeholder="16자 이내로 입력" id="club_name"/> <input id="club_name_check"
						type="button" value="모임명 중복체크" class="input_button"
						onclick="club_name_check1()" />
					<div id="clubnamecheck"></div>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-lg-2">
					<p>모임 키워드</p>
				</div>
				<div class="col-lg-5">
					<input type="text" name="club_keyword" id="club_keyword"
						value="${club_cont.club_keyword}" placeholder="16자 이내로 입력" />

				</div>
				<div class="row mb-3">
					<div class="col-lg-2">
						<p>모임 지역</p>
					</div>


					<div class="col-lg-5 d-flex">
						<div class="dropdown">
							<select class="select_box" aria-label="Default select example" name="club_region" id="club_region">
         			<option value="Seoul_Metropolitan" <c:if test="${club_cont.club_region == 'Seoul Metropolitan'}">selected
            			</c:if>>수도권</option>
         			<option value="Gangwon" <c:if test="${club_cont.club_region == 'Gangwon'}">selected
            			</c:if>>강원</option>
         			<option value="Gyeongsang" <c:if test="${club_cont.club_region == 'Gyeongsang'}">selected
            			</c:if>>경상</option>
         			<option value="Jeolla" <c:if test="${club_cont.club_region == 'Jeolla'}">selected
            			</c:if>>전라</option>
         			<option value="Chungcheong" <c:if test="${club_cont.club_region == 'Chungcheong'}">selected
            			</c:if>>충청</option>
         			<option value="Jeju" <c:if test="${club_cont.club_region == 'Jeju'}">selected
           				 </c:if>>제주</option>
         				<option value="Abroad" <c:if test="${club_cont.club_region == 'Abroad'}">selected
            			</c:if>>해외</option>
        			 </select>
						</div>

					</div>
				</div>
				<div class="row mb-3">
					<div class="col-lg-2">
						<p>모임 관심사</p>
					</div>
					<div class="col-lg-5">
						<input type="text" name="club_interest" id="club_interest"
							value="${club_cont.club_interest}" placeholder="6자 이내로 입력" />
					</div>
				</div>
				<div class="row mb-3">
					<div class="col-lg-2">
					<input type="hidden" name="club_member_count" id="club_member_count" value="5" /> <%-- ${club_cont.club_member_count} --%>
						<p>모임 정원</p>
					</div>
					<div class="col-lg-5 d-flex">
						<input type="number" name="club_member_limit" id="club_member_limit" 
							value="5" />
					</div>
					<div class="row mb-3">
						<div class="col-lg-2">
							<p>모임 상세정보</p>
						</div>
						<div class="col-lg-7">
							<textarea class="form-control" rows="5" name="club_info" id="club_info"
								value="${club_cont.club_info}" placeholder="650자 이내로 입력">${club_cont.club_info}</textarea>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-lg-2">
							<p>오픈 채팅 URL 주소</p>
						</div>
						<div class="col-lg-5">
							<input type="text" name="club_chat" id="club_chat"
								value="${club_cont.club_chat}" />
						</div>
					</div>

					<div id="club_join_menu">
					<input type="submit" value="모임 수정하기" 
						class="input_button"/>
						<input
							type="reset" value="취소" class="input_button" />
					</div>
					</div>
					</div>
		</form>
		</div>
		<%-- 		<jsp:include page="../include/footer.jsp"></jsp:include> --%>
</body>
<br><br><br><br><br>
<footer>
<jsp:include page="../include/footer.jsp"></jsp:include></footer>
</html>
