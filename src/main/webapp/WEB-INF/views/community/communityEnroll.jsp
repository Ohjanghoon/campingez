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

<section id="community-container" class="container">

	<form name="communityEnrollFrm" action="${pageContext.request.contextPath}/community/communityEnroll.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
	
		<div>
		<p>게시판 선택</p>
			<input type="radio" name="categoryId" value="com1" checked>자유게시판
			<input type="radio" name="categoryId" value="com2">캠핑꿀팁게시판
		</div>
	
		<p>글제목: </p><input type="text" name="commTitle"><br>
		
		<p>작성자: </p><input type="text" name="userId" value="${loginMember.userId}" readonly><br> 

		<p>글내용: </p>
			<textarea rows="5" cols="30" name="commContent"></textarea>
		
		<br /><br />
		
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
<script>
const file = $("#upFile1").val();

if(file == null){
	alert("사진 등록은 필수입니다.");
	file.focus();
	return;
}

</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />