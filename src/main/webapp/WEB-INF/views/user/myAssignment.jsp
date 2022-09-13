<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container" id="myAssignmentList">
<h3>양도목록</h3>
	<table class="table">
		<thead>
			<th scope="col">양도번호</th>
			<th scope="col">사용자 아이디</th>
			<th scope="col">예약번호</th>
			<th scope="col">제목</th>
			<th scope="col">내용</th>
			<th scope="col">양도가격</th>
			<th scope="col">마감일자</th>
			<th scope="col">좋아요</th>
			<th scope="col">양도상태</th>
		</thead>
		<tbody>
			<c:forEach items="${assignList}" var="assign" varStatus="vs">
				<tr data-no="${res.resNo}">
					<td>${assign.assignNo}</td>
					<td>${assign.userId}</td>
					<td>${assign.resNo}</td>
					<td>${assign.assignTitle}</td>
					<td>${assign.assignContent}</td>
					<td><fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</td>
					<td>
						<fmt:parseDate value="${assign.assignDate}" pattern="yyyy-MM-dd" var="assignDate" />
						<fmt:formatDate value="${assignDate}" pattern="yyyy-MM-dd" />
					</td>
					<td>${assign.assignLikeCount}</td>
					<td>${assign.assignState}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>	
</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>