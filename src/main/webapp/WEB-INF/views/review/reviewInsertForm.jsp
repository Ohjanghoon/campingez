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
  .btn-outline-dark{
	border-color: #A8A4CE !important;
	color: #A8A4CE !important;
	width : 350px;
  }
  .btn-outline-dark:hover{
	background-color: #A8A4CE !important;
	color: white !important;
  }
</style>
<main>
<div class="container">
	<form:form action="${pageContext.request.contextPath}/review/insertReview.do" id="reviewFrm" name="reviewFrm" method="post" enctype="multipart/form-data">
		<div class="form-floating m-3">
			<input class="form-control" value="${resNo}" name="resNo" readonly/>
			<label>예약번호</label>
		</div>
		<div class="form-floating m-3">
			<textarea style="height: 120px;" class="form-control" rows="15" cols="70" name="revContent"></textarea>
			<label>내용</label>
		</div>
		<div class="form-floating m-3">
			<label>별점</label>
				<span class="star" style="margin-left : 70px;">
				  ★★★★★
				  <span>★★★★★</span>
				  <input type="range" name="revScore"  oninput="drawStar(this)" value="1" step="1" min="0" max="5">
				  <input type="hidden" id="hiddenScore" />
				</span>
		</div>
			<div class="form-floating m-3">
				 <div class="custom-file" style="text-align: center;">
					<div>
					  <div class="custom-file">
						    <input class="form-control" type="file" name="upFile" id="upFile1"   onchange="readURL(this);"  multiple>
						    <label for="upFile1"></label><br>
							<img id="preview" class="upload" width="400px">
					  </div>
					</div>
				  </div>
			</div>
		<div style="text-align: center;">	
			<button class="btn btn-outline-dark" type="submit" >저장</button>
		</div>
	</form:form>
</div>
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


</script>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>