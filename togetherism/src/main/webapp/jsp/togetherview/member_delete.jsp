<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<title>Togetherism 회원탈퇴</title>
<link rel="stylesheet" type="text/css" href="./css/admin.css" />
<link rel="stylesheet" type="text/css" href="./css/member.css" />
<script>
 function check(){
	 if($.trim($("#member_pw").val())==""){
		 alert("비밀번호를 입력하세요!");
		 $("#member_pw").val("").focus();
		 return false;
	 }
	 if($.trim($("#member_del_reason").val())==""){
		 alert("탈퇴사유를 입력하세요!");
		 $("#member_del_reason").val("").focus();
		 return false;
	 }
 }
</script>

<style type="text/css">

#box{background-color:#F6F7F8;}

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
<div id="box">
<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

<div class="wrapper"><div class="content">
<table>
<tr >
<td valign=top ><jsp:include page="../include/sidemenu.jsp"></jsp:include>

</td>


<td align="center" class="wrapper" width="800px">
<div id="del_wrap">

<h2 align="right" style="font-weight: bold; color: #5e17eb">Togetherism</h2>
<h2 align="right" style="font-weight: bold;">회원 탈퇴</h2>
<br><br><br><br><br><br>

  <form method="post" action="<%=request.getContextPath() %>/member_delete_ok.do" 
  					  onsubmit="return check()">
    <table align="center" cellpadding="2" width="650px" height="800px">
     <tr>
      	<th style="font-size: 21px;">회원 이메일</th>
     </tr>
	 <tr>
      	  <td>
	      ${d_email}
	      </td>
     </tr>
     <tr><td><br></td></tr>
     
     <tr>
	      <th style="font-size: 21px;">회원 닉네임</th>
	 </tr>
	 <tr>
	      <td>${d_nickname}</td>
     </tr>
     <tr><td><br></td></tr>
     
     <tr>
	      <th style="font-size: 21px;">비밀번호</th>
	 </tr>
	 <tr>
	      <td>
	      <input type="password" name="member_pw" id="member_pw" size="14" 
	      			class="input_box" style= "width:645px"/>
	      </td>
     </tr>
     <tr><td><br></td></tr>
     
     <tr>
      	<th style="font-size: 21px;">탈퇴사유</th>
     </tr>
	 <tr>
	      <td>
	      <textarea name="member_del_reason" id="member_del_reason" rows="7" 
	      			cols="30" class="input_box" placeholder="공백포함 40자 이내로 입력해주세요."
	      			style= "width:645px"></textarea>
	      </td>
     </tr>
     <tr><td><br></td></tr>
     
     <tr align="center">
     	<th style="font-size: 15px;" align="center">
     	 	회원 탈퇴하실 경우, 기존에 가입했던 모임,좋아요,이벤트 참석 이력은 삭제되는 점 참고 부탁드립니다.<br><br>
     	 	아울러 모임장인 모임이 존재할 경우, 해당 모임을 삭제 후 회원 탈퇴가 가능합니다.
     	</th>
     </tr>
    
    <tr align="center">
    <td>
    	 <input type="reset" value="취소" 
	     onclick="$('#member_pw').focus();" class="btn btn-warning"/>
	     <input type="submit" value="탈퇴" class="btn btn-danger"/>
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
</div>

</body>
</html>