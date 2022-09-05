<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>

<main>
	<section>
		<h2>예약관리</h2>
		
		<div id="search-bar">
			<form action="${pageContext.request.contextPath}/admin/reservationListBySelectType.do" method="GET" name="searchFrm">
				<select name="searchType" id="res_date">
					<option value="res_date" ${param.searchType eq 'res_date' ? 'selected' : ''}>예약일자</option>
					<option value="res_checkin" ${param.searchType eq 'res_checkin' ? 'selected' : ''}>입실일자</option>
					<option value="res_checkout" ${param.searchType eq 'res_checkout' ? 'selected' : ''}>퇴실일자</option>
				</select>
				
				<input type="date" name="startDate" id="startDate" value="${param.startDate == null ? date.startDate : param.startDate}" />
				-
				<input type="date" name="endDate" id="endDate" value="${param.endDate == null ? date.endDate : param.endDate}" />
				<button type="button" id="search-btn">검색</button>
			</form>
		</div>
		
		<div id="result-bar">
			<table>
				<thead>
					<tr>
						<th>No</th>
						<th>예약번호</th>
						<th>회원아이디</th>
						<th>예약자명</th>
						<th>전화번호</th>
						<th>인원수</th>
						<th>가격</th>
						<th>예약일자</th>
						<th>입실일</th>
						<th>퇴실일</th>
						<th>차량번호</th>
						<th>예약상태</th>
						<th>결제수단</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty reservationList}">
						<c:forEach items="${reservationList}" var="reservation" varStatus="vs">
							<tr>
								<td>${vs.count}</td>
								<td>${reservation.resNo}</td>
								<td>${reservation.userId}</td>
								<td>${reservation.resUsername}</td>
								<td>${reservation.resPhone}</td>
								<td>${reservation.resPerson}명</td>
								<td>
									<fmt:formatNumber value="${reservation.resPrice}" type="currency"/>
								</td>
								<td>
									<fmt:parseDate value="${reservation.resDate}" var="resDate" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${resDate}" pattern="yy/MM/dd"/>
								</td>
								<td>
									<fmt:parseDate value="${reservation.resCheckin}" var="resCheckin" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${resCheckin}" pattern="yy/MM/dd"/>
								</td>
								<td>
									<fmt:parseDate value="${reservation.resCheckout}" var="resCheckout" pattern="yyyy-MM-dd"/>
									<fmt:formatDate value="${resCheckout}" pattern="yy/MM/dd"/>
								</td>				
								<td>${reservation.resCarNo ? reservation.resCartNo : "없음"}</td>				
								<td>${reservation.resState}</td>				
								<td>${reservation.resPayment}</td>				
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty reservationList}">
						<tr>
							<td colspan="13">해당 일자에 조회된 예약 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<nav>
			${pagebar}
			</nav>
		</div>
		
	</section>
</main>
<script>
document.querySelector("#search-btn").addEventListener('click', (e) => {
	const frm = document.searchFrm;
	const startDate = frm.startDate.value;
	const endDate = frm.endDate.value;
	
	if(!startDate || !endDate) {
		alert("일자를 입력해주세요.");
		return;
	}
	frm.submit();
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>