<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.Duration"%>
<%@page import="com.kh.campingez.campzone.model.dto.CampPhoto"%>
<%@page import="com.kh.campingez.reservation.model.dto.Reservation"%>
<%@page import="com.kh.campingez.assignment.model.dto.Assignment"%>
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

<%
	Assignment assign = (Assignment) request.getAttribute("assign");
	Reservation res = assign.getReservation();
	List<CampPhoto> photos = assign.getCampPhotos();
	
	pageContext.setAttribute("res", res);
	pageContext.setAttribute("photos", photos);
	
	int betDay = (int) Duration.between(res.getResCheckin().atStartOfDay(), res.getResCheckout().atStartOfDay()).toDays();
	String schedule = betDay + "박" + (betDay+1) + "일";
	
	LocalDateTime lastDate = (res.getResCheckin().atStartOfDay()).minusDays(1);
%>
<div class="container">


	<h1>양도 상세 조회</h1>
	<h2>양도 글</h2>
		<span>제목</span>
		<span>${assign.assignTitle}</span>
		<br />
		<span>내용</span>
		<span>${assign.assignContent}</span>
	<h2>양도 정보</h2>
	<div class="assignInfo">
		<span>양도마감일</span>
		<span><%= lastDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %></span>	<!-- 양도마감일 -->
		<br />
		<img src="${pageContext.request.contextPath}/resources/upload/campPhoto/${photo.renamedFilename}" width="200px" alt="구역사진" />
		<br />
		<span>구역</span>
		<span>
			<c:choose>
				<c:when test="${fn:startsWith(assign.resNo, 'ZA')}">데크존🌳</c:when>
				<c:when test="${fn:startsWith(assign.resNo, 'ZB')}">반려견존🐕</c:when>
				<c:when test="${fn:startsWith(assign.resNo, 'ZC')}">글램핑존🏕️</c:when>
				<c:when test="${fn:startsWith(assign.resNo, 'ZD')}">카라반존🚙</c:when>
			</c:choose>
		</span>
		<br />
		<span>자리 번호</span>
		<span>${res.campId}</span>
		<br />
		<span>기간</span>
		<span>${res.resCheckin} ~ ${res.resCheckout} (<%= schedule %>)</span>
		<br />
		<span>예약금액</span>
		<span><fmt:formatNumber value="${res.resPrice}" pattern="#,###"/>원</span>
		<br />
		<span>양도금액</span>
		<span><fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</span>
	</div>
	<div>
		<h3>양도거래 시 유의사항</h3>
		<ul>
			<li></li>
			<li></li>
			<li></li>
		</ul>
	</div>
	<form:form
		action="${pageContext.request.contextPath}/assignment/assignmentApply.do"
		method="post"
		name="assignApplyForm">
		<input type="hidden" name="assignNo" value="${assign.assignNo}" />
		<button type="submit" id="btn-assign-form">해당 예약 양도받기</button>
	</form:form>
</div>
	
	<script>
	document.assignApplyForm.addEventListener('submit', (e) => {
		const str = "양도받기는 20분이내에 결제하셔야 합니다.\n" + "양도받기를 진행하시겠습니까?"; 
		
		if(!confirm(str)){
			e.preventDefault();
			return false;
		}
	});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>