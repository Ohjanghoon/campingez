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
<div class="container" id="myReservationList">
<h3>예약목록</h3>
	<table class="table">
		<thead>
			<th scope="col">NO</th>
			<th scope="col">예약번호</th>
			<th scope="col">자리아이디</th>
			<th scope="col">예약자이름</th>
			<th scope="col">예약자 전화번호</th>
			<th scope="col">예약인원</th>
			<th scope="col">금액</th>
			<th scope="col">예약일자</th>
			<th scope="col">입실일자</th>
			<th scope="col">퇴실일자</th>
			<th scope="col">차량번호</th>
			<th scope="col">예약상태</th>
			<th scope="col">결제수단</th>
			<th scope="col">리뷰작성</th>
		</thead>
		<tbody>
			
			<c:forEach items="${reservationList}" var="res" varStatus="vs">
				<tr  style ="height : 55.7px" data-no="${res.resNo}">
					<td>${vs.count}</td>
					<td>${res.resNo}</td>
					<td>${res.campId}</td>
					<td>${res.resUsername}</td>
					<td>${res.resPhone}</td>
					<td>${res.resPerson}</td>
					<td><fmt:formatNumber value="${res.resPrice}" pattern="#,###"/>원</td>
					<td>
						<fmt:parseDate value="${res.resDate}" pattern="yyyy-MM-dd" var="resDate" />
						<fmt:formatDate value="${resDate}" pattern="yyyy-MM-dd" />
					</td>
					<td>
						<fmt:parseDate value="${res.resCheckin}" pattern="yyyy-MM-dd" var="resCheckin" />
						<fmt:formatDate value="${resCheckin}" pattern="yyyy-MM-dd" />
					</td>
					<td>
						<fmt:parseDate value="${res.resCheckout}" pattern="yyyy-MM-dd" var="resCheckout" />
						<fmt:formatDate value="${resCheckout}" pattern="yyyy-MM-dd" />
					</td>
					<td>${res.resCarNo}</td>
					<td>${res.resState}</td>
					<td>${res.resPayment}</td>
					<c:if test="${res.review == 'OK'}">
						<td><button  class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/review/reviewForm.do?resNo=${res.resNo}'" >리뷰작성</button></td> 
					</c:if>
					<c:if test="${res.review != 'OK'}">
						<td></td> 
					</c:if>  
				</tr>
			</c:forEach>
		</tbody>
	</table>	
</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>