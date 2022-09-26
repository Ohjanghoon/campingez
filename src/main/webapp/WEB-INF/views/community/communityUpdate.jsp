<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<sec:authentication property="principal" var="loginMember" scope="page" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="커뮤니티게시판" name="title" />
</jsp:include>
<script src="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/summernote.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/summernote.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityView.css">

<section id="community-container" class="container">

<h2 class="text-center fw-bold pt-5">게시글 수정</h2>
        <hr />

<form name="communityUpdateFrm" action="${pageContext.request.contextPath}/community/communityUpdate.do?${_csrf.parameterName}=${_csrf.token}" method="post" 
enctype="multipart/form-data" >
<input type="hidden" name="commNo" value="${community.commNo}" />

 <div class="form-floating spec-wrap" style="width:250px;margin-bottom:30px;">
			  <select class="form-select" id="category" name="categoryId">
			  <c:if test="${community.categoryId eq 'com1'}">
			    <option value="com1" selected>자유게시판</option>
			    <option value="com2">꿀팁게시판</option>	    
			  </c:if>
			  
			  <c:if test="${community.categoryId eq 'com2'}">
			    <option value="com1">자유게시판</option>
			    <option value="com2" selected>꿀팁게시판</option>	    
			  </c:if>
			    
			  </select>
			  <label for="category">게시판 선택</label>
			</div>
         
 	 <input type="text" id="commTitle" name="commTitle" value="${community.commTitle}" placeholder="제목" style="display:block;width:100%;border:none; font-size:40px;outline: none;">
         
         <hr style="margin-top:30px;"/>   
      
      <input type="hidden" name="userId" value="${loginMember.userId}" readonly><br> 
         <textarea name="commContent" id="summernote">${community.commContent}</textarea>
         <div class="del-wrap">
         <c:forEach items="${community.photos}" var="photo" varStatus="vs">
    		<div class="del-file-wrap">
				<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
				  	<input type="checkbox" class="btn-check" id="delFile${vs.count}" name="delFile" value="${photo.commPhotoNo}">
					<label for="delFile${vs.count}" class="btn btn-outline-danger btn-block" style="overflow: hidden" title="">첨부파일삭제 - ${photo.originalFilename}</label>
				</div>
				<div class="file-wrap">
					<img src="${pageContext.request.contextPath}/resources/upload/community/${photo.renamedFilename}" width="150px">
				</div>
			</div>
<%--          <div class="btn-group-toggle p-0 mb-3" data-toggle="buttons">
            <label class="btn btn-outline-danger btn-block" style="overflow: hidden" title="">
               <input type="checkbox" id="delFile${vs.count}" name="delFile" value="${photo.commPhotoNo}">
               첨부파일삭제 - ${photo.originalFilename}
            </label>
         </div> --%>
      </c:forEach>
      </div>
         <div class="mb-3">
		  <input class="form-control" type="file" id="upFile" accept="image/*" name="upFile" multiple>
		</div>
         
      <div class="btn-wrap d-flex justify-content-center">
		<button type="button"  id="update-btn" class="btn btn-primary" style="margin-top:50px;">작성</button>
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
		  placeholder: '중고거래 게시판에 올릴 게시글 내용을 작성해주세요.'
          
	});
});

const content = document.querySelector("#summernote");
const title = document.querySelector("#commTitle");

title.focus();


document.querySelector("#update-btn").addEventListener('click', (e) => {

	if(!content.value) {
		alert("게시글 내용을 입력해주세요.");
		content.focus();
		return;
	} else if(!title.value) {
		alert("게시글 제목을 입력해주세요.");
		title.focus();
		return;
	}
	content.value = (content.value.replaceAll('<p>', '').replaceAll('</p>', ''));
	document.communityUpdateFrm.submit();
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />