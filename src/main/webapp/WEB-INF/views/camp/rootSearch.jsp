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
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xxa5222b687369489dad174bcba92f1a00"></script>
<script src="${pageContext.request.contextPath}/resources/js/tmap.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/map.css" />
</head>
<body>
 <script>
window.onload = () => {
	initTmap();
}
</script>
<div class="container">
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
</script>
</body>
</html>
