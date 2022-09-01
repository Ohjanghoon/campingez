<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑이지 예약</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/list.css" />
</head>
<body>
	<h1>캠핑장 예약합시다.</h1>
	<div class="sec_cal">
		<div class="cal_nav">
			<a href="javascript:;" class="nav-btn go-prev">prev</a>
			<div class="year-month"></div>
			<a href="javascript:;" class="nav-btn go-next">next</a>
		</div>
		<div class="cal_wrap">
			<div class="days">
				<div class="day">MON</div>
				<div class="day">TUE</div>
				<div class="day">WED</div>
				<div class="day">THU</div>
				<div class="day">FRI</div>
				<div class="day">SAT</div>
				<div class="day">SUN</div>
			</div>
			<div class="dates"></div>
		</div>
	</div>
	<div class="camp Date">
		<h3>예약날짜를 선택하세요</h3>
		<form name="checkDateFrm" action="" method="POST">
		<p>입실일</p>
		<input type="date" id="checkin" name="checkin" />
		<p>퇴실일</p>
		<input type="date" id="checkout" name="checkout" />
		<hr />
		<button id="btn">제출</button>
		</form>
	</div>
	<div class="camp List" id="list"></div>
	<div class="camp reservation"></div>
<script>
	
	document.checkDateFrm.addEventListener('submit', (e) => {
		e.preventDefault();
		const checkin = document.checkDateFrm.checkin.value;
		const checkout = document.checkDateFrm.checkout.value;

		const headers = {};
        headers['${_csrf.headerName}'] = '${_csrf.token}';
        
		if(checkin == 0 || checkout == 0){
			alert("날짜를 지정해주세요.");
			return;
		}
		
	 	$.ajax({
			url : "${pageContext.request.contextPath}/reservation/list.do",
			headers,
			method : "POST", 
			data : {checkin, checkout},
			success(response){
				console.log(response);
				
				const list = document.querySelector("#list");
				list.innerHTML += `<h3>예약가능한 캠핑존</h3>`
				list.innerHTML += `<select name="cl" id="cl">`;
				document.querySelector("#cl").innerHTML += `<option value="" disabled selected >선택하세요.</option>`;
				
				if(response.length){
					response.forEach((camp) => {
						const {campId, zodeCode} = camp;
					const option = `<option value="\${campId}">\${campId}</option>`;
					document.querySelector("#cl").innerHTML += option;
					});
				}
				
				document.querySelector(".reservation").innerHTML =`
					<form:form name="reservationFrm" action="${pageContext.request.contextPath}/reservation/insertReservation.do" method="POST">
					<input type="hidden" name="userId" value="honggd"/>
					<input type="hidden" name="checkin" value="\${checkin}"/>
					<input type="hidden" name="checkout" value="\${checkout}"/>
					<h3>예약자 정보</h3>
					<label for="resUsername">예약자 이름</label>
					<input type="text" name="resUsername" />
					<br />
					<label for="resPhone">예약자 번호</label>
					<input type="text" name="resPhone"/>
					<br />
					<label for="resPerson">예약 인원</label>
					<select name="resPerson" id="resPerson">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
					</select>
					<br />
					<label for="resCarNo">차량번호</label>
					<input type="text" name="resCarNo"/>
					<br />
					<label for="resRequest">요청사항</label>
					<input type="text" name="resRequest"/>
					<hr />
					<span>결제금액 = <span id="resPrice" name="resPrice"></span>원</span>
					<hr />
					<select name="resPayment" id="resPayment">
					<option value="카드">카드</option>
					<option value="무통장입금">무통장입금</option>
					</select>
					<button id="btn2">결제하기</button>
					
				</form:form>
				`;
				
				document.querySelector("#cl").addEventListener('change', (e) => {
					const campId = e.target.value;
					$.ajax({
						url : '${pageContext.request.contextPath}/reservation/campZoneInfo.do',
						headers,
						method : "POST",
						data : {campId},
						success(response){
							console.log(response);
							const zonePrice = response.zonePrice;
							document.querySelector("#resPrice").innerHTML = `\${zonePrice}`;
							document.reservationFrm.innerHTML += `
								<input type="hidden" name="campId" value="\${campId}"/>
								<input type="hidden" name="resPrice" value="\${zonePrice}"/>
							`;
						},
						error : console.log
					})
				});
			},
			error : console.log
		});
	});
 
	/* --------------------------------------------------------------------------- */
	
	$(document).ready(function() {
		calendarInit();
	});
	/*
	 달력 렌더링 할 때 필요한 정보 목록 

	 현재 월(초기값 : 현재 시간)
	 금월 마지막일 날짜와 요일
	 전월 마지막일 날짜와 요일
	 */

	function calendarInit() {

		// 날짜 정보 가져오기
		var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
		var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
		var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
		var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)

		var thisMonth = new Date(today.getFullYear(), today.getMonth(),
				today.getDate());
		// 달력에서 표기하는 날짜 객체

		var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
		var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
		var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일

		// kst 기준 현재시간
		// console.log(thisMonth);

		// 캘린더 렌더링
		renderCalender(thisMonth);

		function renderCalender(thisMonth) {

			// 렌더링을 위한 데이터 정리
			currentYear = thisMonth.getFullYear();
			currentMonth = thisMonth.getMonth();
			currentDate = thisMonth.getDate();

			// 이전 달의 마지막 날 날짜와 요일 구하기
			var startDay = new Date(currentYear, currentMonth, 0);
			var prevDate = startDay.getDate();
			var prevDay = startDay.getDay();

			// 이번 달의 마지막날 날짜와 요일 구하기
			var endDay = new Date(currentYear, currentMonth + 1, 0);
			var nextDate = endDay.getDate();
			var nextDay = endDay.getDay();

			// console.log(prevDate, prevDay, nextDate, nextDay);

			// 현재 월 표기
			$('.year-month').text(currentYear + '.' + (currentMonth + 1));

			// 렌더링 html 요소 생성
			calendar = document.querySelector('.dates')
			calendar.innerHTML = '';

			// 지난달
			for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
				calendar.innerHTML = calendar.innerHTML
						+ '<div class="day prev disable">' + i + '</div>'
			}
			// 이번달
			for (var i = 1; i <= nextDate; i++) {
				calendar.innerHTML = calendar.innerHTML
						+ '<div class="day current">' + i + '</div>'
			}
			// 다음달
			for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
				calendar.innerHTML = calendar.innerHTML
						+ '<div class="day next disable">' + i + '</div>'
			}

			// 오늘 날짜 표기
			if (today.getMonth() == currentMonth) {
				todayDate = today.getDate();
				var currentMonthDate = document
						.querySelectorAll('.dates .current');
				currentMonthDate[todayDate - 1].classList.add('today');
			}
		}

		// 이전달로 이동
		$('.go-prev').on('click', function() {
			thisMonth = new Date(currentYear, currentMonth - 1, 1);
			renderCalender(thisMonth);
		});

		// 다음달로 이동
		$('.go-next').on('click', function() {
			thisMonth = new Date(currentYear, currentMonth + 1, 1);
			renderCalender(thisMonth);
		});
	}
</script>
</body>
</html>	