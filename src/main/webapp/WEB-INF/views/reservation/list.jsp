<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/list.css" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
	<h1>캠핑장 예약합시다.</h1>
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
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
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
					<input type="hidden" name="userId" value="<sec:authentication property='principal.username' />"/>
					<input type="hidden" name="checkin" value="\${checkin}"/>
					<input type="hidden" name="checkout" value="\${checkout}"/>
					<h3>예약자 정보</h3>
					<label for="resUsername">예약자 이름</label>
					<input type="text" name="resUsername" />
					<br />
					<label for="resPhone">예약자 전화번호</label>
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
 
</script>	