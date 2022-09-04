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

	<h1>양도등록</h1>
	<h2>양도할 예약을 선택하세요.</h2>
	<select name="choiceRes" id="choiceRes">
		<c:if test="${empty reservationList}">
			<option>양도 가능한 예약이 없습니다.</option>
		</c:if>
		<c:if test="${not empty reservationList}">
			<option value="">예약번호 / 입실일자 ~ 퇴실일자</option>
			<c:forEach items="${reservationList}" var="res">
			
				<option value="${res.resNo}">${res.resNo} / ${res.resCheckin} ~ ${res.resCheckout}</option>
			</c:forEach>
		</c:if>
	</select>
	<h2>예약정보</h2>
	<div>
		<table id="tbl-resInfo">
		</table>
	</div>
	<h2>양도 등록 정보</h2>
	<div>
		<form:form
			name="assignEnrollForm"
			action="${pageContext.request.contextPath}/assignment/assignmentEnroll.do"
			method="POST">
			<table id="tbl-assignInfo">
			<input type="hidden" name="userId" value="<sec:authentication property='principal.username'/>" />
			<tr>
				<th>예약번호</th>
					<td><input type="text" name="resNo" value="" readonly /></td>
				</tr>				
				<tr>
					<th>제목</th>
					<td><input type="text" name="assignTitle" value="" required/></td>
				</tr>
				<tr>
					<th>양도내용</th>
					<td>
						<textarea name="assignContent" cols="30" rows="10" placeholder="양도사유를 작성해주세요." required></textarea>
					</td>
				</tr>
				<tr>
					<th>양도금액</th>
					<td>
					<input type="number" id="assignPrice" name="assignPrice" value="" required/>
					</td>
				</tr>
				<tr>
					<td><button type="submit" id="btn-assign-enroll">양도등록</button></td>
				</tr>
			</table>
		</form:form>
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
	
	document.assignEnrollForm.addEventListener('click', (e) => {
		const resNo = assignEnrollForm.resNo.value;
		
		if(resNo == '') {
			alert("양도할 예약을 선택해주세요.");
			document.querySelector("#choiceRes").focus();
		}
	});
	
	document.assignEnrollForm.addEventListener('submit', (e) => {
		const frm = document.assignEnrollForm;
		const resNo = frm.resNo.value;
		const assignPrice = parseInt(frm.assignPrice.value);
		
		const check = confirm(`-------------------------------
예약번호 : \${resNo}
양도금액 : \${assignPrice.toLocaleString('ko-KR')}원
-------------------------------
양도 등록하시겠습니까?`);
		
		if(!check) {
			e.preventDefault();
			return false;
		}
	});
	
	
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>