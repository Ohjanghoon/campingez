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
<style>
#applyForm-continer hr {
	margin: 1rem 0 0;
}
#applyForm-continer th {
	width : 20%;
	text-indent : 1.1rem;
	vertical-align : middle;
}
#applyForm-continer #tbl-apply #resPerson {
	width: 10%;
}
#applyForm-continer #tbl-apply #carNo {
	display : inline;
}
#applyForm-continer #tbl-apply span {
	font-size : 12px !important;
}


</style>
<div class="container w-75 top" id="applyForm-continer">
	
	<sec:authorize access="isAuthenticated()">
		<sec:authentication property='principal.username' var="loginUser"/>
		<c:if test="${loginUser eq assign.assignTransfer}" var="transferCheck"></c:if>
	</sec:authorize>
	<!-- 양도 정보 -->
	<div class="mx-auto my-5" id="assignInfo">
		<strong class="fs-3">양도정보</strong>
		<hr />
		<table class="table">
			<tr>
				<th>양도마감일</th>
				<td><%= lastDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %></td>
			</tr>
			<tr>
				<th>구역</th>
				<td>
					<c:choose>
						<c:when test="${fn:startsWith(assign.resNo, 'ZA')}"><span>데크존&nbsp;🌳</span></c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZB')}"><span>반려견존&nbsp;🐕</span></c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZC')}"><span>글램핑존&nbsp;🏕️</span></c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZD')}"><span>카라반존&nbsp;🚙</span></c:when>
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
	</div>
		
	<!-- 예약 정보 -->
	
	<form:form 
	 	name="assignmentApplyForm"
	 	method="post"
		action="${pageContext.request.contextPath}/assignment/assignmentApply.do">
		<input type="hidden" name="assignNo" value="${assign.assignNo }" />
		<%-- <input type="hidden" name="resNo" value="${assign.resNo}"/> --%>
		<input type="hidden" name="campId" value="${res.campId}" />
		<input type="hidden" name="userId" value="${loginUser}" />
		<input type="hidden" name="resPrice" value="${assign.assignPrice}" />
		<input type="hidden" name="checkin" value="${res.resCheckin}"/>
		<input type="hidden" name="checkout" value="${res.resCheckout}" />
		<div class="mx-auto my-5">
		<strong class="fs-3">예약 정보</strong>
		<hr />
			<table class="table" id="tbl-apply">
				<tr>
					<th>예약자명</th>
					<td>
						<input type="text" class="form-control w-50" name="resUsername" required/>
						<span><i class="fa-solid fa-circle-exclamation"></i> 예약자명과 입금자명이 동일해야 합니다.</span>
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<td><input type="text" class="form-control w-50" name="resPhone" maxlength="11" required /></td>
				</tr>
				<tr>
					<th>예약인원</th>
					<td>
						<input type="number" class="form-control" name="resPerson" id="resPerson" min="1" max="6" value="1" required />
						<span><i class="fa-solid fa-circle-exclamation"></i> 최대숙박인원 : 6명</span>
					</td>
				</tr>
				<tr>
					<th>차량유무</th>
					<td>
						<input type="radio" name="carExist" id="carN" checked />
						<label class="py-2" for="carN">없음</label>
						<input type="radio" name="carExist" id="carY" value="Y" />
						<label for="carY">있음</label>
						<input type="hidden" class="form-control w-25" name="resCarNo" id="carNo" value="" required/>
					</td>
				</tr>
				<tr>
					<th>예약 요청사항</th>
					<td><input type="text" class="form-control w-50" name="resRequest" /></td>
				</tr>
			</table>
		</div>
		<div>
			<strong class="fs-3">결제방법 선택</strong>
			<hr />
			<table class="table">
				<tr>
					<th>결제금액</th>
					<td><fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</td>
				</tr>
				<tr>
					<th>결제수단</th>
					<td>
						<input type="radio" name="resPayment" id="card" value="카드" checked/>
						<label for="card">카드</label>
						<input type="radio" name="resPayment" id="vbank" value="무통장입금" />
						<label for="vbank">무통장입금</label>
					</td>
				</tr>
			</table>
		</div>		
		<div class="my-5 text-center">
			<button type="submit" class="w-75 py-2 mx-auto btn btn-outline-dark" id="btn-assign-apply">결제하기</button>
		</div>	
	</form:form>

</div>
<script>
const assignTransferCheck = () => {
	//const transfer = '${assign.assignTransfer}';
	//console.log(transfer);
	
	console.log(${transferCheck});
	if(!${transferCheck}){
		alert("다시 시도 바랍니다.");
		location.href='${pageContext.request.contextPath}/';
	}
	
	
	
}

setInterval(() => location.reload(), 1000 * 60 * 10);
window.onload = () => {
	assignTransferCheck();
}

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

document.querySelector("#resPerson").addEventListener('blur', (e) => {
	const person = e.target;
	
	if(person.value < 1){
		person.value = 1;
	}
	if(person.value > 6){
		alert("최대 숙박가능인원은 6명입니다.\n추가인원은 관리자에게 문의부탁드립니다.");
		person.value = 6;
	}
});

document.assignmentApplyForm.addEventListener('submit', (e) => {
	const str = "양도받기는 10분이내에 결제하셔야 합니다.\n" + "결제를 진행하시겠습니까?"; 
	const frm = document.assignmentApplyForm;
	
	if(!confirm(str)){
		e.preventDefault();
		return false;
	}
});

//화면 로드시 스크롤 이동
$(document).ready(function () {
	$('html, body, .container').animate({scrollTop: $('#myCarousel').outerHeight(true) - $('.blog-header').outerHeight(true) }, 'fast');
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>