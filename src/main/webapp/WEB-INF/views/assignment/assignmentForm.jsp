<%@page import="java.util.Date"%>
<%@page import="com.kh.campingez.reservation.model.dto.Reservation"%>
<%@page import="java.util.List"%>
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

<style>
#enrollForm-container th {
	width : 30%;
	text-indent : 1.1rem;
	vertical-align : middle;
}

#enrollForm-container #tbl-assignInfo th{
	width : 22%
}

#check {
	width : 1.1rem;
	height : 1.1rem;
	vertical-align : middle;
	accent-color : #A8A4CE;
}
</style>
<div class="container w-75 top" id="enrollForm-container">
	<!-- 양도 등록 -->
	<div class="mx-auto my-5" id="assignEnroll">
		<strong class="fs-3"><i class="fa-solid fa-campground"></i> 양도 가능 예약</strong>
		<hr />
		<p><strong>양도할 예약을 선택하세요.</strong></p>
		<select class="form-select w-50" name="choiceRes" id="choiceRes">
			<c:if test="${empty reservationList}">
				<option>양도 가능한 예약이 없습니다.</option>
			</c:if>
			<c:if test="${not empty reservationList}">
				<option value="">(예약번호) 입실일자 ~ 퇴실일자</option>
				<c:forEach items="${reservationList}" var="res">
					<option value="${res.resNo}">(${res.resNo}) ${res.resCheckin} ~ ${res.resCheckout}</option>
				</c:forEach>
			</c:if>
		</select>
	</div>
	
	<!-- 예약정보 -->
	<div class="my-5" id="resInfo">
		<strong class="fs-3"><i class="fa-solid fa-campground"></i> 예약정보</strong>
		<hr />
		<div>
			<table class="table w-75" id="tbl-resInfo">
			</table>
		</div>
	</div>
	
	<!-- 양도 등록 정보 -->
	<div id="assignForm">
		<strong class="fs-3"><i class="fa-solid fa-campground"></i> 양도등록 정보</strong>
		<hr />
		<form:form
			name="assignEnrollForm"
			action="${pageContext.request.contextPath}/assignment/assignmentEnroll.do"
			method="POST">
			<input type="hidden" name="userId" value="<sec:authentication property='principal.username'/>" />
			<table class="table" id="tbl-assignInfo">
			<tr>
				<th>예약번호</th>
					<td><input class="form-control" type="text" name="resNo" value="" readonly required/></td>
				</tr>				
				<tr>
					<th>제목</th>
					<td><input class="form-control" type="text" name="assignTitle" value="" required/></td>
				</tr>
				<tr>
					<th>양도내용</th>
					<td>
						<textarea class="form-control" name="assignContent" cols="30" rows="10" placeholder="양도사유를 작성해주세요." required></textarea>
					</td>
				</tr>
				<tr>
					<th>양도금액</th>
					<td>
					<input type="number" class="form-control w-25" id="assignPrice" min="0" name="assignPrice" value="" step="1000"required/>
					</td>
				</tr>
			</table>
			<div class="mx-auto my-5">
				<strong class="fs-3"><i class="fa-solid fa-house-circle-exclamation"></i> 양도거래 등록 시 유의사항</strong>
				<div class="card p-3 mt-2">
				<ul>
					<li class="my-2">
						<strong># 캠핑이지 양도 서비스 이외의 카페나 중고마켓등에 양도를 올려 중복 양도거래가 발생할 경우, 예약건의 소유권은 양수자에게 있으며 양도 성사건에 대해서 캠핑이지에서는 취소해 드릴 수 없음을 알려 드립니다.</strong>
					</li>
					<li class="my-2">
						<strong># 단순 변심으로 인한 양도거래를 취소할 경우, 양도대기중인 양도건에 한해서 취소 가능합니다 </strong>
					</li>
				</ul>
				</div>
					<input type="checkbox"name="check" id="check" />
					<label class="align-middle" for="check"> 양도거래 유의사항을 확인하였습니다.</label>
			</div>
			<div class="text-center">
				<button class="btn btn-outline-dark" type="submit" id="btn-assign-enroll">양도등록</button>
			</div>
		</form:form>
	</div>
	
