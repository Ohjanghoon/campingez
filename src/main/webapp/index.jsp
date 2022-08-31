<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>캠핑이지</h1>

	<button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userTest.do';">test</button>
	<button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userEnroll.do';">회원가입</button>
	<form action="${pageContext.request.contextPath}/user/userLogout.do" method="POST">
		<button type="submit">로그아웃</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>	
	
	<ul>
		<li><a href="${pageContext.request.contextPath}/admin/admin.do">관리자</a></li>	
	</ul>
</body>
</html>