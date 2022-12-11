<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>     
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" />
<title>내가 참여한 이벤트</title>
<style type="text/css">



.wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
      }
.content {
        padding: 1rem;
        }
        
.host{
    float: left;
  }
  
.cover{
  display: flex;
  justify-content: space-between;
  }

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.min.js" integrity="sha384-IDwe1+LCz02ROU9k972gdyvl+AESN10+x7tBKgc9I5HFtuNz0wWnPclzo6p9vxnk" crossorigin="anonymous"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
function notattend_confirm(a,b){
      var notre = confirm("이벤트에 참석을 취소하시겠습니까?")
      if (notre == true) {
         location.href="<%=request.getContextPath() %>/event_user_attend_no.do?event_num="+a+"&club_num="+b;
       } else {
           return false;
       }
}
</script>

</head>
<body>

<jsp:include page="../include/header.jsp"></jsp:include><br><br><br><br><br>

<div class="wrapper"><div class="content">
<table>
<tr>
<td valign=top><jsp:include page="../include/sidemenu.jsp"></jsp:include>
</td>

<td class="wrapper" width="800px">
<div id="eventlist_wrap">
<br><br>

<c:if test="${empty attendMylist}">
   <br><br><br>
   <div class="alert alert-warning" role="alert" style="width: 800px;">
       참석하는 이벤트가 없습니다!
   </div>
</c:if>



<c:if test="${not empty attendMylist}">
<h2 align="center" style="font-weight: bold;">내가 참석한 이벤트</h2>
<br><br>
<c:forEach var="my" items="${attendMylist}"> 
<%-- 여기부터 카드 시작 --%>
<div class="card mb-3 border-warning" style="width: 800px; height: 250px;line-height:3;border-width: 2px;">
  <div class="row no-gutters">
    <div class="col-md-4">
    <c:if test="${not empty my.event_file}">
    <a href="<%=request.getContextPath() %>/event_cont.do?club_num=${my.club_num}&event_num=${my.event_num }&eventPage=1&state=cont"> 
    <img src="<%=request.getContextPath() %>/upload/${my.event_file}" class="card-img full" style="width:100%; height:245px"/>
    </a>
    </c:if>
    
    <c:if test="${empty my.event_file}">
     <a href="<%=request.getContextPath()%>/event_cont.do?club_num=${my.club_num}&event_num=${my.event_num}&eventPage=1&state=cont">
     <img src="<%=request.getContextPath()%>/images/logo_square.png" class="card-img"  style="width:100%; height:245px" alt="defalutimage">
     </a>
   </c:if>
    </div>
    <div class="col-md-8">
      <div class="card-body" style="height:250px;">
      <div class="center cover" style="height:50px;">
        <h5 class="card-title hidden" style="float:left;"><a href="<%=request.getContextPath() %>/event_cont.do?club_num=${my.club_num}&event_num=${my.event_num }&eventPage=1&state=cont" 
        style="text-decoration:none;">${my.event_title}</a></h5>   
     </div>
      <div class="center cover" style="height:50px;">
        <p class="card-title hidden" style="float:left;">
        <c:choose>
           <c:when test="${my.event_region == 'Seoul_Metropolitan'}">수도권</c:when>
           <c:when test="${my.event_region == 'Gangwon'}">강원</c:when>
           <c:when test="${my.event_region == 'Gyeongsang'}">경상</c:when>
           <c:when test="${my.event_region == 'Jeolla'}">전라</c:when>
           <c:when test="${my.event_region == 'Chungcheong'}">충청</c:when>
           <c:when test="${my.event_region == 'Jeju'}">제주</c:when>
           <c:when test="${my.event_region == 'Abroad'}">해외</c:when>
        </c:choose>
        </p>
      </div>
      <div class="center cover" style="height:50px;">
        <p class="card-title hidden" style="float:left;">
        <fmt:formatDate value="${my.event_date}" pattern="yy년  MM월  dd일  a hh:mm"/>
        </p>
      </div>       
      <div style="float:right;">
        <button onclick="notattend_confirm(${my.event_num},${my.club_num})"
             class="btn btn-danger"> 참석취소</button>
      </div>
     </div>
   </div>
    </div>
   </div>
</c:forEach>


            <ul style= "text-align: center;">
            
               <c:if test="${pp.startPage > pp.pagePerBlk }">
                  <li><a href="<%=request.getContextPath() %>/event_user_attend_mylistPaging.do?attendPage=${pp.startPage - 1}">
                  이전</a>
                  </li>
               </c:if>
               <c:forEach var="i" begin="${pp.startPage}" end="${pp.endPage}">
                  <li <c:if test="${pp.page==i}"> class="active" </c:if>>
                     <a href="<%=request.getContextPath() %>/event_user_attend_mylistPaging.do?attendPage=${i}">
                     ${i}
                     </a>
                  </li>
               </c:forEach>
               <c:if test="${pp.endPage < pp.totalPage}">
                  <li>
                     <a href="<%=request.getContextPath() %>/event_user_attend_mylistPaging.do?attendPage=${pp.endPage + 1}">
                     다음</a>
                  </li>
               </c:if>
            </ul>

</c:if>
</div>
</td>
</tr>
         
</table> 
      
      
      


</div>

</div>


<br><br><br><br><br>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>