<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑이지 이용안내서</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e8e5c6b69c.js" crossorigin="anonymous"></script>
<style>
* {
	list-style: none;
	padding:0;
	margin:0;
	font-family: 'Pretendard-Regular';
}
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}
</style>
</head>
<body>
	<div class="container px-4 py-5" id="icon-grid">
        <h2 class="pb-2 border-bottom">캠핑이지 이용안내</h2>
    
        <div class="row row-cols-1 row-cols-sm-3 row-cols-md-3 row-cols-lg-3 g-4 py-5">
          <div class="col d-flex align-items-start">
            <i class="fa-solid fa-tents fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">캠핑장 입장</h4>
              <p>캠핑장의 출입은 반드시 출입구를 이용하셔야 하며, 관리자의 안내에 따라 주시기 바랍니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-wallet fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">캠핑장 이용요금</h4>
              <p>캠핑장 사용료는 선불입니다.<br>환불은 규정에 따라 수수료가 발생합니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-location-dot fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">캠핑장소</h4>
              <p>사용자께서는 배정된 곳을 사용하셔야 하며, 항상 깨끗하게 이용하여 주시기 바랍니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-car-side fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">자동차 출입</h4>
              <p>자동차는 출입이 불가하며, 인근 주차장을 이용하여 주시기 바랍니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-volume-high fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">캠핑장 내 소음</h4>
              <p>심한 소음은 항상 주의하여야 합니다.<br>정숙 시간은 21:00 ~ 07:00 까지 입니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-hand-sparkles fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">위생 유의사항</h4>
              <p>식수 수도꼭지는 식수외의 사용은 금지되어 있습니다.<br>폐수는 반드시 지정된 곳에 버려 주시고 바닥에 버려서는 안 됩니다.
                <br>쓰레기는 지정된 장소에 일반쓰레기는 종량제 규격봉투를,음식물쓰레기는 전용용기를 사용하여 분류하여 배출해야 합니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-dog fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">반려동물</h4>
              <p>모든 동물은 항상 사람의 감독 하에 있어야 합니다.<br>동물의 오물 등으로 캠핑장을 더럽혀서는 안 되며, 캠핑장 내에서 반드시 줄로 메어야합니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-bullhorn fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">홍보행위</h4>
              <p>캠핑장 내에서는 정치적 또는종교적인 홍보 등은 금지되어 있습니다.<br>관리자의 사전 허가 없이는 상업적인 홍보 또는 물품의 판매를 할 수 없습니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-person-circle-question fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">유실 또는 피해</h4>
              <p>관리자는 사용자의 소유물에 대한 유실 또는 피해에 대하여 책임을 지지 않습니다.<br>캠핑장 시설에 피해를 입힌 사람에게는 피해복구 비용이 청구 됩니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-person-falling-burst fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">사고예방 및 질서 유지</h4>
              <p>캠핑장 내 잔디와 수목의 보호를 위하여 함부로 불을 사용하는 것을 금지합니다.<br>화재예방과 안전을 위해 캠프파이어나 불꽃놀이를 전면 금합니다.
                <br>캠핑장 내에서는 냉난방 등 과도한 출력의 전기제품 사용을 자제하여 주시기 바랍니다.<br>취사행위는 지정된 곳에서만 하여야 합니다.
                <br>캠핑장 내에서는 인라인스케이트, 보드, 자전거 타기 등을 금합니다.<br>음주가무 등 다른 사용자에게 피해를 줄 수 있는 행위를 금합니다.</p>
            </div>
          </div>
          <div class="col d-flex align-items-start">
          	<i class="fa-solid fa-tower-broadcast fa-3x"></i>
            <div>
              <h4 class="fw-bold m-3">긴급사태</h4>
              <p>위급을 요하는 경우와 호우,강풍 등으로 피난이 필요한 경우 관리자의 지시에 따라 주시기 바랍니다.</p>
            </div>
          </div>
        </div>
        <div class="d-grid gap-2 col-6 mx-auto">
	 		<input class="btn btn-outline-dark" type="button" value="닫기" onClick="window.close()">
	  	</div>
      </div>
</body>
</html>