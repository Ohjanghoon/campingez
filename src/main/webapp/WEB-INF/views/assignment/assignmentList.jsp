<%@page import="java.time.Duration"%>
<%@page import="com.kh.campingez.campzone.model.dto.CampPhoto"%>
<%@page import="com.kh.campingez.reservation.model.dto.Reservation"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.campingez.assignment.model.dto.Assignment"%>
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
<%
	List<Assignment> assignList = (List<Assignment>) request.getAttribute("assignmentList");
%>
<sec:authorize access="isAuthenticated()">
<form:form action="${pageContext.request.contextPath}/assignment/assignmentForm.do" method="POST">
	<input type="hidden" name="userId" value='<sec:authentication property="principal.username"/>' />
	<button type="submit" id="btn-assignment-enroll">양도하기</button>
</form:form>
</sec:authorize>
<%
	for(Assignment assign : assignList){
		pageContext.setAttribute("assign", assign);
		Reservation res = assign.getReservation();
		pageContext.setAttribute("res", res);
		
		CampPhoto photo = assign.getCampPhoto();
		pageContext.setAttribute("photo", photo);
%>
	<div name="assignInfo">
		<div name="userInfo">
			<span>${assign.userId}</span>	<!-- 양도 작성자 -->
			<span name="assignDate">${assign.assignDate}</span> <!-- 양도글 등록일자 -->

		</div>
		<div name="campPhoto">
			<img src="${pageContext.request.contextPath}/resources/upload/campPhoto/${photo.originalFilename}" alt="구역사진" />
		</div>
		<div name="assignTitle">
			<span>${assign.assignTitle}</span>	<!-- 양도글 제목 -->
			<span>${assign.assignState}</span>	<!-- 양도상태 -->
			<br />
			<span>양도마감일</span>
			<span><%= (res.getResCheckin()).minusDays(1) %></span>	<!-- 양도마감일 -->
		</div>
		<div name="resInfo">
			<span>예약일자</span>
				<strong>입실 : ${res.resCheckin} / 퇴실 : ${res.resCheckout}</strong>
				<span>
				<%
					int betDay = (int) Duration.between(res.getResCheckin().atStartOfDay(), res.getResCheckout().atStartOfDay()).toDays();
					String schedule = betDay + "박" + (betDay+1) + "일";
				%>
				(<%= (schedule) %>)</span>
			<br />
			<span>구역</span>
			<span>
				<c:choose>
					<c:when test="${fn:startsWith(assign.resNo, 'ZA')}">데크존🌳</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${fn:startsWith(assign.resNo, 'ZB')}">반려견존🐕</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${fn:startsWith(assign.resNo, 'ZC')}">글램핑존🏕️</c:when>
				</c:choose>
				<c:choose>
					<c:when test="${fn:startsWith(assign.resNo, 'ZD')}">카라반존🚙</c:when>
				</c:choose>
			</span>
			<br />
			<span>자리번호 ${assign.reservation.campId}</span>
			<br />
			<span>양도금액 <fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</span>
		</div>
	</div>
	
	<hr />
<%
	}
%>
	<script>
	window.onload = () => {
		
		document.querySelectorAll("[name=assignDate]").forEach((span) => {
			let assignDate = span.innerHTML; 

			span.innerHTML = beforeTime(assignDate);
		});
	};
	
	
	const beforeTime = (assignDate) => {
		  const millis = new Date().getTime() - new Date(assignDate).getTime();
		  
		  const seconds = Math.floor(millis / 1000);
		  if (seconds < 60) {
			  return "방금 전";
		  }
		  const minutes = Math.floor(seconds / 60);
		  if (minutes < 60) {
			  return `\${minutes}분 전`;
		  }
		  const hours = Math.floor(minutes / 60);
		  if (hours < 24) {
			  return `\${hours}시간 전`;
		  }
		  const days = Math.floor(hours / 24);
		  if (days < 7) {
			  return `\${days}일 전`;
		  }
		  const weeks = Math.floor(days / 7);
		  if (weeks < 5) {
			  return `\${weeks}주 전`;
		  }
		  const months = Math.floor(days / 30);
		  if (months < 12) {
			  return `\${month}개월 전`;
		  }
		  const years = Math.floor(days / 365);
		  return `\${years}년 전`;
		}
	</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>