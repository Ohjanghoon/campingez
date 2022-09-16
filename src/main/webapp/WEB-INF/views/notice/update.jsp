<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<style>
.btn-outline-dark{
	border-color: #A8A4CE !important;
	color: #A8A4CE !important;
}
.btn-outline-dark:hover{
	background-color: #A8A4CE !important;
	color: white !important;
}
</style>
<main>
	<div class="container">
		<form name="noticeUpdateFrm" action="${pageContext.request.contextPath}/notice/update.do"
			method="post" enctype="multipart/form-data">
			<sec:csrfInput/>
			<input type="hidden" name="noticeNo" value="${notice.noticeNo}" />
			<div class="form-floating m-3">
			  <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" value="${notice.noticeTitle}">
			  <label for="noticeTitle">공지사항 제목</label>
			</div>
			<div class="row g-2">	
				<div class="col-md">
				  <div class="form-floating m-2">
				    <select class="form-select" id="categoryId" name="categoryId">
				      <option value="not1" ${notice.categoryId == 'not1' ? 'selected' : ''}>공지사항</option>
				      <option value="not2" ${notice.categoryId == 'not2' ? 'selected' : ''}>이벤트</option>
				    </select>
				    <label for="categoryId">카테고리</label>
				  </div>
				</div>
				<div class="col-md">
				  <div class="form-floating m-2">
				    <select class="form-select" id="noticeType" name="noticeType">
				      <option value="캠핑장관련" ${notice.noticeType == '캠핑장관련' ? 'selected' : ''}>캠핑장관련</option>
				      <option value="중고장터관련" ${notice.noticeType == '중고장터관련' ? 'selected' : ''}>중고장터관련</option>
				    </select>
				    <label for="noticeType">공지 유형</label>
				  </div>
				</div>
			</div>
			<div class="form-floating m-3">
			  <textarea class="form-control" placeholder="Leave a comment here" id="noticeContent" style="height: 200px" name="noticeContent">${notice.noticeContent}</textarea>
			  <label for="noticeContent">공지사항 내용</label>
			</div>
			<div class="btn-group flex-column-reverse p-3" aria-label="Basic checkbox toggle button group">
			<c:if test="${not empty notice.photos}">
				<c:forEach items="${notice.photos}" var="photo" varStatus="vs">
					<input type="checkbox" class="btn-check" id="delFile${vs.count}" name="delFile" value="${photo.noticePhotoNo}" autocomplete="off">
  					<label class="btn btn-outline-danger" for="delFile${vs.count}">첨부파일 삭제</label>
					<img src="${pageContext.request.contextPath}/resources/upload/notice/${photo.noticeRenamedFilename}" width="150px">
				</c:forEach>
			</c:if>
			</div>
			<div class="m-3">
			  <label for="upFile1" class="form-label">첨부파일1</label>
			  <input class="form-control" type="file" name="upFile" id="upFile1" multiple>
			</div>
			<div class="m-3">
			  <label for="upFile2" class="form-label">첨부파일2</label>
			  <input class="form-control" type="file" name="upFile" id="upFile2" multiple>
			</div>
			<div class="d-grid gap-2 col-6 mx-auto p-3">
			  <button class="btn btn-outline-dark" type="button">등록</button>
			</div>
		</form>
	</div>
</main>
	<script>
		document.querySelectorAll("[name=upFile]").forEach((input) => {
			input.addEventListener("change", (e) => {
				const {files} = e.target;
				const label = e.target.nextElementSibling;
				if(files[0]){
					label.textContent = files[0].name;
				}
				else{
					label.textContent = "파일을 선택하세요.";
				}
			});
		});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>