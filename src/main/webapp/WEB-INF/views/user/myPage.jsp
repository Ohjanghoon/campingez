<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/userInfo/userInfo.do" method="GET">
		<button type="submit">내정보 수정</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	<form action="${pageContext.request.contextPath}/userInfo/inquireList.do" method="GET">
		<button type="submit">내가 쓴 게시글</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>		
</body>
</html>