<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/headerlib.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
</head>
<body>
<c:if test="${result == 2}">
<script>
	alert("모임에 가입되지 않아 사진첩을 쓸 수 없습니다");
</script>
</c:if>
<c:if test="${empty result}">  
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal" data-bs-whatever="@mdo">사진 등록</button>
<form action="<%=request.getContextPath()%>/photo_create.do" method="post" enctype="multipart/form-data">
<input type="hidden" name="club_num" value="${club_num}">
<input type="hidden" name="photo_member_email" value="${member_email}">

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">모임 가입하기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form>
          <div class="mb-3"> <!-- 이후 유효성검사 -->
            <label for="recipient-name" class="col-form-label">사진</label>
            <input type="file" class="form-control" name="photo_file0" id="recipient-name">
          </div>
          <div class="mb-3"> <!-- 이후 유효성검사 -->
            <label for="recipient-name" class="col-form-label">글귀</label>
            <input type="text" class="form-control" name="photo_content" id="recipient-name">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소하기</button>
        <button type="submit" class="btn btn-primary">사진 올리기</button>
      </div>
    </div>
  </div>
</div>
</form>


</c:if>
</body>
</html>