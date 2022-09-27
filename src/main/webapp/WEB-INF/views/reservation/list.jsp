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
		<hr />
		<div class="container px-4 py-5" id="hanging-icons">
	    <h3 class="pb-2 border-bottom"><i class="fa-solid fa-campground"></i> 예약전 필독사항</h3>
	    <div class="row g-4 py-5 row-cols-1 row-cols-lg-1">
	      <div class="col d-flex align-items-start">
	        <div class="icon-square bg-light text-dark flex-shrink-0 me-3">
	          <i class="fa-regular fa-square-check fa-2x"></i>
	        </div>
	        <div>
	          <h5>캠핑장 운영안내</h5>
	          <strong><mark>※ 캠핑장 내 캠핑카 및 카라반 등 차량진입 불가.</mark></strong><small>(인근 주차장 이용)</small><br />
	          <strong>-이용인원 : 1사이트 당 6명까지 이용가능</strong><br />
	          <strong>※ 미승인자 무단이용시 즉시 퇴실조치 되오니, 방역수칙 및 사용인원 초과에 유의해주시기 바랍니다.</strong><br />
	          <strong>※ 화재 예방과 관련하여 캠핑장 이용 시, 불에 타고 남은 재는 확실히 소화하여 재수거함에 버리시기를 바랍니다.</strong>
	        </div>
	      </div>
	      <div class="col d-flex align-items-start">
	        <div class="icon-square bg-light text-dark flex-shrink-0 me-3">
	          <i class="fa-regular fa-square-check fa-2x"></i>
	        </div>
	        <div>
	          <h5>예약 시 유의사항</h5>
	          <strong><mark>※ 예약자와 입실자가 동일해아만합니다.</mark></strong><br />
	          <strong>※ 입실시에 관리자가 신분증 제시를 요청 할 수 있으며, 응하지 않을 시 입실이 제한될 수 있습니다.</strong>
	        </div>
	      </div>
	    </div>
	  </div>
	  
	  <div class="ccontainer px-4 py-5 ">
		  <h3 class="pb-2 border-bottom"><i class="fa-solid fa-campground"></i> 이용요금 안내</h3>
		  <div class="accordion accordion-flush" id="accordionFlushExample">
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="flush-headingOne">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
			        캠핑이지 사용료
			      </button>
			    </h2>
			    <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
			      <div class="accordion-body">
			      	<h6 class="p-3 border-bottom"><code>* 모든 구역 1일기준 (사용일 14:00 ~ 익일12:00까지) <br /><br /> * 모든 구역 인원 기준 6인 </code></h6>
			        <div class="card mb-3 mt-3" style="max-width: 540px;">
					  <div class="row g-0">
					    <div class="col-md-4">
					      <img src="${pageContext.request.contextPath}/resources/images/reservation/deck1.png" class="img-fluid rounded-start" alt="...">
					    </div>
					    <div class="col-md-8">
					      <div class="card-body">
					        <h5 class="card-title">A구역 (데크존)</h5>
					        <p class="card-text"><br /><br /><strong>25,000원</strong></p>
					      </div>
					    </div>
					  </div>
					</div>
					
			        <div class="card mb-3" style="max-width: 540px;">
					  <div class="row g-0">
					    <div class="col-md-4">
					      <img src="${pageContext.request.contextPath}/resources/images/reservation/animal1.png" class="img-fluid rounded-start" alt="...">
					    </div>
					    <div class="col-md-8">
					      <div class="card-body">
					        <h5 class="card-title">B구역 (애견동반존)</h5>
					        <p class="card-text"><br /><br /><strong>35,000원</strong></p>
					      </div>
					    </div>
					  </div>
					</div>
					
			        <div class="card mb-3" style="max-width: 540px;">
					  <div class="row g-0">
					    <div class="col-md-4">
					      <img src="${pageContext.request.contextPath}/resources/images/reservation/glamping1.png" class="img-fluid rounded-start" alt="...">
					    </div>
					    <div class="col-md-8">
					      <div class="card-body">
					        <h5 class="card-title">C구역 (글램핑존)</h5>
					        <p class="card-text"><br /><br /><strong>150,000원</strong></p>
					      </div>
					    </div>
					  </div>
					</div>
					
			        <div class="card mb-3" style="max-width: 540px;">
					  <div class="row g-0">
					    <div class="col-md-4">
					      <img src="${pageContext.request.contextPath}/resources/images/reservation/caravan1.png" class="img-fluid rounded-start" alt="...">
					    </div>
					    <div class="col-md-8">
					      <div class="card-body">
					        <h5 class="card-title">D구역 (카라반존)</h5>
					        <p class="card-text"><br /><br /><strong>200,000원</strong></p>
					      </div>
					    </div>
					  </div>
					</div>
					
			      </div>
			    </div>
			  </div>
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="flush-headingTwo">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTwo" aria-expanded="false" aria-controls="flush-collapseTwo">
			        시설사용료 감면 안내
			      </button>
			    </h2>
			    <div id="flush-collapseTwo" class="accordion-collapse collapse" aria-labelledby="flush-headingTwo" data-bs-parent="#accordionFlushExample">
			      <div class="accordion-body">
			      <h6 class="p-3 border-bottom"><code> * 사용료 감면 기준</code></h6>
			        <table class="table table-bordered">
						<thead>
							<tr>
								<th scope="col">감면비율</th>
								<th scope="col">감면조건</th>
								<th scope="col">할인유형</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>100%</td>
								<td>국가나 지방자치단체가 공무상 필요하여 사용하는 경우</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>100%</td>
								<td>국가나 지방자치단체가 주관・후원하는 행사에 사용하는 경우</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>100%</td>
								<td>그 밖에 시장이 특별한 사유가 있다고 인정하는 경우</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>50%</td>
								<td>「국민기초생활 보장법」 제2조에 따른 국민기초생활수급자</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>50%</td>
								<td>「장애인 복지법」 제32조에 따라 등록된 장애인</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>50%</td>
								<td>「국가유공자 등 예우 및 지원에 관한 법률」 제4조 제1항 각호에 해당하는 사람</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>50%</td>
								<td>「5.18민주유공자예우에 관한 법률」 제7조에 따라 등록된 5.18민주유공자와 그 유족</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>50%</td>
								<td>「특수임무유공자 예우 및 단체설립에 관한 법률」 제6조에 따라 등록된 특수임무유공자와 그 유족</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>50%</td>
								<td>「한부모가족지원법」 제4조에 따른 한부모가족</td>
								<td>현장할인</td>
							</tr>
							<tr>
								<td>50%</td>
								<td>교육감 또는 학교장의 추천을 받은 관내 초/중/고등학생들이 단체 수련활동을 하는 경우</td>
								<td>현장할인</td>
							</tr>
						</tbody>
					</table>
			      </div>
			    </div>
			  </div>
			  <div class="accordion-item">
			    <h2 class="accordion-header" id="flush-headingThree">
			      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseThree" aria-expanded="false" aria-controls="flush-collapseThree">
			        취소 및 환불 안내
			      </button>
			    </h2>
			    <div id="flush-collapseThree" class="accordion-collapse collapse" a-labelledby="flush-headingThree" data-bs-parent="#accordionFlushExample">
			      <div class="accordion-body">
			      <h6 class="p-3 border-bottom"><code> * 시설사용료 반환<br /><br />* 그 외 예약자의 변심에 따른 예약취소 및 환불은 불가합니다.</code></h6>
			         <table class="table table-bordered">
						<thead>
							<tr>
								<th scope="col">반환조건</th>
								<th scope="col">반환비율</th>
								<th scope="col">비고</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>천재지변, 그 밖의 불가항력적인 사유로 시설 사용이 불가능하게 된 경우</td>
								<td>사용료의 100% 환급</td>
								<td></td>
							</tr>
							<tr>
								<td>관리자의 귀책사유로 시설 사용이 불가능하게 된 경우</td>
								<td>사용료의 100% 환급</td>
								<td></td>
							</tr>
						</tbody>
					</table>
			      </div>
			    </div>
			  </div>
			</div>
		</div>
		
		<div class="ccontainer px-4 py-5 ">
			<h3 class="pb-2 border-bottom"><i class="fa-solid fa-campground"></i> 예약날짜 선택</h3>
			<div>
			<code>※ 동시 접속자가 많을 시 선착순에 따라 대기열 순번으로 전환되오니, 이점 양지하시기 바랍니다.</code><br />
			<small>※ 캠핑장 예약은 선착순으로, 장시간 대기하셔도 예약이 조기 마감 될 수 있습니다.</small><br />
			<small>※ 페이지에서 새로고침, 여러 탭에서 동시접속 시도 시 대기 불이익이 발생할 수 있습니다.</small>
			</div>
			<div class="container col-xxl-8 px-4 py-5" id="calendar"></div>
		</div>
		<img src="${pageContext.request.contextPath}/resources/images/reservation/campMap2.png" alt="" style="width:100%;height:68%;"/>
		<!-- <div id="map" style="width:100%;height:350px;"></div> -->
		
		<div class="pt-5 pb-5" id="list"></div>
		<div class="reservation"></div>
	</div>
