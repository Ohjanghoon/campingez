<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userTest.do';">로그인</button>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userEnroll.do';">회원가입</button>
	<form action="${pageContext.request.contextPath}/user/userLogout.do" method="POST">
		<button type="submit">로그아웃</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>	
	
	<ul>
		<li><a href="${pageContext.request.contextPath}/admin/admin.do">관리자</a></li>
	</ul>