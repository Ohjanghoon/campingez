<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="캠핑이지" name="title"/>
</jsp:include>

<form:form action="${pageContext.request.contextPath}/assignment/assignmentEnroll.do" method="POST">
	<input type="hidden" name="userId" value='<sec:authentication property="principal.username"/>' />
	<button type="submit" id="btn-assignment-enroll">양도하기</button>
</form:form>
<c:forEach items="${assignmentList}" var="assign">
	<div name="assignInfo">
		<div name="userInfo">
			<span>${assign.userId}</span>	<!-- 양도 작성자 -->
			<span name="assignDate">${assign.assignDate}</span> <!-- 양도글 등록일자 -->
		</div>
		<hr />
		<div name="campPhoto">
			<img src="${pageContext.request.contextPath}/resources/upload/campPhoto/${assign.campPhoto.originalFilename}" alt="" />
		</div>
		<hr />
		<div name="assignTitle">
			<span>${assign.assignTitle}</span>	<!-- 양도글 제목 -->
			<span>${assign.assignState}</span>	<!-- 양도상태 -->
			<br />
			<span>양도마감일 ${assign.reservation.resCheckin}</span>	<!-- 양도마감일 -->
		</div>
		<hr />	
		<div name="resInfo">
			<span>예약일자 <strong>입실 : ${assign.reservation.resCheckin} / 퇴실 : ${assign.reservation.resCheckout}</strong></span>
			<br />
			<span>구역 
				<c:choose>
					<c:when test="${assign.campPhoto.zoneCode == 'ZA'}">데크존🌳</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${assign.campPhoto.zoneCode == 'ZB'}">반려견존🐕</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${assign.campPhoto.zoneCode == 'ZC'}">글램핑존🏕️</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${assign.campPhoto.zoneCode == 'ZD'}">카라반존🚙</c:when>
				</c:choose>
			</span>
			<br />
			<span>자리번호 ${assign.reservation.campId}</span>
			<br />
			<span>양도금액 <fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</span>
		</div>
	</div>
</c:forEach>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>