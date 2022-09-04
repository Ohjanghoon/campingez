<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>notice enroll</h1>
		<form name="noticeEnrollFrm" action="${pageContext.request.contextPath}/notice/enrollNotice.do"
			method="post" enctype="multipart/form-data">
			<sec:csrfInput/>
			<label for="noticeTitle">공지제목</label>
			<input type="text" name="noticeTitle" value=""><br><br />
			<label for="categoryId">카테고리</label>
			<select name="categoryId" id="categoryId">
				<option value="not1">공지사항</option>
				<option value="not2">이벤트</option>
			</select><br /><br />
			<label for="noticeType">공지 유형</label>
			<select name="noticeType" id="noticeType">
				<option value="캠핑장관련">캠핑장관련</option>
				<option value="중고장터관련">중고장터관련</option>
			</select><br /><br />
			<label for="noticeContent"></label>
			<textarea rows="5" cols="30" name="noticeContent" placeholder="내용을 입력하세요."></textarea>
			<br /> <br />
			<label for="">첨부파일1</label>
			<input type="file" name="upFile" id="upFile1" multiple><br /><br />
			<label for="">첨부파일2</label>
			<input type="file" name="upFile" id="upFile2" multiple><br /><br />
			<button>등록</button>
		</form>
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
</body>
</html>