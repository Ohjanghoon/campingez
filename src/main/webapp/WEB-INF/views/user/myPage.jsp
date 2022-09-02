<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
	.mypageFrm{
		width : 400px;
		height : 200px;
		border : 1px solid black;
	}
</style>
<body>

	<div class="mypageFrm">
		<form action="${pageContext.request.contextPath}/userInfo/userInfo.do" method="GET">
		<sec:authentication property="principal" var="result" scope="page" />
			<button type="submit">내정보 수정</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /><br>
			<span>아이디 : ${result.userId}</span><br>
			<span>이름 : ${result.userName}</span><br>
			<span>경고횟수 : ${result.yellowCard}</span><br>
			<span>잔여 포인트 : ${result.point}</span><br>
		</form>	
	</div >
	<div class="mypageFrm">
		<form action="${pageContext.request.contextPath}/userInfo/inquireList.do" method="GET">
			<button type="submit">내가 쓴 게시글</button><br>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			
			<c:forEach items="${inquireCnt}" var="cnt" varStatus="vs">
				<c:if test="${cnt.answerStatus == 0}">
					<span>답변대기 -> ${cnt.statusCnt} 건</span><br>
				</c:if>
				<c:if test="${cnt.answerStatus == 1}">
					<span>답변완료 -> ${cnt.statusCnt} 건</span><br>
				</c:if>
			</c:forEach>
		</form>	
	</div>
	<div class="mypageFrm">
		<form action="${pageContext.request.contextPath}/userInfo/myReservation.do" method="GET">
			<button type="submit">예약 정보 확인</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>				
	</div>
</body>
</html>