</div>
<script>
document.querySelector("#choiceRes").addEventListener('change', (e) => {
	const resInfo = document.querySelector("#tbl-resInfo");
	const frm = document.assignEnrollForm;
	
	const resNo = e.target.value;
	if(!resNo){
		resInfo.innerHTML = '';
		frm.reset();
		return;
	}
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	
	$.ajax({
		url : '${pageContext.request.contextPath}/assignment/resInfo.do',
		headers,
		method : 'POST',
		data : {resNo},
		success(response) {
			//console.log(response);
			let {resNo, campId, resCheckin, resCheckout, resPerson, resPrice, resCarNo} = response;
			const zoneCode = zoneCodeKr(resNo.substr(0, 2));
			
			const checkin = new Date(resCheckin);
			const checkout = new Date(resCheckout);
			
			resCheckin = formatDate(checkin);
			resCheckout = formatDate(checkout);
			const schedule = calSchedule(checkin, checkout); 
			
			if(!resCarNo) {
				resCarNo = 'X';
			}
			resPrice = resPrice.toLocaleString('ko-KR');
			
			resInfo.innerHTML = `
				<tr>
					<th>예약번호</th>
					<td>\${resNo}</td>
				</tr>
				<tr>
					<th>구역</th>
					<td>\${zoneCode}</td>
				</tr>
				<tr>
					<th>자리번호</th>
					<td>\${campId}</td>
				</tr>
				<tr>
					<th>입실일 / 퇴실일</th>
					<td>\${resCheckin} ~ \${resCheckout} (\${schedule})</td>
				</tr>
				<tr>
					<th>예약인원</th>
					<td>\${resPerson}명</td>
				</tr>
				<tr>
					<th>차량등록</th>
					<td>\${resCarNo}</td>
				</tr>
				<tr>
					<th>예약금액</th>
					<td>\${resPrice}원</td>
				</tr>
			`;
			
			const frm = document.assignEnrollForm;
			frm.resNo.value = resNo;
			console.log(resPrice, typeof resPrice);
			frm.assignPrice.value = resPrice.replace(",", "");
		
		},
		error : console.log
		
	});
	
	
});

const zoneCodeKr = (zoneCode) => {
	switch(zoneCode) {
	case 'ZA' : return '데크존🌳';
	case 'ZB' : return '반려견존🐕';
	case 'ZC' : return '글램핑존🏕️';
	case 'ZD' : return '카라반존🚙';
	}
};

const formatDate = (val) => {
	const yyyy = val.getFullYear();
	const MM = val.getMonth() + 1;
	const dd = val.getDate();
	
	return yyyy + "." + MM + "." + dd;
};

const calSchedule = (date1, date2) => {
	const date = (date2 - date1) / 1000 / 60 / 60 / 24; 
	return date + '박' + (date + 1) + '일';
};

document.querySelector("#tbl-assignInfo").addEventListener('click', (e) => {
	const resNo = assignEnrollForm.resNo.value;
	
	if(resNo === "") {
		alert("양도할 예약을 선택해주세요.");
		document.querySelector("#choiceRes").focus();
	}
});

document.querySelector("#assignPrice").addEventListener('blur', (e) => {
	const price = e.target;
	
	if(price.value < 0){
		price.value = 0;
	}
});


document.assignEnrollForm.addEventListener('submit', (e) => {
	const check = document.querySelector("#check");
	
	if(!check.checked){
		e.preventDefault();
		alert("유의사항을 확인하고 체크 부탁드립니다.");
		return;
	}
	const frm = document.assignEnrollForm;
	const resNo = frm.resNo.value;
	const assignPrice = parseInt(frm.assignPrice.value);
	
	const checkConfirm = confirm(`-------------------------------
예약번호 : \${resNo}
양도금액 : \${assignPrice.toLocaleString('ko-KR')}원
-------------------------------
양도 등록하시겠습니까?`);
		
	if(!checkConfirm) {
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