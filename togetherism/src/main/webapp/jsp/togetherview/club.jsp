<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>모임 만들기</title>
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
		<h1 class="club-title">모임 만들기</h1>
		<p>새로운 모임을 만들기 전에 이미 같은 지역에 같은 주제의 모임이 있는지 확인해주세요.</p>
		<p>수정 시 모임 정원은 현재정원 보다 늘리는 경우만 기능합니다. 신중히 결정해주세요.</p>

		<form class="bg-light p-4 m-auto"
			action="<%=request.getContextPath()%>/club_save.do"
			onSubmit="return club_check()" enctype="multipart/form-data"
			method="post">
			<div class="row mb-3">
				<div class="col-lg-2" id="club">
					<p>모임 대표 사진</p>

				</div>
				<div class="col-lg-5">
					<input type="file" name="club_image1" id="club_image1" />
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-lg-2">
					<p>모임 명</p>

				</div>
				<div class="col-lg-5">
					<input type="text" name="club_name" id="club_name" placeholder="12자 이내로 입력" maxlength="12"/> 
					<input id="club_name_check" type="button" value="모임명 중복체크"
						class="input_button" onClick="club_name_check1()" />
						<div id="clubnamecheck"></div>
				</div>
			</div>
			<div class="row mb-3">
				<div class="col-lg-2">
					<p>모임 키워드</p>
				</div>
				<div class="col-lg-5">
					<input type="text" name="club_keyword" id="club_keyword" placeholder="16자 이내로 입력" maxlength="16" />

				</div>
				<div class="row mb-3">
					<div class="col-lg-2">
						<p>모임 지역</p>
					</div>

					<div class="col-lg-5 d-flex">
						<div class="dropdown">
							<select id="club_region" name="club_region">
								<option value="">=지역선택=</option>
								<option value="Seoul_Metropolitan">수도권</option>
								<option value="Gangwon">강원</option>
								<option value="Gyeongsang">경상</option>
								<option value="Jeolla">전라</option>
								<option value="Chungcheong">충청</option>
								<option value="Jeju">제주</option>
								<option value="Abroad">해외</option>
							</select>
						</div>

					</div>
				</div>
				<div class="row mb-3">
					<div class="col-lg-2">
						<p>모임 관심사</p>
					</div>
					<div class="col-lg-5">
						<input type="text" name="club_interest" id="club_interest" placeholder="6자 이내로 입력" maxlength="6"/>
					</div>
				</div>
				
				
				<div class="row mb-3">
					<div class="col-lg-2">
						<p>모임 정원</p>
					</div>
					<div class="col-lg-5 d-flex">
						<input type="number" name="club_member_limit" id="club_member_limit" placeholder="숫자만 입력" />
					</div>
					<div class="row mb-3">
						<div class="col-lg-2">
							<p>모임 상세정보</p>
						</div>
						<div class="col-lg-7">
							<textarea class="form-control" rows="5" name="club_info" id="club_info"
								placeholder="650자 이내로 입력" maxlength="650"></textarea>
						</div>
					</div>
					<div class="row mb-3">
						<div class="col-lg-2">
							<p>오픈 채팅 URL 주소</p>
						</div>
						<div class="col-lg-5">
							<input type="text" name="club_chat" id="club_chat" />
						</div>
					</div>

					<div id="club_join_menu">
					
						<input type="submit" value="모임 만들기" 
						class="club_create_button" />

						 <!-- my_club.do -->
						<input type="reset" value="취소" class="input_button" />
						<input type="hidden" name="checked_id" value="">
					</div>
					</div> 
					</div>
		</form>
		</div>
</body>
<br><br><br><br><br>
<footer>
<jsp:include page="../include/footer.jsp"></jsp:include></footer>
</html>
