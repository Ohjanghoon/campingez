<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<style>
  .star {
    position: relative;
    font-size: 2rem;
    color: #ddd;
  }
  
  .star input {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    opacity: 0;
    cursor: pointer;
  }
  
  .star span {
    width: 0;
    position: absolute; 
    left: 0;
    color: purple;
    overflow: hidden;
    pointer-events: none;
  }
</style>
<main>
	<form:form action="${pageContext.request.contextPath}/review/insertReview.do" method="post" enctype="multipart/form-data">
		<table>
		<c:forEach items="${review}" var="review">
		<tr>
			<th>예약번호</th>
			<td><input value="${resNo}" name="resNo" readonly/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="15" cols="70" name="revContent">${review.revContent}</textarea></td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
				<span class="star">
				  ★★★★★
				  <span>★★★★★</span>
				  <input type="range" name="revScore"  oninput="drawStar(this)" value="1" step="1" min="0" max="5">
				  <input type="hidden" id="hiddenScore" value="${review.revScore}"/>
				</span>
			</td>
		</tr>
		</c:forEach>
		<c:forEach items="${reviewPhoto}" var="reviewPhoto">
		<tr>
			<th>첨부파일</th>
			<td> 
				<div>
				  <div class="custom-file">
					    <input type="file" name="upFile" id="upFile1" value="${reviewPhoto.revOriginalFilename}"  onchange="readURL(this);"  multiple>
					    <label for="upFile1">파일 선택</label><br>
						<img id="preview" src ="${pageContext.request.contextPath}/resources/upload/review/${reviewPhoto.revRenamedFilename}" class="upload" width="400px">
				  </div>
				</div>
			</td>
		</tr>
		</c:forEach>
		
		<tr>
			<%-- <c:if test="${not empty notice.photos}">
				
			</c:if> --%>
		</tr>
		</table>
		<button type="submit">저장</button>
	</form:form>
<script>
const drawStar = (target) => {
	var percent = target.value*20 + "%";
	console.log(target.value);
    document.querySelector(`.star span`).style.width = percent;
  }
  
function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	  }
	}
window.onload = function(){
	  var a = document.getElementById( 'hiddenScore' );
	  var percent = a.value*20 + "%";
	    document.querySelector(`.star span`).style.width = percent;
	  }
</script>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>