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

<section id="community-container" class="container">

<form name="tradeUpdateFrm" action="${pageContext.request.contextPath}/community/communityUpdate.do?${_csrf.parameterName}=${_csrf.token}" method="post" 
enctype="multipart/form-data" >
<input type="hidden" name="commNo" value="${community.commNo}" />


<p>글제목: </p><input type="text" name="commTitle" value="${community.commTitle}"><br>

<p>작성자: </p><input type="text" name="userId" value="${loginMember.userId}" readonly><br> 


<p>글내용: </p><textarea rows="5" cols="30" name="commContent">${community.commContent}</textarea>

<br /><br />
<c:forEach items="${community.photos}" var="photo" varStatus="vs">
			<div class="btn-group-toggle p-0 mb-3" data-toggle="buttons">
				<label class="btn btn-outline-danger btn-block" style="overflow: hidden" title="">
					<input type="checkbox" id="delFile${vs.count}" name="delFile" value="${photo.commPhotoNo}">
					첨부파일삭제 - ${photo.originalFilename}
				</label>
			</div>
		</c:forEach>

<div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일1</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1" accept="image/*" multiple>
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
<br><br>
<input type="submit" value="저장">
</form>



</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />