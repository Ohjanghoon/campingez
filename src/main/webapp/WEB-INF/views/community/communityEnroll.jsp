<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="loginMember" scope="page" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="커뮤니티게시판" name="title" />
</jsp:include>
<script src="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/summernote.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/summernote.css">

<section id="community-container" class="container">
	
	<h2 class="text-center fw-bold pt-5">게시판 글 작성</h2>
        <hr />

   <form name="communityEnrollFrm" action="${pageContext.request.contextPath}/community/communityEnroll.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
         

    <div class="form-floating spec-wrap" style="width:250px;margin-bottom:30px;">
			  <select class="form-select" id="category" name="categoryId">
			    <option value="com1" selected>자유게시판</option>
			    <option value="com2">꿀팁게시판</option>
			    
			  </select>
			  <label for="category">게시판 선택</label>
			</div>
         
 	 <input type="text" id="commTitle" name="commTitle" placeholder="제목" style="display:block;width:100%;border:none; font-size:40px;outline: none;">
         
         <hr style="margin-top:30px;"/>   
      
      <input type="hidden" name="userId" value="${loginMember.userId}" readonly><br> 
         <textarea id="summernote" name="commContent" required></textarea>
         
         <div class="mb-3">
		  <input class="form-control" type="file" id="upFile" accept="image/*" name="upFile" multiple>
		</div>
         
      <div class="btn-wrap d-flex justify-content-center">
		<button type="button"  id="enroll-btn" class="btn btn-primary" style="margin-top:50px;">작성</button>
		</div>
		
   </form>
</section>
<script>
$(document).ready(function() {
	$('#summernote').summernote({
		  height: 500,                 
		  minHeight: null,             
		  maxHeight: null,             
		  focus: true,                  
		  lang: "ko-KR",					
		  placeholder: '게시판에 올릴 게시글 내용을 작성해주세요.'
          
	});
});



document.querySelector("#enroll-btn").addEventListener('click', (e) => {
	const content = document.querySelector("#summernote");
	const title = document.querySelector("#commTitle");

	if(!content.value) {
		alert("게시글 내용을 입력해주세요.");
		content.focus();
		return;
	} else if(!title.value) {
		alert("게시글 제목을 입력해주세요.");
		title.focus();
		return;
	}

	document.communityEnrollFrm.submit();
});
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />