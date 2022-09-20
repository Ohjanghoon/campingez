<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxa5222b687369489dad174bcba92f1a00"></script>
<script src="./resources/js/tmap.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/weather.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/map.css" />
<link href="${pageContext.request.contextPath}/resources/css/carousel.css" rel="stylesheet">
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css'>
<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.css'><link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style2.css">
 <script>
window.onload = () => {
	weather();
	initTmap();
}
</script>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<div class="container">
<section>
        <div class="container marketing">

            <div class="row featurette">
            <div class="col-md-7">
                <h2 class="featurette-heading">오늘 캠핑장 날씨<span class="text-muted">??</span></h2>
                <p class="lead">Some great placeholder content for the first featurette here. Imagine some exciting prose here.</p>
            </div>
            <div class="col-md-5">
            	<!-- 해석님 여기 날씨 이미지가 상단에 고정되서 나와유 ㅠㅠ -->
            	<!-- <div class="weatherContainer" style="height: 400px;">
					<article class="widget">
					    <div class="weatherIcon" style="text-align: center;"></div>
					    <div class="weatherData">
					      <h1 class="temperature"></h1>
					      <h2 class="description"></h2>
					      <h3 class="city">대한민국, 경주</h3>
					    </div>
					    <div class="date">
					      <h4 class="month" id="month"></h4>
					      <h5 class="day" id="day"></h5>
					    </div>
					</article>
					<div class="weatherText">오늘의 날씨</div>
				</div>
				<div id="weather"></div> -->
                <img class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" src="https://i.pinimg.com/564x/2a/5b/80/2a5b8055099fb3eee4e4691c720c1433.jpg">
        
            </div>
            </div>
        

            <hr class="featurette-divider">
        
            <div class="row">
            <div class="col-lg-4">
                <img class="bd-placeholder-img rounded-circle" width="140" height="140" src="https://i.pinimg.com/564x/e8/d0/b2/e8d0b2aa9819b489fbc1958adba0c2a2.jpg">
        
                <h2 class="m-3">이용안내</h2>
                <p><a class="btn btn-secondary" href="#">확인 &raquo;</a></p>
            </div>
            <div class="col-lg-4">
                <img class="bd-placeholder-img rounded-circle" width="140" height="140" src="https://i.pinimg.com/564x/4d/0d/18/4d0d188d7d243052d9339d1cb200643d.jpg">
        
                <h2 class="m-3">예약 조회</h2>
                <p><a class="btn btn-secondary" href="#">조회 &raquo;</a></p>
            </div>
            <div class="col-lg-4">
                <img class="bd-placeholder-img rounded-circle" width="140" height="140" src="https://i.pinimg.com/564x/6f/71/bb/6f71bb1dc7c58ae8dd877d8784a36cbb.jpg">
        
                <h2 class="m-3">찾아오시는 길</h2>
                <p><a class="btn btn-secondary" href="#">찾기 &raquo;</a></p>
            </div>
            </div>
        
            <hr class="featurette-divider">
        
            <div class="row featurette">
            <div class="col-md-7 order-md-2">
                <h2 class="featurette-heading">캠핑이지 사진모음집<span class="text-muted">여러개 와야함</span></h2>
                <p class="lead">Another featurette? Of course. More placeholder content here to give you an idea of how this layout would work with some actual real-world content in place.</p>
            </div>
            <div class="col-md-5 order-md-1">
                <img class="bd-placeholder-img bd-placeholder-img-lg featurette-image img-fluid mx-auto" width="500" height="500" src="https://i.pinimg.com/564x/11/d1/c9/11d1c920b75b2696af6d7c80016458fb.jpg">
            </div>
            </div>

        </div>
    </section><br /><br />
    
    <section class="travel-section">
        <h2 class="pb-4 mb-4 fst-italic border-bottom">경주 주변 관광지</h2>
        <div class="owl-carousel custom-carousel owl-theme">
          <div class="item active" style="background-image: url(https://cdn.salgoonews.com/news/photo/202105/2959_7616_2317.jpg);">
            <div class="item-desc">
              <h3>교촌마을</h3>
              <p>교촌마을은 전주 한옥마을만큼 크진 않지만, 관광지가 많은 경주 특성상 상대적으로 한가롭게 산책할 수 있습니다. 
                교촌마을에서 제일 유명한 곳은 아마 경주 최씨고택일 거예요. 
                경주 최씨고택은 조선 시대 양반집의 원형을 잘 보존하고 있어 방문하는 보람이 있답니다.</p>
            </div>
          </div>
          <div class="item" style="background-image: url(https://cdn.salgoonews.com/news/photo/202105/2959_7619_2318.png);">
            <div class="item-desc">
              <h3>양동마을</h3>
              <p>유교와 풍수지리를 반영해 조성된 이 마을은, 현재까지도 양반의 후손들이 살아 그 얼을 계승하는 정주형 문화유산이에요. 
                골목의 풍경이나 마을 앞 연못이 운치가 있고 찾는 사람이 많지 않아 조용히 산책을 즐기려는 사람에게 추천합니다.</p>
            </div>
          </div>
          <div class="item" style="background-image: url(https://cdn.salgoonews.com/news/photo/202105/2959_7622_2319.png);">
            <div class="item-desc">
              <h3>대릉원</h3>
              <p>경주의 감성을 제대로 느낄 수 있는 대릉원을 추천드립니다. 
                신라시대 왕, 왕비, 귀족의 무덤 23기가 모여 있답니다. 
                푸른 잔디와 부드러운 곡선이 어우러진 신라 고분의 신비로운 모습을 볼 수 있어요.</p>
            </div>
          </div>
          <div class="item" style="background-image: url(https://cdn.salgoonews.com/news/photo/202105/2959_7624_2320.jpg);">
            <div class="item-desc">
              <h3>황리단길</h3>
              <p>경주 가볼만한 곳 1위! 뉴트로 감성이 넘치는 경주의 핫플레이스예요. 
                대릉원 후문 근처의 내남 네거리에서 황남 초교 네거리까지 이어지는 길로 황남동과 경리단길의 합성어랍니다.
                한옥을 개조한 분위기 좋은 카페, 예쁜 맛집, 수제 맥줏집, 소품 가게, 사진관, 게스트 하우스 등을 만날 수 있어요.</p>
            </div>
          </div>
          <div class="item" style="background-image: url(https://cdn.salgoonews.com/news/photo/202105/2959_7638_2323.jpg);">
            <div class="item-desc">
              <h3>경주월드</h3>
              <p>경주월드는 지난 1985년 국내에서 두 번째로 개장한 역사가 깊은 놀이공원입니다. 
                도투락월드로 개장했다가 경주월드라는 이름은 1992년부터 사용하기 시작했는데요. 
                경주월드 어뮤즈먼트와 워터파크인 캘리포니아비치가 있습니다.</p>
            </div>
          </div>
          <div class="item" style="background-image: url(https://cdn.salgoonews.com/news/photo/202105/2959_7626_2320.png);">
            <div class="item-desc">
              <h3>동궁과 월지</h3>
              <p>경주 야경의 핫플레이스, 동궁과 월지입니다. 
                신라 왕궁의 별궁 터로 왕자가 거처하는 동궁으로 사용하며, 나라의 경사가 있거나 귀한 손님이 오면 연회를 베풀었던 곳이죠.
                월지는 예전에 안압지라 불린 곳인데 달이 비치는 연못이라는 뜻이에요. 
                낮에도 고즈넉하고 아름다운 경관을 자랑하지만, 특히 밤에는 환상적인 야경을 볼 수 있습니다.</p>
            </div>
          </div>
        </div>
        </div>
      </section>
    
    <section>
      <div class="container px-4 py-5" id="custom-cards">
        <h2 class="pb-2 border-bottom">캠핑이지 중고거래</h2>
    
        <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
          <div class="col">
            <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('https://i.pinimg.com/564x/12/b9/c0/12b9c0b89a9f356758709eba5def97fb.jpg');">
              <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
                <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Short title, long jacket</h2>
                <ul class="d-flex list-unstyled mt-auto">
                  <li class="me-auto">
                    <img src="${pageContext.request.contextPath}/resources/images/campingEasyLogo.png" width="32" height="32" class="rounded-circle border border-white">
                  </li>
                  <li class="d-flex align-items-center me-3">
                    <i class="fa-solid fa-heart"></i>
                    <small>Earth</small>
                  </li>
                  <li class="d-flex align-items-center">
                    <i class="fa-solid fa-heart"></i>
                    <small>3d</small>
                  </li>
                </ul>
              </div>
            </div>
          </div>
    
          <div class="col">
            <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('https://i.pinimg.com/564x/12/b9/c0/12b9c0b89a9f356758709eba5def97fb.jpg');">
              <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
                <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Much longer title that wraps to multiple lines</h2>
                <ul class="d-flex list-unstyled mt-auto">
                  <li class="me-auto">
                    <img src="${pageContext.request.contextPath}/resources/images/campingEasyLogo.png" width="32" height="32" class="rounded-circle border border-white">
                  </li>
                  <li class="d-flex align-items-center me-3">
                    <i class="fa-solid fa-heart"></i>
                    <small>Pakistan</small>
                  </li>
                  <li class="d-flex align-items-center">
                    <i class="fa-solid fa-heart"></i>
                    <small>4d</small>
                  </li>
                </ul>
              </div>
            </div>
          </div>
    
          <div class="col">
            <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('https://i.pinimg.com/736x/8e/d0/1a/8ed01a6f7af56581331e1941c0f33fa9.jpg');">
              <div class="d-flex flex-column h-100 p-5 pb-3 text-shadow-1">
                <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">Another longer title belongs here</h2>
                <ul class="d-flex list-unstyled mt-auto">
                  <li class="me-auto">
                    <img src="${pageContext.request.contextPath}/resources/images/campingEasyLogo.png" width="32" height="32" class="rounded-circle border border-white">
                  </li>
                  <li class="d-flex align-items-center me-3">
                    <i class="fa-solid fa-heart"></i>
                    <small>California</small>
                  </li>
                  <li class="d-flex align-items-center">
                    <i class="fa-solid fa-heart"></i>
                    <small>5d</small>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>  
		
