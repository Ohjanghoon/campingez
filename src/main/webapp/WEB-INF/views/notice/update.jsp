<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<main>
	<div class="container">
	<h1>notice update</h1>
		<form name="noticeUpdateFrm" action="${pageContext.request.contextPath}/notice/update.do"
			method="post" enctype="multipart/form-data">
			<sec:csrfInput/>
			<input type="hidden" name="noticeNo" value="${notice.noticeNo}" />
			<label for="noticeTitle">공지제목</label>
			<input type="text" name="noticeTitle" value="${notice.noticeTitle}"><br><br />
			<label for="categoryId">카테고리</label>
			<select name="categoryId" id="categoryId">
				<option value="not1" ${notice.categoryId == 'not1' ? 'selected' : ''}>공지사항</option>
				<option value="not2" ${notice.categoryId == 'not2' ? 'selected' : ''}>이벤트</option>
			</select><br /><br />
			<label for="noticeType">공지 유형</label>
			<select name="noticeType" id="noticeType">
				<option value="캠핑장관련" ${notice.noticeType == '캠핑장관련' ? 'selected' : ''}>캠핑장관련</option>
				<option value="중고장터관련" ${notice.noticeType == '중고장터관련' ? 'selected' : ''}>중고장터관련</option>
			</select><br /><br />
			<label for="noticeContent"></label>
			<textarea rows="5" cols="30" name="noticeContent" placeholder="내용을 입력하세요.">${notice.noticeContent}</textarea>
			<br /> <br />
	<c:if test="${not empty notice.photos}">
			<c:forEach items="${notice.photos}" var="photo" varStatus="vs">
				<input type="checkbox" id="delFile${vs.count}" name="delFile" value="${photo.noticePhotoNo}">
				첨부파일 삭제 - 
				<img src="${pageContext.request.contextPath}/resources/upload/notice/${photo.noticeRenamedFilename}" width="100px">
			</c:forEach>
	</c:if>
			<br /><br />
			<label for="">첨부파일1</label>
			<input type="file" name="upFile" id="upFile1" multiple><br /><br />
			<label for="">첨부파일2</label>
			<input type="file" name="upFile" id="upFile2" multiple><br /><br />
			<button>저장</button>
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