</main>
 <form:form class="needs-validation" name="reservationFrm" action="${pageContext.request.contextPath}/reservation/insertReservation.do" method="POST">
 </form:form>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script>
	<sec:authentication property="principal.yellowCard" var="yC"/>
	<sec:authorize access="${yC} >= 3">
		alert("당신은 블랙리스트입니다.");
		history.back();
	</sec:authorize>
	
	<sec:authentication property='principal.point' var="mP"/>
	const myPoint = ${mP};
	
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
            	var today = new Date();
            	var year = today.getFullYear();
            	var month = ('0' + (today.getMonth() + 1)).slice(-2);
            	var day = ('0' + today.getDate()).slice(-2);
            	var dateString = year + '-' + month  + '-' + day;
          		if(info.startStr < dateString){
          			alert("입실일이 과거에요. ㅠ_ㅠ");
          			return;
          		}
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
            				
            				const list = document.querySelector("#list");
            				list.innerHTML = "";
            				list.innerHTML = `
            					<h5 class="pb-2 border-bottom">* 자리를 선택해주세요. *</h5>
            					<select class="form-select" id="camp-select" size="5" aria-label="size 3 select example">
            					</select>
            				`;
            				
           					response.camp.forEach((camp) => {
	          					const {campId, zoneCode} = camp;
	           					const option = `<option value="\${campId}">\${campId}</option>`;
	           					document.querySelector("#camp-select").innerHTML += option;
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
            				          <div>
            				          <span class="text-muted">₩</span><span class="text-muted" id="zonePrice"></span>
            				          </div>
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
            				          <span class="text-danger" id="Rcoupon">0</span><span class="text-danger">%</span>
            				          </div>
            				        </li>
            				        <li class="list-group-item d-flex justify-content-between">
            				          <span>총 결제금액</span>
            				          <strong id="Rprice"></strong>
            				        </li>
            				      </ul>
            				    </div>
            				    <div class="col-md-7 col-lg-8">
            				    <h3 class="pb-2 border-bottom"><i class="fa-solid fa-campground"></i> 예약자 정보입력</h3>
            				   	<code> * 예약자와 입실자가 동일해아만합니다.<br /> * 이름은 예약자 이름으로 정확히 입력해주세요</code><br /><br />
            				        <div class="row g-3">
            				          <div class="col-12">
            				            <label for="resUsername" class="form-label">예약자 성함</label>
            				            <div class="input-group has-validation">
            				              <span class="input-group-text"><i class="fa-regular fa-face-smile"></i></span>
            				              <input type="text" class="form-control" name="Rname" id="Rname" placeholder="예약자 성함" required>
            				            <div class="invalid-feedback">
            				                예약자 이름을 작성해주세요.
            				              </div>
            				            </div>
            				          </div>

            				          <div class="col-12">
            				            <label for="Rphone" class="form-label">예약자 전화번호</label>
            				            <input type="text" class="form-control" name="Rphone" id="Rphone" placeholder="ex) 01012345678" required>
            				            <div class="invalid-feedback">
            				              휴대폰번호를 입력해주세요.
            				            </div>
            				          </div>

            				          <div class="col-12">
            				            <label for="Rcar" class="form-label">차량번호</label>
            				            <input type="text" class="form-control" name="Rcar" id="Rcar" placeholder="ex) 11가1111" required>
            				            <div class="invalid-feedback">
            				              차량번호를 입력해주세요.
            				            </div>
            				          </div>

            				          <div class="col-12">
            				            <label for="Rrequest" class="form-label">요청사항</label>
            				            <input type="text" class="form-control" name="Rrequest" id="Rrequest" placeholder="요청사항을 입력하세요." required>
            				          </div>

            				          <div class="col-md-5">
            				            <label for="Rperson" class="form-label">예약인원</label>
            				            <select class="form-select" id="Rperson" name="Rperson" required>
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
            				          <div class="col-md-5">
            				            <label for="couponList" class="form-label">쿠폰</label>
            				            <select class="form-select" id="couponList" name="couponList" required>
            				              <option value="">선택안함</option>
            				            </select>
            				            <div class="invalid-feedback">
            				              쿠폰 선택
            				            </div>
            				          </div>
            				          <div class="col-md-5">
            				            <label for="point" class="form-label">포인트</label><small class="text-muted">&nbsp;(잔여 포인트 : \${myPoint.toLocaleString('ko-KR')}P)</small>
            				            <input type="number" class="form-control" id="Rpoint" name="Rpoint" value="0" min="0" max="<sec:authentication property='principal.point' />" step="100">
            				            <div class="invalid-feedback">
            				              포인트 입력
            				            </div>
            				          </div>
            				        </div>
            				        <hr class="my-4">
            				        <h4 class="mb-3">이용약관 및 정보이용 동의</h4>
            				        <div class="accordion accordion-flush" id="accordionFlushExample">
            				        <div class="accordion-item">
            				          <h2 class="accordion-header" id="flush-headingFour">
            				            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFour" aria-expanded="false" aria-controls="flush-collapseFour">
            				            <i class="fa-solid fa-check"></i>&nbsp; 시설 사용 동의 (필수)
            				            </button>
            				          </h2>
            				          <div id="flush-collapseFour" class="accordion-collapse collapse" aria-labelledby="flush-headingFour" data-bs-parent="#accordionFlushExample">
            				            <div class="accordion-body">
            				              1. 입장<br>
            				              - 캠핑장의 출입은 반드시 출입구를 이용하셔야 하며, 관리자의 안내에 따라 주시기 바랍니다.<br>
            				              2. 장소<br>
            				              - 사용자께서는 배정된 곳을 사용하셔야 하며, 항상 깨끗하게 이용하여 주시기 바랍니다.<br>
            				              3. 자동차<br>
            				              - 자동차는 출입이 불가하며, 인근 주차장을 이용하여 주시기 바랍니다.<br>
            				              4. 소음<br>
            				              - 심한 소음은 항상 주의하여야 합니다.(정숙 시간 21:00 ~ 07:00)<br>
            				              5. 위생<br>
            				              - 식수 수도꼭지는 식수만을 공급하며, 다른 용도의 사용은 금지되어 있습니다.<br>
            				              - 폐수는 반드시 지정된 곳에 버려 주시고 절대로 바닥에 버려서는 안 됩니다.<br>
            				              - 쓰레기는 지정된 장소에 종류별로 분류하여 내놓아야 하며, 일반쓰레기는 종량제 규격 봉투를, 음식쓰레기는 전용용기를 사용하여야 합니다.<br>
            				              6. 동물<br>
            				              - 모든 동물은 항상 사람의 감독 하에 있어야 합니다.(캠핑장 내에서 반드시 줄로 메어야합니다.)<br>
            				              7. 사고예방 및 질서유지<br>
            				              - 취사행위는 지정된 곳에서만 하여야 합니다.<br>
            				              - 화제예방과 안전을 위해 캠프파이어나 불꽃놀이를 전면 금합니다.<br>
            				              - 캠핑장 내에서는 인라인스케이트, 보드, 자전거 타기 등을 금합니다.<br>
            				              - 음주가무 등 다른 사용자에게 피해를 주 수 있는 행위를 금합니다.<br>
            				              8. 영리행위 및 홍보금지<br>
            				              - 캠핑장 내에서 정치적 또는 종교적 홍보 등을 할 수 없습니다.<br>
            				              - 관리자의 사전 허가 없이는 상업적인 홍보 또는 물품의 판매를 할 수 없습니다.<br>
            				              9. 유실 또는 피해<br>
            				              - 관리자는 사용자의 소유물에 대한 유실 또는 피해에 대하여 책임을 지지 않습니다. - 캠핑장 시설에 피해를 입힌 사람에게는 피해복구 비용이 청구 됩니다.<br>
            				              10. 긴급사태<br>
            				              - 긴급을 요하는 경우와 호우, 강풍, 폭설 등으로 긴급대피가 필요한 경우에는 관리센터의 요청에 즉각 따라야 합니다.
            				              </div>
            				          </div>
            				        </div>
            				        <div class="accordion-item">
            				          <h2 class="accordion-header" id="flush-headingFive">
            				            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseFive" aria-expanded="false" aria-controls="flush-collapseFive">
            				            <i class="fa-solid fa-check"></i>&nbsp; 개인정보 수집이용 동의 (필수)
            				            </button>
            				          </h2>
            				          <div id="flush-collapseFive" class="accordion-collapse collapse" aria-labelledby="flush-headingFive" data-bs-parent="#accordionFlushExample">
            				            <div class="accordion-body">
            				              여주도시관리공단에서 운영하는 시설물 이용에 대하여 개인정보 수집이용 내용을 숙지하였으며, 이에 따라 아래와 같이 수집하는 것에 대해 동의합니다.<br>
            				              - 수집항목 : 이메일 주소, 비밀번호, 이름, 휴대폰번호<br>
            				              - 수집/이용 목적 : 예매 확인/취소/ 발권에 따른 본인확인 및 서비스 관련 고지사항 전달을 위한 의사소통 경로 확보<br>
            				              - 보유 및 이용기간 : 전자상거래에서의 계약, 청약철회, 대금결제, 재화 등 공급기록 5년<br>
            				              본 동의는 서비스의 본질적 기능 제공을 위한 개인정보 수집/이용에 대한 동의로서, 동의하지 않으실 경우 서비스 제공이 불가능합니다.<br>
            				              ※ 법령에 따른 개인정보의 수집/이용, 계약의 이행/편의증진을 위한 개인정보 취급과 관련된 일반 사항은 서비스의 개인정보 취급방침을 따릅니다.
            				            </div>
            				          </div>
            				        </div>
            				        <div class="accordion-item">
            				          <h2 class="accordion-header" id="flush-headingSix">
            				            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseSix" aria-expanded="false" aria-controls="flush-collapseSix">
            				            <i class="fa-solid fa-check"></i>&nbsp; 취소/환불규정 동의 (필수)
            				            </button>
            				          </h2>
            				          <div id="flush-collapseSix" class="accordion-collapse collapse" aria-labelledby="flush-headingSix" data-bs-parent="#accordionFlushExample">
            				            <div class="accordion-body">
            				              천재지변, 그 밖의 불가항력적인 사유로 시설 사용이 불가능하게 된 경우 및 <br>
            				              관리자의 귀책사유로 시설 사용이 불가능하게 된 경우 외 <br>
            				              예약자의 변심에 따른 예약취소 및 환불은 불가
            				            </div>
            				          </div>
            				        </div>
            				      </div>
            				      <div class="form-check m-4">
	            				      <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
	            				      <label class="form-check-label" for="flexCheckDefault">
	            				        위 사항을 다 읽었으며, 약관에 동의합니다.
	            				      </label>
	            				  </div>
            				        <hr class="my-4">
            				        <h4 class="mb-3">결제수단</h4>
            				        <div class="my-3">
            				          <div class="form-check">
            				            <input name="Rpayment" id="Rpayment" type="radio" class="form-check-input" value="카드" checked required>
            				            <label class="form-check-label" for="Rpayment">신용카드</label>
            				          </div>
            				          <div class="form-check">
            				            <input name="Rpayment" type="radio" class="form-check-input" value="무통장" required>
            				            <label class="form-check-label" for="Rpayment">무통장입금</label>
            				          </div>
            				        </div>
            				        <hr class="my-4">
            				        <button class="w-100 btn btn-primary btn-lg" type="button" id="doPay">결제하기</button>
            				`;
            				
            				response.userCoupon[0].coupons.forEach((coupon) => {
            					const {couponName, couponCode, couponDiscount} = coupon;
                                document.querySelector("#couponList").innerHTML += `
                                	<option value="\${couponDiscount}@\${couponCode}">[\${couponDiscount}%]\${couponName}</option>
                                `;
                            });
            				   				
       						
            				document.querySelector("#Rpoint").addEventListener("blur", (e) => {
            					if(e.target.value > <sec:authentication property='principal.point' /> || e.target.value < 0){
            						e.target.value = <sec:authentication property='principal.point' />;
            					}
                				 
            					document.querySelector("#usepoint").innerHTML = e.target.value;             						
            					let minuspoint = document.querySelector("#Rpoint").value;
            					let minuscoupon = (couponList.value.split('@'))[0];
    						
    							let price = Number(document.querySelector("#zonePrice").innerHTML);
                				let resPrice = ((price-(price*(minuscoupon/100)))-minuspoint).toLocaleString('ko-KR');
                				document.querySelector("#Rprice").innerHTML = `₩`+resPrice;
            				});
            				
            				couponList.addEventListener("blur", (e) => {
            					
            					if(e.target.value == ""){
            						document.querySelector("#Rcoupon").innerHTML = 0;
            					}
            					else{
	            					document.querySelector("#Rcoupon").innerHTML = (e.target.value.split('@'))[0];
            					}
            					
            					let minuscoupon = (couponList.value.split('@'))[0];
            					let minuspoint = document.querySelector("#Rpoint").value;
    							let price = Number(document.querySelector("#zonePrice").innerHTML);
                				let resPrice = ((price-(price*(minuscoupon/100)))-minuspoint).toLocaleString('ko-KR');
                				document.querySelector("#Rprice").innerHTML = `₩`+resPrice;	
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
            							document.querySelector("#zonePrice").innerHTML = `\${zonePrice}`
            							document.querySelector("#zone").innerHTML = `\${campId}`;            						

            							let minuspoint = document.querySelector("#Rpoint").value;
            							let minuscoupon = (couponList.value.split('@'))[0];
            						
            							let price = Number(document.querySelector("#zonePrice").innerHTML);
                        				let resPrice = ((price-(price*(minuscoupon/100)))-minuspoint).toLocaleString('ko-KR');
            							
                        				document.querySelector("#Rprice").innerHTML = `₩`+resPrice;
                        				
                        				document.querySelector("#doPay").addEventListener('click', (e) => {
                        					const couponCode = couponList.value;
                        					const point = document.querySelector("#Rpoint").value;
                        					const resUsername = document.querySelector("#Rname").value;
                        					const resPhone = document.querySelector("#Rphone").value;
                        					const resCarNo = document.querySelector("#Rcar").value;
                        					const resRequest = document.querySelector("#Rrequest").value;
                        					const resPerson = document.querySelector("#Rperson").value;
                        					const resPayment = document.querySelector("#Rpayment").value;
                        					
                        					document.reservationFrm.innerHTML += `
                        						<input type="hidden" name="userId" value="<sec:authentication property='principal.username' />"/>
                        				        <input type="hidden" name="checkin" value="\${checkin}"/>
                        				        <input type="hidden" name="checkout" value="\${checkout}"/>
                        						<input type="hidden" name="campId" value="\${campId}"/>
                        						<input type="hidden" name="resUsername" value="\${resUsername}"/>
                        						<input type="hidden" name="resPhone" value="\${resPhone}"/>
                        						<input type="hidden" name="resCarNo" value="\${resCarNo}"/>
                        						<input type="hidden" name="resRequest" value="\${resRequest}"/>
                        						<input type="hidden" name="resPerson" value="\${resPerson}"/>
                        						<input type="hidden" name="resPrice" value="\${zonePrice}"/>
                        						<input type="hidden" name="resPayment" value="\${resPayment}"/>
                        						<input type="hidden" name="couponCode" value="\${couponCode}"/>
                        						<input type="hidden" name="point" value="\${point}"/>
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
	

	/* var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
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
	 */
</script>