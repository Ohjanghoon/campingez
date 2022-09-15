<%@page import="java.util.Collection"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.kh.campingez.user.model.dto.Authority"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.campingez.review.model.dto.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<main>
	<sec:authentication property="principal" var="loginMember" scope="page" />
	<sec:authentication property="authorities" var="auth" scope="page" />
	<section>
		<h2>리뷰상세보기</h2>
		<div id="userinfo-wrap">
			<div id="name">${review.reservation.resUsername}</div>
			<div id="enroll-date">
				<fmt:parseDate value="${review.revEnrollDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="revEnrollDate"/>
				<fmt:formatDate value="${revEnrollDate}" pattern="yyyy/MM/dd"/>
			</div>
			<div id="campinfo-wrap">
				<div id="zone-code">
					[${review.zoneCode}구역] - ${review.reservation.campId}자리
				</div>
			</div>
		</div>
		<div id="photo-wrap">
			<c:if test="${not empty review.reviewPhotos}">
				<c:forEach items="${review.reviewPhotos}" var="photo">
					<img src="${pageContext.request.contextPath}/resources/upload/review/${photo.revRenamedFilename}" width="150px"/>
				</c:forEach>
			</c:if>
		</div>
		<div id="content-wrap">
			${review.revContent}
		</div>
		<sec:authorize access="isAuthenticated()"> 
			<c:if test="${loginMember.userId eq review.reservation.userId}">
				<button id="update-btn">수정</button>
				<button id="delete-btn">삭제</button>
			</c:if>		
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMIN')">		
			<button id="update-btn">수정</button>
			<button id="delete-btn">삭제</button>
		</sec:authorize>
	</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>