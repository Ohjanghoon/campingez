<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>공지사항은 뭘까요?</h3>
	<button id="update">수정</button>
	<button id="delete">삭제</button>
	<hr />
	<table class="table">
	<tr>
		<th>제목</th>
		<td>[${notice.categoryId == 'not1' ? '공지사항' : '이벤트'}] ${notice.noticeTitle}</td>
		<th>내용</th>
		<td>${notice.noticeContent}</td>
		<th>작성일</th>
		<td>${notice.noticeDate}</td>
	</tr>
	<tr>
		<c:if test="${not empty notice.photos}">
			<c:forEach items="${notice.photos}" var="photo">	
				<td><img src ="${pageContext.request.contextPath}/resources/upload/notice/${photo.noticeRenamedFilename}" class="upload" width="100px"></td>
			</c:forEach>
		</c:if>
	</tr>
	</table>
	<script>
		// 수정
		document.querySelector("#update").addEventListener('click', (e) => {
			location.href = "${pageContext.request.contextPath}/notice/update.do?noticeNo=${notice.noticeNo}";
		});
		// 삭제
		document.querySelector("#delete").addEventListener('click', (e) => {
			const result = confirm("정말 삭제하시겠습니까?");
			if(result == true){
				location.href = "${pageContext.request.contextPath}/notice/delete.do?noticeNo=${notice.noticeNo}";
			}
		});
	</script>
</body>
</html>