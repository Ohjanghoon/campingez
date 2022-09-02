<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="캠핑이지" name="title"/>
</jsp:include>
	
	<h2>양도등록</h2>
	<h3>양도할 예약을 선택하세요.</h3>
	<select name="choiceRes" id="choiceRes">
		<option value="">예약번호 / 입실일자 ~ 퇴실일자</option>
		<c:forEach items="${reservationList}" var="res">
			<option value="${res.resNo}">${res.resNo} / ${res.resCheckin} ~ ${res.resCheckout}</option>
		</c:forEach>
	</select>
	
	<script>
	document.querySelector("#choiceRes").addEventListener('change', (e) => {
		
	});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>