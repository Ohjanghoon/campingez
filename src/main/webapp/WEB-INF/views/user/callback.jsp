<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>네이버 아이디 로그인 성공하셨습니다!!</h2>
	<h3>'${sessionId}' 님 환영합니다!</h3>
	<h3>
		<a href="logout">로그아웃</a>
	</h3>
	
	<span>${result}</span>
</body>
</html>