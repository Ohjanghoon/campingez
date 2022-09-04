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
 <script>
        function popup(){
            var url = "${pageContext.request.contextPath}/userInfo/authentication.do";
            var name = "info authentication";
            var option = "width = 500, height = 500, top = 100, left = 200, location = no"
            window.open(url, name, option);
        }
    </script>
<body>
	<div class="mypageFrm">
		<form>
		<sec:authentication property="principal" var="result" scope="page" />
			<span>아이디 : ${result.userId}</span><br>
			<span>이름 : ${result.userName}</span><br>
			<span>경고횟수 : ${result.yellowCard}</span><br>
			<span>잔여 포인트 : ${result.point}</span><br>
			<button onclick="popup()">내정보 수정</button><br>
		</form>	
	</div >
	<div class="mypageFrm">
		<form action="${pageContext.request.contextPath}/userInfo/inquireList.do" method="GET">
			
			<c:forEach items="${inquireCnt}" var="cnt" varStatus="vs">
				<c:if test="${cnt.answerStatus == 0}">
					<span>답변대기 -> ${cnt.statusCnt} 건</span><br>
				</c:if>
				<c:if test="${cnt.answerStatus == 1}">
					<span>답변완료 -> ${cnt.statusCnt} 건</span><br>
				</c:if>
			</c:forEach>
		<button type="submit">내가 쓴 게시글</button><br>
		</form>	
	</div>
	<div class="mypageFrm">
		<form action="${pageContext.request.contextPath}/userInfo/myReservation.do" method="GET">
			<span>입실예정객실</span>
			<table>
				<tr>
					<td>예약번호</td>
					<td>예약자 성명</td>
					<td>입실일자</td>
					<td>예약 상태</td>
				</tr>	
					<c:forEach items="${reservationList}" var="res" varStatus="vs">
						<tr>
							<td>${res.resNo}</td>
							<td>${res.resUsername}</td>
							<td>${res.resCheckin}</td>
							<td>${res.resState}</td>
						</tr>	
					</c:forEach>
			</table>
			<button type="submit">예약 정보 상세</button><br>		
		</form>				
	</div>
</body>
</html>