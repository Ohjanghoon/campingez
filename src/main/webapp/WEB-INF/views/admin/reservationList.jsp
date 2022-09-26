<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/admin/admin.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
			<div class="content-wrap">
				<h2 class="text-center fw-bold pt-5 pb-5">예약관리</h2>
				
				<div id="select-wrap d-flex">
					<form action="${pageContext.request.contextPath}/admin/reservationListBySelectType.do" method="GET" name="searchFrm" class="d-flex">
						<select id="searchType" name="searchType" class="form-select">
							<option value="res_date" ${param.searchType eq 'res_date' ? 'selected' : ''}>예약일자</option>
							<option value="res_checkin" ${param.searchType eq 'res_checkin' ? 'selected' : ''}>입실일자</option>
							<option value="res_checkout" ${param.searchType eq 'res_checkout' ? 'selected' : ''}>퇴실일자</option>
						</select>
						<div class="input-group input-date d-flex align-items-center" >
							<input type="date" name="startDate" id="startDate" value="${param.startDate == null ? date.startDate : param.startDate}" class="form-control" />
							&nbsp;-&nbsp;
							<input type="date" name="endDate" id="endDate" value="${param.endDate == null ? date.endDate : param.endDate}" class="form-control" />
							<button class="btn searchBtn" type="button" id="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
						</div>
					</form>
				</div>
				
					<div id="result-bar">
						<table class="table text-center" id="reservation-tbl">
							<thead>
								<tr>
									<th scope="col">예약번호</th>
									<th scope="col">회원아이디</th>
									<th scope="col">예약자명</th>
									<th scope="col">전화번호</th>
									<th scope="col">인원수</th>
									<th scope="col">가격</th>
									<th scope="col">예약일자</th>
									<th scope="col">입실일</th>
									<th scope="col">퇴실일</th>
									<th scope="col">차량번호</th>
									<th scope="col">예약상태</th>
									<th scope="col">결제수단</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty reservationList}">
									<c:forEach items="${reservationList}" var="reservation" varStatus="vs">
										<tr>
											<td scope="row">${reservation.resNo}</td>
											<td scope="row">${reservation.userId}</td>
											<td scope="row">${reservation.resUsername}</td>
	 										<td scope="row">${reservation.resPhone}</td>
											<td scope="row">${reservation.resPerson}명</td>
											<td scope="row">
	 											<fmt:formatNumber value="${reservation.resPrice}" type="currency"/>
											</td>
											<td scope="row">
												<fmt:parseDate value="${reservation.resDate}" var="resDate" pattern="yyyy-MM-dd"/>
												<fmt:formatDate value="${resDate}" pattern="yy/MM/dd"/>
											</td>
											<td scope="row">
												<fmt:parseDate value="${reservation.resCheckin}" var="resCheckin" pattern="yyyy-MM-dd"/>
												<fmt:formatDate value="${resCheckin}" pattern="yy/MM/dd"/>
											</td>
											<td scope="row">
												<fmt:parseDate value="${reservation.resCheckout}" var="resCheckout" pattern="yyyy-MM-dd"/>
												<fmt:formatDate value="${resCheckout}" pattern="yy/MM/dd"/>
											</td>				
											<td scope="row">${reservation.resCarNo ? reservation.resCartNo : "없음"}</td>				
											<td scope="row">${reservation.resState}</td>				
											<td scope="row">${reservation.resPayment}</td>				
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
			</div>
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