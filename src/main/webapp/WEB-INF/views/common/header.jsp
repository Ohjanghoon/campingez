<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
</head>
<body>

	<sec:authorize access="isAnonymous()">
		<button type="button"
			onclick="location.href='${pageContext.request.contextPath}/user/userLogin.do';">로그인</button>
		&nbsp;
		<button type="button"
			onclick="location.href='${pageContext.request.contextPath}/user/userEnroll.do';">회원가입</button>
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		<span> <a
			href="${pageContext.request.contextPath}/member/memberDetail.do">
				<sec:authentication property="principal.username" /> <sec:authentication
					property="authorities" />
		</a>님, 안녕하세요 ❤❤
		</span>
				    	&nbsp;
	<button type="button"
			onclick="location.href='${pageContext.request.contextPath}/user/userEnroll.do';">쿠폰함</button>
		<form action="${pageContext.request.contextPath}/user/userLogout.do"
			method="POST">
			<button type="submit">로그아웃</button>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}" />
		</form>
	</sec:authorize>

	<ul>
		<li><a href="${pageContext.request.contextPath}/reservation/intro.do">예약</a></li>
		<li><a href="${pageContext.request.contextPath}/trade/tradeList.do">중고거래</a></li>
		<li><a href="${pageContext.request.contextPath}/inquire/inquireList.do">1대1 문의</a></li>
		<li><a href="${pageContext.request.contextPath}/assignment/assignmentList.do">양도</a></li>
		<li><a href="${pageContext.request.contextPath}/review/reviewList.do">리뷰</a></li>
		<li><a
			href="${pageContext.request.contextPath}/reservation/list.do">예약</a></li>
		<li><a
			href="${pageContext.request.contextPath}/trade/tradeList.do">중고거래</a></li>
		<li><a
			href="${pageContext.request.contextPath}/inquire/inquireList.do">1대1
				문의</a></li>
		<li><a
			href="${pageContext.request.contextPath}/assignment/assignmentList.do">양도</a></li>
		<li><a
			href="${pageContext.request.contextPath}/review/reviewList.do">리뷰</a></li>
		<li><a
			href="${pageContext.request.contextPath}/reservation/list.do">예약</a></li>
		<li><a
			href="${pageContext.request.contextPath}/trade/tradeList.do">중고거래</a></li>
		<li><a
			href="${pageContext.request.contextPath}/inquire/inquireList.do">1대1
				문의</a></li>
		<li><a
			href="${pageContext.request.contextPath}/assignment/assignmentList.do">양도</a></li>
		<li><a
			href="${pageContext.request.contextPath}/review/reviewList.do">리뷰</a></li>
		<li><a
			href="${pageContext.request.contextPath}/reservation/list.do">예약</a></li>
		<li><a
			href="${pageContext.request.contextPath}/trade/tradeList.do">중고거래</a></li>
		<li><a
			href="${pageContext.request.contextPath}/inquire/inquireList.do">1대1
				문의</a></li>
		<li><a
			href="${pageContext.request.contextPath}/assignment/assignmentList.do">양도</a></li>
		<li><a
			href="${pageContext.request.contextPath}/review/reviewList.do">리뷰</a></li>
		<li><a
			href="${pageContext.request.contextPath}/reservation/list.do">예약</a></li>
		<li><a
			href="${pageContext.request.contextPath}/trade/tradeList.do">중고거래</a></li>
		<li><a
			href="${pageContext.request.contextPath}/inquire/inquireList.do">1대1
				문의</a></li>
		<li><a
			href="${pageContext.request.contextPath}/assignment/assignmentList.do">양도</a></li>
		<li><a
			href="${pageContext.request.contextPath}/review/reviewList.do">리뷰</a></li>
		<li><a
			href="${pageContext.request.contextPath}/reservation/list.do">예약</a></li>
		<li><a
			href="${pageContext.request.contextPath}/trade/tradeList.do">중고거래</a></li>
		<li><a
			href="${pageContext.request.contextPath}/inquire/inquireList.do">1대1
				문의</a></li>
		<li><a
			href="${pageContext.request.contextPath}/assignment/assignmentList.do">양도</a></li>
		<li><a
			href="${pageContext.request.contextPath}/review/reviewList.do">리뷰</a></li>
		<li><a href="${pageContext.request.contextPath}/admin/admin.do">관리자</a></li>
		<li><a href="${pageContext.request.contextPath}/notice/list.do">공지사항</a></li>
	</ul>