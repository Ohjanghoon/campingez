<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑이지 찾아오시는 길</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<script src="https://kit.fontawesome.com/e8e5c6b69c.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxa5222b687369489dad174bcba92f1a00"></script>
	<script src="${pageContext.request.contextPath}/resources/js/tmap.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/map.css" />
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
 <script>
window.onload = () => {
	initTmap();
}
</script>
<div class="container">
		<div class="mainMap">
			<img src="${pageContext.request.contextPath}/resources/images/mainMap.png" alt="" style="width: 900px; height: 500px;">
		</div><br><br>
		<h1>찾아오시는 길</h1>
		<hr />
		<h5>캠핑이지 : 경북 경주시 인왕동 839-1</h5><br><br>
		<div class="busRoot">
			<i class="fa-solid fa-bus fa-2x" style="height: 50px;"></i>
			<span style="font-weight: 700; font-size: 25px;">&nbsp; 버스로 오시는 길</span><br>
			<div>
				<li>고속철도 : 신경주역 -> 70번(71번, 50번) 버스 탑승 -> 11번(고속버스) 환승 -> 월성동주민센타 하차 -> 도보 7분</li><br>
				<li>시외버스터미널 : 경주시외버스터미널 -> 600번(고속버스) 탑승 -> 월성동주민센타 하차 -> 도보 7분</li>
			</div>
			
		</div>
		<br>
		<hr>
		<br>
		<div class="carRoot">
			<i class="fa-solid fa-car fa-2x" style="height: 50px;"></i>
			<span style="font-weight: 700; font-size: 25px;">&nbsp; 자차로 오시는 길</span><br>
			<div>
				<li>상행 : 경주IC -> 경주톨게이트 -> 오릉네거리에서 '신경주역, 오릉'방면으로 좌회전 -> '경주박물관'방면으로 우회전</li><br>
				<li>하행 : 경부고속도로 -> 경주IC에서 '경주, 경주국립공원'방면으로 오른쪽 고속도로 출구 -> '경주박물관'방면으로 우회전</li>
			</div>
		</div>
		
		<br><hr><br>
		
		<div class="search">
			<i class="fa-solid fa-road fa-2x" style="height: 50px;"></i>
			<span style="font-weight: 700; font-size: 25px;">&nbsp; 경로검색 해보기</span><br>
		</div>

		<div id="map_wrap" class="map_wrap" style="float: left;">
			<div id="map_div"></div>
		</div>
		<br>

		<div class="buttonWrapper">
			<button id="research" onclick="research()" class="btn">다시검색하기</button>
			<div id="xyCode">
				<input type="text" class="text_custom" id="fullAddr" name="fullAddr" placeholder="ex) 테헤란로 10길 9">
				<img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png" id="btn_select1" style="cursor: pointer;">
				<!-- <button type id="btn_select1" class="btn btn-outline-secondary">적용하기</button> -->
				<button id="btn_select2" onclick="lineDisplay()" class="btn">경로보기</button>
			</div><br><br>
			<p id="result1"></p>
			<p id="result2"></p>
			<p id="result3"></p>
			<p id="result4"></p>
		</div>

		<div id="codeSave">
			<input type="hidden" id="save1"> <input type="hidden" id="save2">
		</div>

	</div>
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<script>
function lineDisplay(){
	document.querySelector('#btn_select2').style.display = 'none';
	lineSearch();
};
function research() {
    document.querySelector('#map_div').innerHTML = '';
    document.querySelector('#xyCode').style.display = 'inline';
    document.querySelector('#research').style.display = 'none';
    document.querySelector('#result1').innerHTML = '';
    document.querySelector('#result2').innerHTML = '';
    document.querySelector('#result3').innerHTML = '';
    document.querySelector('#result4').innerHTML = '';
	document.querySelector('#btn_select2').style.display = 'inline';
    initTmap();
};
</script>
</body>
</html>
