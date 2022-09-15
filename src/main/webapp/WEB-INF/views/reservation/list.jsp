<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css" />
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=be08c09b627993ef34b09f568ff3fc73"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<main>
	<div class="container">
		<h2 class="text-center fw-bold pt-5">예약페이지</h2>
		<div class="container col-xxl-8 px-4 py-5" id="calendar"></div>
		<div id="map" style="width:100%;height:350px;"></div>
		<br />
		<div id="list"></div>
		<div class="reservation"></div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script>
	// 달력
	document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
        	selectable: true,
        	initialView : 'dayGridMonth',
       		locale : 'ko', // 한국어 설정
       		headerToolbar : {
            	start : "prev",
            	center : "title",
            	end : "next"
            },
            defaultDate: new Date(),

            select: function(info) {
             	const date = confirm("입실일 : " + info.startStr + '\n퇴실일 : ' + (info.endStr) + " 로 예약 하시겠습니까?");
             	if(date == true){
             		let checkin = info.startStr;
            		let checkout = info.endStr;
             		console.log(checkin);
             		console.log(checkout);
             		const headers = {};
                    headers['${_csrf.headerName}'] = '${_csrf.token}';
                	const userId = "<sec:authentication property='principal.username' />";
            	 	$.ajax({
            			url : "${pageContext.request.contextPath}/reservation/list.do",
            			headers,
            			method : "POST", 
            			data : {checkin, checkout, userId},
            			success(response){
            				console.log(response);
            				
            				const list = document.querySelector("#list");
            				list.innerHTML = "";
            				
           					response.camp.forEach((camp) => {
	          					const {campId, zoneCode} = camp;
	           					const radio = `
	            					<div class="list-group list-group-checkable">
										<input class="list-group-item-check" type="radio" name="listGroupCheckableRadios" id="\${campId}" value="\${campId}">
										<label class="list-group-item py-3" for="\${campId}">
											\${campId}
										  <span class="d-block small opacity-50">With support text underneath to add more detail</span>
										</label>
	            					</div>
	            					<hr />
	           					    `;
	           					list.innerHTML += radio;
           					});
            				
            				document.querySelector(".reservation").innerHTML =`
            					<div class="row g-5">
            				    <div class="col-md-5 col-lg-4 order-md-last">
            				      <h4 class="d-flex justify-content-between align-items-center mb-3">
            				        <span class="text-primary">최종 결제 금액</span>
            				        <span class="badge bg-primary rounded-pill">1</span>
            				      </h4>
            				      <ul class="list-group mb-3">
            				        <li class="list-group-item d-flex justify-content-between lh-sm">
            				          <div>
            				            <h6 class="my-0">선택한 구역</h6>
            				            <small class="text-muted" id="zone"></small>
            				          </div>
            				          <span class="text-muted" id="zonePrice"></span>
            				        </li>
            				        <li class="list-group-item d-flex justify-content-between bg-light">
            				          <div class="text-danger">
            				            <h6 class="my-0">포인트 할인</h6>
            				            <small>적립금</small>
            				          </div>
            				          <div>
            				          <span class="text-danger" id="usepoint">0</span><span class="text-danger">P</span>
            				          </div>
            				        </li>
            				        <li class="list-group-item d-flex justify-content-between bg-light">
            				          <div class="text-danger">
            				            <h6 class="my-0">쿠폰 할인</h6>
            				            <small>쿠폰</small>
            				          </div>
            				          <div>
            				          <span class="text-danger" id="coupon">0</span><span class="text-danger">%</span>
            				          </div>
            				        </li>
            				        <li class="list-group-item d-flex justify-content-between">
            				          <span>총 결제금액</span>
            				          <strong id="resPrice"></strong>
            				        </li>
            				      </ul>
            				    </div>
            				    <div class="col-md-7 col-lg-8">
            				      <h4 class="mb-3">예약 정보 입력</h4>
            				      <form:form class="needs-validation" name="reservationFrm" action="${pageContext.request.contextPath}/reservation/insertReservatio.do" method="POST">
            				        <input type="hidden" name="userId" value="<sec:authentication property='principal.username' />"/>
            				        <input type="hidden" name="checkin" value="\${checkin}"/>
            				        <input type="hidden" name="checkout" value="\${checkout}"/>
            				        <div class="row g-3">
            				          <div class="col-12">
            				            <label for="resUsername" class="form-label">예약자 성함</label>
            				            <div class="input-group has-validation">
            				              <span class="input-group-text"><i class="fa-regular fa-face-smile"></i></span>
            				              <input type="text" class="form-control" name="resUsername" value="" placeholder="예약자 성함" required>
            				            <div class="invalid-feedback">
            				                예약자 이름을 작성해주세요.
            				              </div>
            				            </div>
            				          </div>

            				          <div class="col-12">
            				            <label for="resPhone" class="form-label">예약자 전화번호</label>
            				            <input type="text" class="form-control" name="resPhone" value="" placeholder="ex) 01012345678" required>
            				            <div class="invalid-feedback">
            				              휴대폰번호를 입력해주세요.
            				            </div>
            				          </div>

            				          <div class="col-12">
            				            <label for="resCarNo" class="form-label">차량번호</label>
            				            <input type="text" class="form-control" name="resCarNo" value="" placeholder="ex) 11가1111">
            				            <div class="invalid-feedback">
            				              차량번호를 입력해주세요.
            				            </div>
            				          </div>

            				          <div class="col-12">
            				            <label for="resRequest" class="form-label">요청사항</label>
            				            <input type="text" class="form-control" name="resRequest" value="" placeholder="요청사항을 입력하세요.">
            				          </div>

            				          <div class="col-md-5">
            				            <label for="resPerson" class="form-label">예약인원</label>
            				            <select class="form-select" id="resPerson" name="resPerson" required>
            				              <option value="1">1명</option>
            				              <option value="2">2명</option>
            				              <option value="3">3명</option>
            				              <option value="4">4명</option>
            				              <option value="5">5명</option>
            				              <option value="6">6명</option>
            				            </select>
            				            <div class="invalid-feedback">
            				              예약인원을 선택하세요.
            				            </div>
            				          </div>
            				          <hr class="my-4">
            				          <div class="col-md-7">
            				            <label for="couponList" class="form-label">쿠폰</label>
            				            <select class="form-select" id="couponList" required>
            				              <option value="0">선택안함</option>
            				            </select>
            				            <div class="invalid-feedback">
            				              쿠폰 선택
            				            </div>
            				          </div>
            				          <div class="col-md-7">
            				            <label for="point" class="form-label">포인트</label>&nbsp;(잔여 포인트 : <sec:authentication property='principal.point' />P)
            				            <input type="number" class="form-control" id="point" value="0" min="0" max="<sec:authentication property='principal.point' />" step="100">
            				            <div class="invalid-feedback">
            				              포인트 입력
            				            </div>
            				          </div>
            				        </div>
            				        <hr class="my-4">
            				        <h4 class="mb-3">결제수단</h4>
            				        <div class="my-3">
            				          <div class="form-check">
            				            <input id="credit" name="resPayment" type="radio" class="form-check-input" value="credit" checked required>
            				            <label class="form-check-label" for="credit">신용카드</label>
            				          </div>
            				          <div class="form-check">
            				            <input id="pay" name="resPayment" type="radio" class="form-check-input" value="pay" required>
            				            <label class="form-check-label" for="pay">무통장입금</label>
            				          </div>
            				        </div>
            				        <hr class="my-4">
            				        <button class="w-100 btn btn-primary btn-lg" type="button" id="doPay">결제하기</button>
            				      </form:form>
            				`;
            				
            				response.userCoupon.forEach((coupon) => {
                                const {coupons} = coupon;
                                const [{couponName, couponCode, couponDiscount}] = coupons;
                                const couponList = document.querySelector("#couponList");
                                const option = `<option value="\${couponDiscount}">[\${couponDiscount}%]\${couponName}<option/>`;
                                couponList.innerHTML += option;
                             });
            				    				
       						
            				document.querySelector("#point").addEventListener("blur", (e) => {
            					document.querySelector("#usepoint").innerHTML = e.target.value; 
            					let minuspoint = document.querySelector("#point").value;
    							let minuscoupon = couponList.value;
    						
    							let price = Number(document.querySelector("#zonePrice").innerHTML);
                				let resPrice = (price-(price*(minuscoupon/100)))-minuspoint;
                				document.querySelector("#resPrice").innerHTML = resPrice;	
            				});
            				
            				couponList.addEventListener("blur", (e) => {
            					document.querySelector("#coupon").innerHTML = e.target.value;
            					let minuspoint = document.querySelector("#point").value;
    							let minuscoupon = couponList.value;
    						
    							let price = Number(document.querySelector("#zonePrice").innerHTML);
                				let resPrice = (price-(price*(minuscoupon/100)))-minuspoint;
                				document.querySelector("#resPrice").innerHTML = resPrice;	
            				});
            				
            			
            				document.querySelector("#list").addEventListener('input', (e) => {
            					const campId = e.target.value;
            					$.ajax({
            						url : '${pageContext.request.contextPath}/reservation/campZoneInfo.do',
            						headers,
            						method : "POST",
            						data : {campId},
            						success(response){
            							console.log(response);
            							const zonePrice = response.zonePrice;
            							document.querySelector("#zonePrice").innerHTML = `\${zonePrice}`;
            							document.querySelector("#zone").innerHTML = `\${campId}`;            						

            							let minuspoint = document.querySelector("#point").value;
            							let minuscoupon = couponList.value;
            						
            							let price = Number(document.querySelector("#zonePrice").innerHTML);
                        				let resPrice = (price-(price*(minuscoupon/100)))-minuspoint;
            							
                        				document.querySelector("#resPrice").innerHTML = resPrice;
                        				
                        				document.querySelector("#doPay").addEventListener('click', (e) => {
                        					document.reservationFrm.innerHTML += `
                        						<input type="hidden" name="campId" value="\${campId}"/>
                        						<input type="hidden" name="resPrice" value="resPrice"/>
                        						<input type="hidden" name="point" value="\${minuspoint}"/>
                        					`;
                        					reservationFrm.submit();
                        				});
                        				
            						},
            						error : console.log
            					})
            				});
            			},
            			error : console.log
            		})
            	};
             }
        });
        calendar.render();
	});
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.29377, 127.66580), // 지도의 중심좌표
        level: 2 // 지도의 확대 레벨
    };
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	// 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
	map.setDraggable(false);		
	// 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
	map.setZoomable(false);   

	
</script>