<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Togetherism 회원가입</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="./js/member.js"></script>


</head>

<body>
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>



	<form action="<%=request.getContextPath()%>/member_signup_ok.do" method="post"
	enctype="multipart/form-data" onSubmit="return check()">
	<br><br>
	<h1 align="center" style="font-weight: bold; color: #5e17eb">Togetherism</h1>
	<h2 align="center" style="font-weight: bold;">회원가입</h2>
	<br><br>
	<table align="center" cellpadding="2" width="650px" height="800px">

		<!----- Email Id ---------------------------------------------------------->
		<tr>
			<th style="font-size: 21px;">이메일</th>
		</tr>
		<tr>
			<td>
			<input type="text" name="email_id" id="email_id" maxlength="100" onKeyup="email_checkR()" 
			placeholder="이메일"/>@
			<input name="email_domain" id="email_domain" placeholder="도메인" readonly/>
				<select id="mail_list" name="mail_list" onChange="domain_list()"> 
						<option value="">=이메일선택=</option>
						<option value="gmail.com">gmail.com</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="0">직접입력</option>
				</select>
			<input type="button" id="email_check_button" value="이메일 중복체크" class="btn btn-primary"
      		onclick="email_check()"  />
      		<div id="email_check">
			</td>
		</tr>
		<tr><td><br></td></tr>

		<!----- 비밀번호 ---------------------------------------------------------->
		<tr>
			<th style="font-size: 21px;">비밀번호</th>
		</tr>
		<tr>
			<td><input type="password" name="member_pw" id="member_pw" maxlength="30" placeholder="비밀번호"
			 style="width:645px"/></td>
			
		
		</tr>
		<tr><td><br></td></tr>
		
		<!----- 비밀번호 확인 ---------------------------------------------------------->
		<tr>
			<th style="font-size: 21px;">비밀번호 확인</th>
		</tr>
		<tr>
			<td><input type="password" name="member_pw1" id="member_pw1" maxlength="30" placeholder="비밀번호 확인"
			style= "width:645px"/></td>
		
		</tr>
		<tr><td><br></td></tr>
		
		<!----- 닉네임 ---------------------------------------------------------->
		<tr>
			<th style="font-size: 21px;">닉네임</th>
		</tr>
		<tr>
			<td>
				<input type="text" name="member_nickname" id="member_nickname" maxlength="20" 
				onKeyup="nickname_checkR()" placeholder="닉네임" style= "width:505px" />
				<input type="button" id="nickname_check_button" value="닉네임 중복체크" class="btn btn-primary"
	      		onClick="nickname_check()" />
      		<div id="nickname_check">
      		</td>
      		
		</tr>
		<tr><td><br></td></tr>
		
		<!----- 휴대전화 ---------------------------------------------------------->
		<tr>
			<th style="font-size: 21px;">휴대전화</th>
		</tr>
		<tr>
			<td>
			<input type="text" name="member_mobile1" id="member_mobile1" placeholder="숫자만 입력하세요" 
			style= "width:205px"/> -
			<input type="text" name="member_mobile2" id="member_mobile2" placeholder="숫자만 입력하세요"
			style= "width:205px" /> -
			<input type="text" name="member_mobile3" id="member_mobile3" placeholder="숫자만 입력하세요"
			style= "width:205px" />
			</td>
		</tr>
		<tr><td><br></td></tr>
		
		<!----- 거주지역 ---------------------------------------------------------->
		<tr>
			<th style="font-size: 21px;">거주지역</th>
		</tr>
		<tr>
			<td><select name="member_region" id="member_region" style= "width:645px">
					<option value="">=거주지역선택=</option>
					<option value="Seoul_Metropolitan">수도권</option>
					<option value="Gangwon">강원</option>
					<option value="Gyeongsang">경상</option>
					<option value="Jeolla">전라</option>
					<option value="Chungcheong">충청</option>
					<option value="Jeju">제주</option>
					<option value="Abroad">해외</option>
			</select></td>
		</tr>
		<tr><td><br></td></tr>
		
		<!----- 프로필 이미지 ---------------------------------------------------------->
		<tr>
			<th style="font-size: 21px;">프로필 이미지 사진</th>
		</tr>
		<tr>
			<td>
			<input type="file" name="member_image1" id="member_image1" style= "width:645px"/>
			</td>
		</tr>
		<tr><td><br></td></tr>
		
	</table>
	<br><br>
	<div align="center">
			<input type="submit" value="가입하기" class="btn btn-warning">
			<input type="reset" value="취소" align="center" class="btn btn-danger" >
	</div>
	</form>



<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>