<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div>
		<span>제목</span>
		<span>${inquire.inqTitle}</span>
		<br />
		<span>작성자</span>
		<span>${inquire.inqWriter}</span>
		<br />
		<span>문의 유형</span>
		<span>${inquire.categoryId }</span>
	</div>
</body>
</html>