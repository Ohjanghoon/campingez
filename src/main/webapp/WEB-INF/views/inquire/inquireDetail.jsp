<%@page import="com.kh.campingez.inquire.model.dto.Answer"%>
<%@page import="com.kh.campingez.inquire.model.dto.Inquire"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
			<form:form action="${pageContext.request.contextPath}/admin/inquireAnswer.do" name="answerFrm" method="POST">
				<c:if test="${empty answer}">
					<h3>답변 작성</h3>
					
					<span>답변 내용</span>
						<textarea name="answerContent" rows="10" cols="30"></textarea>
						<input type="hidden" name="inqNo" value="${inquire.inqNo}" />
						<button id="btn-admin-answer" type="button" value="${inquire.inqNo}" onclick="enrollAnswer();">답변</button>
				</c:if>
				<c:if test="${not empty answer}">
					<button id="answer-update-btn" type="button">답변수정</button>
					<button id="answer-delete-btn" type="button" onclick="deleteAnswer(event);" value="${inquire.inqNo}">답변삭제</button>
				</c:if>
			</form:form>
		</sec:authorize>
	</div>
<script>
const enrollAnswer = () => {
	const answerContent = document.querySelector("[name=answerContent]").value;

	if(!answerContent) {
		alert("문의 내용을 입력하세요.");
		return;
	}
	document.answerFrm.submit();	
};

const deleteAnswer = (e) => {
	const inqNo = e.target.value;
	
	if(confirm(`문의번호[\${inqNo}]에 대한 답변을 정말 삭제하시겠습니까?`)) {
		const frm = document.answerFrm;
		frm.action = `${pageContext.request.contextPath}/admin/deleteAnswer.do`;
		frm.submit();
	}
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
