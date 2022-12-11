<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<link href="<%=request.getContextPath()%>/css/middle.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/center.css" rel="stylesheet" type="text/css" />
<style>
    .cover {
        display: flex;
        justify-content: space-between;
    }
</style>
<script>
function delete_ok(a,b){
    if (!confirm("정말 삭제 하시겠습니까")) {
    } else {
        location.href="<%=request.getContextPath() %>/photo_delete.do?photo_num=" + a + "&club_num=" + b;
    }
}
$(document).ready(function(){
	// 유효성 검사
 	$("#checkw").click(function(){
		if($("#photow").val() == ""){
			alert("사진을 선택해주세요");
			return false;
		}
		if($("#contentw").val().length > 20){
			alert("20자 미만으로 입력해주세요");
			return false;
		}
	});
});
</script>

</head>
<body>

<button type="button" class="btn btn-warning" data-bs-toggle="modal" 
data-bs-target="#photoModal" data-bs-whatever="@mdo" style="border-radius:20px; width:100px;">사진 등록</button>
<form action="<%=request.getContextPath()%>/photo_create.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="club_num" value="${club_num}">

<div class="modal fade" id="photoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">사진 등록</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3"> <!-- 이후 유효성검사 -->
            <label for="recipient-name" class="col-form-label">사진</label>
            <input type="file" class="form-control" name="photo_file0" id="photow">
          </div>
          <div class="mb-3"> <!-- 이후 유효성검사 -->
            <label for="recipient-name" class="col-form-label">글귀</label>
            <input type="text" class="form-control" name="photo_content" id="contentw">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
        <button type="submit" class="btn btn-primary" id="checkw">사진 올리기</button>
      </div>
    </div>
  </div>
</div>
</form>

<div id="wrapper"><div id="content">
<c:if test="${empty pblist}">
	<div class="alert alert-warning center" role="alert" style="width: 1000px;">
 		현재 이 모임에 사진이 없습니다!
	</div>
</c:if>
<c:if test="${not empty pblist}">
<div class="row row-cols-1 row-cols-md-4 g-4 center">
<c:forEach items="${pblist}" var="p">
  <div class="col" style="max-width:400px;height:300px;">
    <div class="card h-100" style="width:300px;">
      <img src="<%=request.getContextPath() %>/upload/${p.photo_file}" style="width:300px; height:80%" class="card-img-top" alt="defalutimage">
      <div class="card-body">
        <div class='cover'>
        <p class="card-text">${p.photo_content}</p>
         <div>
         <a href="javascript:void(0);"  data-bs-toggle="modal" data-bs-target="#photoEditModal" data-bs-whatever="@mdo" style="text-decoration:none;color:black;">수정</a>
         <a href="javascript:void(0);" onclick="delete_ok(${p.photo_num}, ${club_num});" style="text-decoration:none;color:black;">삭제</a>
		
		<!-- 수정폼 모달 -->
		<form action="<%=request.getContextPath()%>/photo_edit.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="club_num" value="${club_num}">
<input type="hidden" name="photo_num" value="${p.photo_num}">

<div class="modal fade" id="photoEditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">사진 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
          <div class="mb-3"> <!-- 이후 유효성검사 -->
            <label for="recipient-name" class="col-form-label">사진</label>
            <input type="file" class="form-control" name="photo_file0" id="photoe">
          </div>
          <div class="mb-3"> <!-- 이후 유효성검사 -->
            <label for="recipient-name" class="col-form-label">글귀</label>
            <input type="text" class="form-control" name="photo_content" id="contente">
          </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
        <button type="submit" class="btn btn-primary" id="checke">사진 올리기</button>
      </div>
    </div>
  </div>
</div>
</form>
		<!--  -->
		</div>
        </div>
      </div>
<!--       <div class="card-footer">
        <small class="text-muted">Last updated 3 mins ago</small>
      </div> -->
    </div>
  </div>
</c:forEach>
</div>
</c:if>
</div></div>

</body>
</html>




