<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>asdb</title>

<body>
	<h1>ㅎㅇ</h1>
	<span>
		<a href="#">
			<sec:authentication property="principal.username"/>
			<sec:authentication property="authorities"/>
		</a>님, 안녕하세요 ❤❤
	</span>
	
	<sec:authorize access="hasRole('ADMIN')">
		<a class="nav-link" href="#">관리자입니다~</a>
	</sec:authorize>
		
	<form action="${pageContext.request.contextPath}/user/userLogout.do" method="POST">
		<button type="submit">로그아웃</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>	
</body>
</html>