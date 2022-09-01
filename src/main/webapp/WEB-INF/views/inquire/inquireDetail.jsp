<%@page import="com.kh.campingez.inquire.model.dto.Answer"%>
<%@page import="com.kh.campingez.inquire.model.dto.Inquire"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>

<%
	Inquire inquire = (Inquire) request.getAttribute("inquire");
	Answer answer = inquire.getAnswer();
	pageContext.setAttribute("answer", answer);
%>
	<h2>문의</h2>
	<div>
		<span>제목</span>
		<span>${inquire.inqTitle}</span>
		<br />
		<span>작성자</span>
		<span>${inquire.inqWriter}</span>
		<br />
		<span>작성일자</span>
		<span>
			<fmt:parseDate value="${inquire.inqDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="inqDate" />
			<fmt:formatDate value="${inqDate}" pattern="yyyy-MM-dd HH:mm:ss" />
		</span>
		<br />
		<span>문의 유형</span>
		<span>${inquire.categoryId}</span>
		<br />
		<span>문의 내용</span>
		<span>${inquire.inqContent}</span>
	</div>
	<div>
		<button id="btn-update">수정</button>
		<button id="btn-delete">삭제</button>
	</div>
	<h2>문의 답변</h2>
	<div>
		<c:if test="${not empty answer}">
			<h3>답변</h3>
			
			<span>답변 내용</span>
			<span>${answer.answerContent}</span>
			<br />
			<span>답변일</span>
			<span>
				<fmt:parseDate value="${answer.answerDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="answerDate"/>
				<fmt:formatDate value="${answerDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			</span>
		</c:if>
		<sec:authorize access="hasRole('ROLE_ADMIN')">
			<c:if test="${empty answer}">
				<h3>답변 작성</h3>
				
				<span>답변 내용</span>
				<textarea name="answerContent" rows="10" cols="30"></textarea>
			</c:if>
		</sec:authorize>
	</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>