<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://kit.fontawesome.com/e8e5c6b69c.js" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/tmap.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/map.css" />
</head>
<!--  <script>
window.onload = () => {
	initTmap();
}
</script> -->
<body>
<h1>ㅎㅇ</h1>
<!-- 	<div class="buttonWrapper">
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
	</script> -->
</body>
</html>