<script>
		const clockString = () => {
	        const f = (n) => {
	            return n <10 ? "0" + n : n;
	        }
	        const now = new Date();
	        const yyyy = now.getFullYear();
	        const MM = f(now.getMonth()+1);
	        const dd = f(now.getDate());
	        return yyyy + MM + dd;
	    }
	
		const timeString = () => {
            const f = (n) => {
                return n <10 ? "0" + n : n;
            }
            const now = new Date();
            now.setMinutes(now.getMinutes() - 30);
            //const hh = f(now.getHours() > 12 ? now.getHours() - 12 : now.getHours());
            const hh = f(now.getHours());
            const mm = f(now.getMinutes());
            console.log(hh, mm)
            return "" + hh + mm;
        }
		
		function weather() {
			const today = clockString();
			const time = timeString();
			console.log(today, time);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/data/weather.do",
				data : {
					date : today, time
				},
				success(data){
					//console.log(data);
					
					//날씨 조합
					const comb = [];
					
					data.forEach((data) => {
						const description = document.querySelector('.description');
						const temperature = document.querySelector('.temperature');
						
						const baseTime = Number(data.baseTime) >= 930 ? (Number(data.baseTime) + 70) : "0" + (Number(data.baseTime) + 70);
						if(data.fcstTime == baseTime){
							//console.log(data, data.category, data.fcstValue);
	
							
							//현재 온도
							if(data.category == 'T1H'){
								temperature.innerHTML += `\${data.fcstValue}°`;
							}
							
							//하늘 상태
							//맑음(1), 구름많음(3), 흐림(4)
							if(data.category == 'SKY'){
								if(Number(data.fcstValue) == 4 || Number(data.fcstValue) == 3){
									description.innerHTML += "흐림";
									comb.push(data.fcstValue);
								}
								else{
									description.innerHTML += "맑음";
									comb.push(data.fcstValue);
								}
							}
							
							//강수 형태
							//없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7) 
							if(data.category == 'PTY'){
								if(Number(data.fcstValue) == 1 || Number(data.fcstValue) == 5){
									description.innerHTML += " (비)";
									comb.push(data.fcstValue);
								}
								else if(Number(data.fcstValue) == 2 || Number(data.fcstValue) == 6){
									description.innerHTML += " (비 / 눈)";
									comb.push(data.fcstValue);
								}
								else if(Number(data.fcstValue) == 3 || Number(data.fcstValue) == 7){
									description.innerHTML += " (눈)";
									comb.push(data.fcstValue);
								}
								else{
									console.log("맑음");
									comb.push(data.fcstValue);
								}
							}
							
							//강수량(1시간)
							if(data.category == 'RN1'){
								if(data.fcstValue != '강수없음'){
									description.style.fontSize = '15px';
									description.style.top = '15%';
									description.innerHTML += ` 강수량 : \${data.fcstValue}<br>`
								}
							}
						}
					});	
					console.log(comb);
					//인덱스 0 - 강수 형태
					//없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7) 
					//인덱스 1 - 하늘 상태
					//맑음(1), 구름많음(3), 흐림(4)
					if(comb[0] == 0 && comb[1] == 1){
						console.log('걍 맑음 그 자체');
						document.querySelector('.weatherIcon').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/sun.png" alt="" style="width: 210px; height: 210px;">`;
					}
					if(comb[0] == 0 && (comb[1] == 3 || comb[1] == 4)){
						console.log('걍 흐리기만 함');
						document.querySelector('.weatherIcon').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/cloudy.png" alt="" style="width: 210px; height: 210px;">`;
					}
					if((comb[0] == 5 || comb[0] == 1) && (comb[1] == 3 || comb[1] == 4)){
						console.log('비오고 흐림');
						document.querySelector('.weatherIcon').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/rainAndCloud.png" alt="" style="width: 210px; height: 210px;">`;
					}
					if((comb[0] == 3 || comb[0] == 7) && (comb[1] == 3 || comb[1] == 4)){
						console.log('와 눈온당');
						document.querySelector('.weatherIcon').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/snowman.png" alt="" style="width: 210px; height: 210px;">`;
					}
					if((comb[0] == 2 || comb[0] == 6) && (comb[1] == 3 || comb[1] == 4)){
						console.log('비랑 눈이랑 같이 옴');
						document.querySelector('.weatherIcon').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/rainAndSnow.png" alt="" style="width: 210px; height: 210px;">`;
					}
				},
				error : console.log
			});
		};
		</script>
	<br />
	<div class="buttonWrapper">
		<button id="research" style="display: none;" onclick="research()">다시검색하기</button>
		<div id="xyCode" style="display: inline;">
			<input type="text" class="text_custom" id="fullAddr" name="fullAddr"
				value="홍대">
			<button id="btn_select1">적용하기</button>
		</div>
		<button id="btn_select2" onclick="lineDisplay()">경로보기</button>
		<p id="result"></p>
	</div>


	<div id="map_wrap" class="map_wrap" style="width: 500px;">
		<div id="map_div"></div>
	</div>


	<div id="codeSave">
		<input type="hidden" id="save1"> <input type="hidden"
			id="save2">
	</div>
</div>
<script>
function lineDisplay(){
	document.querySelector('#btn_select2').style.display = 'none';
	lineSearch();
};
function research() {
    document.querySelector('#map_div').innerHTML = '';
    document.querySelector('#xyCode').style.display = 'inline';
    document.querySelector('#research').style.display = 'none';
    document.querySelector('#result').innerHTML = '';
	document.querySelector('#btn_select2').style.display = 'inline';
    initTmap();
};
var d = new Date();
document.getElementById("day").innerHTML = d.getDate();
var month = new Array();
month[0] = "January";
month[1] = "February";
month[2] = "March";
month[3] = "April";
month[4] = "May";
month[5] = "June";
month[6] = "July";
month[7] = "August";
month[8] = "September";
month[9] = "October";
month[10] = "November";
month[11] = "December";
document.getElementById("month").innerHTML = month[d.getMonth()];
</script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js'></script>
<script  src="${pageContext.request.contextPath}/resources/js/script.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>