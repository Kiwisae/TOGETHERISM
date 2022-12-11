<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<title>Togetherism 회원정보 수정</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="./js/member.js"></script>

<style type="text/css">




.wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
      }
.content {
        padding: 1rem;
        }

</style>

</head>

<body>


<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

<div class="wrapper"><div class="content">
<table>
<tr>
<td valign=top><jsp:include page="../include/sidemenu.jsp"></jsp:include>
</td>

<td align="center" class="wrapper" width="800px" >
<div id="edit_wrap">

<h2 align="right" style="font-weight: bold; color: #5e17eb">Togetherism</h2>
<h2 align="right" style="font-weight: bold;">회원 정보 수정</h2>
<br><br><br><br><br><br>

  <form action="member_edit_ok.do" method="post"
  		onsubmit="return edit_check()" enctype="multipart/form-data">
  <input type="hidden" name="member_email" id="member_email" value="${member.member_email}"/>
  <input type="hidden" name="member_old_nickname" id="member_old_nickname" value="${member.member_nickname}"/>
  
   <table align="center" cellpadding="2" width="650px" height="800px">
    <tr>
     <th style="font-size: 21px;">회원이메일</th>
    </tr>
    <tr>
     <td >
      ${member.member_email}
     </td>
    </tr>
    <tr><td><br></td></tr>
    
    <tr>
     <th style="font-size: 21px;">회원비번</th>
    </tr>
    <tr> 
     <td>
      <input type="password" name="member_pw" id="member_pw" size="14"
      class="input_box" style= "width:645px" placeholder="비밀번호"/>
     </td>
    </tr>
    <tr><td><br></td></tr>
    
    <tr>
     <th style="font-size: 21px;">회원비번확인</th>
    </tr>
    <tr>
     <td>
      <input type="password" name="member_pw1" id="member_pw1" size="14"
      class="input_box" style= "width:645px" placeholder="비밀번호 확인"/>
     </td>
    </tr>
    <tr><td><br></td></tr>
    
    <tr>
     <th style="font-size: 21px;">회원닉네임</th>
    </tr>
    <tr>
     <td>
      <input type="text" name="member_nickname" id="member_nickname" size="14" class="input_box"
      value="${member.member_nickname}" style= "width:505px" onKeyup="nickname_checkR()" />
      <input type="button" id="nickname_check_button" value="닉네임 중복체크" class="btn btn-primary"
      onclick="nickname_check()" placeholder="닉네임"/>
      <div id="nickname_check">
     </td>
    </tr>
    <tr><td><br></td></tr>
    
    <tr>
     <th style="font-size: 21px;">휴대전화번호</th>
    </tr>
    <tr>
     <td>
		<input type="text" value="${member.member_mobile1}" name="member_mobile1" id="member_mobile1" 
		style= "width:205px" placeholder="숫자만 입력하세요"/> -
		<input type="text" value="${member.member_mobile2}" name="member_mobile2" id="member_mobile2" 
		style= "width:205px" placeholder="숫자만 입력하세요"/> -
		<input type="text" value="${member.member_mobile3}" name="member_mobile3" id="member_mobile3"
		style= "width:205px" placeholder="숫자만 입력하세요" />
     </td>
    </tr>
    <tr><td><br></td></tr>
    
    <tr>
		<th style="font-size: 21px;">거주지역</th>
	</tr>
    <tr>
		<td><select name="member_region" id="member_region" style= "width:645px">
				<option value="">=거주지역선택=</option>
				<option value="Seoul_Metropolitan" 
					<c:if test="${member.member_region == 'Seoul_Metropolitan'}">${'selected'}
           			</c:if>>수도권</option>
				<option value="Gangwon"
					<c:if test="${member.member_region == 'Gangwon'}">${'selected'}
           			</c:if>>강원</option>
				<option value="Gyeongsang" 
					<c:if test="${member.member_region == 'Gyeongsang'}">${'selected'}
           			</c:if>>경상</option>
				<option value="Jeolla"
					<c:if test="${member.member_region == 'Jeolla'}">${'selected'}
           			</c:if>>전라</option>
				<option value="Chungcheong" 
					<c:if test="${member.member_region == 'Chungcheong'}">${'selected'}
           			</c:if>>충청</option>
				<option value="Jeju"
					<c:if test="${member.member_region == 'Jeju'}">${'selected'}
           			</c:if>>제주</option>
				<option value="Abroad"
					<c:if test="${member.member_region == 'Abroad'}">${'selected'}
           			</c:if>>해외</option>
			</select></td>
	</tr>
	<tr><td><br></td></tr>
	
    <tr>
     <th style="font-size: 21px;">프로필사진</th>
    </tr>
    <tr>
   	 <td>
       <img src="<%=request.getContextPath() %>/upload/${member.member_image}" height="100" width="100" />
       <input type="file" name="member_image1" id="member_image1"/>
     </td>
    </tr>
    <tr><td><br></td></tr>
    <tr><td><br></td></tr>
   
   <tr>
   	<td align="center">
    <input type="submit" value="회원수정" class="btn btn-warning" />
    <input type="reset" value="수정취소" class="btn btn-danger"
    onclick="$('#member_pw').focus();" />
    </td>
   </tr>
   
   </table>
  </form>
</div>

</td>
</tr>
</TABLE>

</div>
</div>

<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>

</body>
</html>