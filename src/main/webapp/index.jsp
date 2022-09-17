<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxa5222b687369489dad174bcba92f1a00"></script>
<script src="./resources/js/tmap.js"></script>
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
						
						const baseTime = Number(data.baseTime) >= 930 ? (Number(data.baseTime) + 70) : "0" + (Number(data.baseTime) + 70);
						if(data.fcstTime == baseTime){
							//console.log(data, data.category, data.fcstValue);
	
							
							//현재 온도
							if(data.category == 'T1H'){
								wrapper.innerHTML += `<p>현재 온도 : \${data.fcstValue} °C</p>`
							}
							
							//하늘 상태
							//맑음(1), 구름많음(3), 흐림(4)
							if(data.category == 'SKY'){
								if(Number(data.fcstValue) == 4 || Number(data.fcstValue) == 3){
									wrapper.innerHTML += "<p>흐림</p>";
									comb.push(data.fcstValue);
								}
								else{
									wrapper.innerHTML += "<p>맑음</p>";
									comb.push(data.fcstValue);
								}
							}
							
							//강수 형태
							//없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7) 
							if(data.category == 'PTY'){
								if(Number(data.fcstValue) == 1 || Number(data.fcstValue) == 5){
									wrapper.innerHTML += "<p>비</p>";
									comb.push(data.fcstValue);
								}
								else if(Number(data.fcstValue) == 2 || Number(data.fcstValue) == 6){
									wrapper.innerHTML += "<p>비/눈</p>";
									comb.push(data.fcstValue);
								}
								else if(Number(data.fcstValue) == 3 || Number(data.fcstValue) == 7){
									wrapper.innerHTML += "<p>눈</p>";
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
									wrapper.innerHTML += `<p>강수량 : \${data.fcstValue}</p>`
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
						document.querySelector('#weather').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/sun.png" alt="" />`;
					}
					if(comb[0] == 0 && (comb[1] == 3 || comb[1] == 4)){
						console.log('걍 흐리기만 함');
						document.querySelector('#weather').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/cloudy.png" alt="" />`;
					}
					if((comb[0] == 5 || comb[0] == 1) && (comb[1] == 3 || comb[1] == 4)){
						console.log('비오고 흐림');
						document.querySelector('#weather').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/rainAndCloud.png" alt="" />`;
					}
					if((comb[0] == 3 || comb[0] == 7) && (comb[1] == 3 || comb[1] == 4)){
						console.log('와 눈온당');
						document.querySelector('#weather').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/snowman.png" alt="" />`;
					}
					if((comb[0] == 2 || comb[0] == 6) && (comb[1] == 3 || comb[1] == 4)){
						console.log('비랑 눈이랑 같이 옴');
						document.querySelector('#weather').innerHTML += `<img src="${pageContext.request.contextPath}/resources/images/weather/rainAndSnow.png" alt="" />`;
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
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>