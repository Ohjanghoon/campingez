<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="com.kh.campingez.reservation.model.dto.Reservation"%>
<%@page import="java.time.Duration"%>
<%@page import="com.kh.campingez.assignment.model.dto.Assignment"%>
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
<%
	Assignment assign = (Assignment) request.getAttribute("assign");
	Reservation res = assign.getReservation();
	pageContext.setAttribute("res", res);
	
	int betDay = (int) Duration.between(res.getResCheckin().atStartOfDay(), res.getResCheckout().atStartOfDay()).toDays();
	String schedule = betDay + "박" + (betDay+1) + "일";
	
	LocalDateTime lastDate = (res.getResCheckin().atStartOfDay()).minusDays(1);
%>
<div class="container">
	<h1>양도받기</h1>
	<div id="assignInfo">
		<table>
			<tr>
				<th>양도마감일</th>
				<td><%= lastDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %></td>
			</tr>
			<tr>
				<th>구역</th>
				<td>
					<c:choose>
						<c:when test="${fn:startsWith(assign.resNo, 'ZA')}">데크존🌳</c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZB')}">반려견존🐕</c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZC')}">글램핑존🏕️</c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZD')}">카라반존🚙</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>자리번호</th>
				<td>${res.campId}</td>
			</tr>
			<tr>
				<th>기간</th>
				<td>${res.resCheckin} ~ ${res.resCheckout} (<%= schedule %>)</td>
			</tr>
			<tr>
				<th>양도금액</th>
				<td><fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</td>
			</tr>
		</table>
		
		<h2>예약 정보</h2>
		<form:form action="">
			<input type="hidden" name="resNo" value="${assign.resNo}"/>
			<input type="hidden" name="campId" value="${res.campId}" />
			<input type="hidden" name="userId" value="<sec:authentication property='principal.username'/>" />
			<input type="hidden" name="resPrice" value="${assign.assignPrice}" />
			<input type="hidden" name="resCheckin" value="${res.resCheckin}"/>
			<input type="hidden" name="resCheckout" value="${res.resCheckout}" />
			<table>
				<tr>
					<th>예약자명</th>
					<td><input type="text" name="resUsername"/></td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" name="resPhone" /></td>
				</tr>
				<tr>
					<th>숙박인원</th>
					<td><input type="number" name="resPerson" min="0" max="6"/></td>
				</tr>
				<tr>
					<th rowspan="2">차량유무</th>
					<td>
						<label for="carN"><input type="radio" name="carExist" id="carN" checked />없음</label>
						<label for="carY"><input type="radio" name="carExist" id="carY" value="Y" />있음</label>
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" name="resCarNo" id="carNo" value=""/>
					</td>
				</tr>
				<tr>
					<th>예약 요청사항</th>
					<td><input type="text" name="resRequest" /></td>
				</tr>
			</table>
			<div>
				<h2>결제방법 선택</h2>
				<p>결제 금액 : <fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</p>
				<select name="resPayment">
					<option value="card">카드</option>
					<option value="vbank">무통장입금</option>
				</select>
			</div>			
			<button type="button" id="btn-assign-apply">결제하기</button>
		</form:form>
		
	</div>
</div>

<script>
document.querySelectorAll("[name=carExist]").forEach((radio) => {
	
	radio.addEventListener('click', (e) => {
		
		const val = e.target.value;
		if(val === 'Y'){
			document.querySelector("#carNo").type = 'text';
		}
		else {
			document.querySelector("#carNo").type = 'hidden';
		}
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>