<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/heart.css" />
<link rel="text" type="text/javascript"
	href="<%=request.getContextPath()%>/css/heart.js" />
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://demo.plantpot.works/assets/css/normalize.css">
<link rel="stylesheet" href="https://use.typekit.net/opg3wle.css">

<title>Heart</title>
<title></title>
</head>
<body>
	
<script>
	$(document).ready(function() {
			
			<%-- var project = '<%=request.getContextPath()%>' --%>
			
			<%-- var project = "
			<%=request.getContextPath()%>/insert_heart.do"
			alert(project); --%>
			
			$("#heart2_div").hide();
			
			// 좋아요 버튼 클릭
			$("#heart1").click(function(){
				alert("heart1 in");
//			var data = "club_num="+54+"&member_email="+test14@gmail.com
								// Json 형식
				var data = {"club_num":96}
				$.post("<%=request.getContextPath()%>/insert_heart.do", data, function(result){
					alert(result);
					$("#heart1_div").hide();
					$("#heart2_div").show();
				});	
				 
				// 좋아요 취소버튼 클릭
				$("#heart2").click(function(){
					alert("heart2 in");
					var data = {"club_num":96}
					$.post("<%=request.getContextPath()%>/remove_heart.do", data, function(result){
						$("#heart1_div").show();
						$("#heart2_div").hide();
					});
				
				/* $.ajax({
					type : "post",
					url : "/togetherism/insert_heart.do",
					data : {"club_num":54, "member_email":"test14@gmail.com"},
					success : function(result){
						alert(result);
						if(result == 1){
							$("#heart1_div").hide();
							$("#heart2_div").show();
						}						
					}			
					
				});	// $.ajax() end	 */		
				 
			});
				
			});
			 
	});
</script>
	
	<div id="heart1_div">
		<button id="heart1" class="heart_button_fill" type="button" style="border:0; background-color:transparent;">
		<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart" viewBox="0 0 16 16">
  <path d="m8 2.748-.717-.737C5.6.281 2.514.878 1.4 3.053c-.523 1.023-.641 2.5.314 4.385.92 1.815 2.834 3.989 6.286 6.357 3.452-2.368 5.365-4.542 6.286-6.357.955-1.886.838-3.362.314-4.385C13.486.878 10.4.28 8.717 2.01L8 2.748zM8 15C-7.333 4.868 3.279-3.04 7.824 1.143c.06.055.119.112.176.171a3.12 3.12 0 0 1 .176-.17C12.72-3.042 23.333 4.867 8 15z"/>
</svg>
		</button>
	</div>

	<div id="heart2_div">
		<button id="heart2" class="heart_button_cancel" type="button" style="border:0; background-color:transparent;">
		<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-heart-fill" style="color:red;" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
</svg></button>
	</div>
	


	<%-- <div id="heart1_div">
		<button id="heart1" class="heart_button_fill" type="button"
			onClick="location.href='<%=request.getContextPath()%>/insert_heart.do?club_num=54&member_email=test14@gmail.com';">
			좋아요</button>
	</div>

	<div id="heart2_div">
		<button id="heart2" class="heart_button_cancel" type="button"
			onClick="location.href='<%=request.getContextPath()%>/remove_heart.do?club_num=54&member_email=test14@gmail.com';">
			좋아요취소</button>
	</div> --%>
	
</html>