<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<thead>
			<th>양도번호</th>
			<th>사용자 아이디</th>
			<th>예약번호</th>
			<th>제목</th>
			<th>내용</th>
			<th>양도가격</th>
			<th>마감일자</th>
			<th>좋아요</th>
			<th>양도상태</th>
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

</body>

</html>