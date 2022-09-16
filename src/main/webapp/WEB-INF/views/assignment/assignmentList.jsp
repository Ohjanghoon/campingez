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
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/assignment/assignmentList.css" />
<%
	List<Assignment> assignList = (List<Assignment>) request.getAttribute("assignmentList");
%>
<div class="container">

	<sec:authorize access="isAuthenticated()">
	<div class="text-center">
		<form:form action="${pageContext.request.contextPath}/assignment/assignmentForm.do" method="POST">
			<input type="hidden" name="userId" value='<sec:authentication property="principal.username"/>' />
			<button type="submit" class="w-50 mb-3 fs-5 btn btn-block" id="btn-assignment-enroll">양도 등록</button>
		</form:form>
	</div>
	</sec:authorize>
<%
	for(Assignment assign : assignList){
		pageContext.setAttribute("assign", assign);
		
		Reservation res = assign.getReservation();
		pageContext.setAttribute("res", res);
		
		List<CampPhoto> photos = assign.getCampPhotos();
		pageContext.setAttribute("photos", photos);
		
		int betDay = (int) Duration.between(res.getResCheckin().atStartOfDay(), res.getResCheckout().atStartOfDay()).toDays();
		String schedule = betDay + "박" + (betDay+1) + "일";
%>
	
		<div class="w-50 mt-4 mx-auto card" name="assignInfo" data-no="${assign.assignNo}">
			<div class="py-2 d-flex justify-content-around" name="userInfo">
				<!-- 양도 작성자 -->
				<span>
					<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					  <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					  <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
					</svg>
					${assign.userId}
				</span>
				<!-- 양도글 등록일자 -->
				<span class="assignDate text-secondary">${assign.assignDate}</span>
			</div>
			<div class="img-wrapper">
		  	<c:forEach items="${photos}" var="photo" varStatus="vs">
					<div>
						<img class="w-100" src="${pageContext.request.contextPath}/resources/upload/campPhoto/${photo.renamedFilename}" alt="" />
					</div>
		  	</c:forEach>
			</div>
			
			<table class="assignTitle mx-3 mt-3 " name="assignTitle">
				<tr>
					<th class="fs-4">${assign.assignTitle}</th> <!-- 양도글 제목 -->
					<td class="d-flex justify-content-end">
						<strong class="assignState">⏳&nbsp;${assign.assignState}</strong>
					</td>
				</tr>
				<tr>
					<td>양도마감일 <%= (res.getResCheckin()).minusDays(1) %></td> <!-- 양도마감일 -->
				</tr>
			</table>
			
			<!-- 예약 정보 -->
			<table class="m-3" name="resInfo">
				<tr>
					<th>예약일자</th>
					<td>입실 : ${res.resCheckin} / 퇴실 : ${res.resCheckout} (<%= (schedule) %>)</td>
				</tr>
				<tr>
					<th>구역</th>
					<td>
						<c:choose>
							<c:when test="${fn:startsWith(assign.resNo, 'ZA')}">데크존🌳</c:when>
							<c:when test="${fn:startsWith(assign.resNo, 'ZB')}">반려견존🐕</c:when>
							<c:when test="${fn:startsWith(assign.resNo, 'ZC')}">글램핑존🏕️</c:when>
							<c:when test="${fn:startsWith(assign.resNo, 'ZD')}">카라반존🚙</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>자리번호</th>
					<td>${assign.reservation.campId}</td>
				</tr>
				<tr>
					<th>양도금액</th>
					<td><fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</td>
				</tr>
			</table>
		</div>
<%
	}
%>
	</div>
	<script>
	window.onload = () => {
		
		document.querySelectorAll(".assignDate").forEach((span) => {
			let assignDate = span.innerHTML; 

			span.innerHTML = beforeTime(assignDate);
		});
		
	};
	
    $(document).ready(function(){
      $('.img-wrapper').slick({
    	  infinite: true,
    	  autoplay: true,
          autoplaySpeed: 2000,
          cssEase: 'linear',
          prevArrow : false,
          nextArrow : false
          
      });
    });
	
	document.querySelectorAll("[name=assignInfo]").forEach((assignInfo) => {
		
		assignInfo.addEventListener('click', (e) => {
			//console.log(assignInfo.dataset.no);
			const no = assignInfo.dataset.no;
			if(no){
				location.href="${pageContext.request.contextPath}/assignment/assignmentDetail.do?assignNo=" + no;
			}
		});
	});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>