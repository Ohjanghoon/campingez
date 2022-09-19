<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxa5222b687369489dad174bcba92f1a00"></script>
<script src="./resources/js/tmap.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/weather.css" />
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
	<div class="weatherContainer" style="height: 400px;">
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
	</div>
<div id="weather"></div>
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
			document.querySelector('#weather').innerHTML = "";
			
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
						const wrapper = document.querySelector('#weather');
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
									//wrapper.innerHTML += "<p>비</p>";
									description.innerHTML += " (비)";
									comb.push(data.fcstValue);
								}
								else if(Number(data.fcstValue) == 2 || Number(data.fcstValue) == 6){
									//wrapper.innerHTML += "<p>비/눈</p>";
									description.innerHTML += " (비 / 눈)";
									comb.push(data.fcstValue);
								}
								else if(Number(data.fcstValue) == 3 || Number(data.fcstValue) == 7){
									//wrapper.innerHTML += "<p>눈</p>";
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
	<button id="research" style="display: none;" onclick="research()">다시검색하기</button>
	<div id="xyCode" style="display: inline;">
		<input type="text" class="text_custom" id="fullAddr" name="fullAddr"
			value="홍대">
		<button id="btn_select1">적용하기</button>
	</div>

	<button id="btn_select2" onclick="lineDisplay()">경로보기</button>

	<div id="map_wrap" class="map_wrap" style="width: 700px;">
		<div id="map_div"></div>
	</div>

	<p id="result"></p>

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
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>