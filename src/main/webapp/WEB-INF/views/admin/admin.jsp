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

	<h2>관리자페이지</h2>
	
	<ul>
		<li><a href="${pageContext.request.contextPath}/admin/reservationList.do">예약관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/inquireList.do">1:1문의 답변</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/campZoneList.do">캠핑구역관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/insertCampZone.do">캠핑구역추가</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/campList.do">캠핑자리관리</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/couponList.do">쿠폰</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/stats.do">통계</a></li>
	</ul>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>