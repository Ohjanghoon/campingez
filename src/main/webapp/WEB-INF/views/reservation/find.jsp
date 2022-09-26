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
<title>캠핑이지 예약조회</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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
<div class="col-lg-10 mx-auto p-1 py-md-5">
	<h2 class="">예약 조회하기</h2>
	<hr class="mb-3" />
	<code>* 예약자와 입실자가 동일 하여야 하며 입실자가 다른 경우는 사전에 연락하여 주시기 바랍니다.</code><br />
	<code>* 입실시에 관리자가 신분증 제시를 요청 할 수 있으며, 응하지 않을 시 입실이 제한될 수 있습니다.</code><br />
	<code>* 할인받는 고객님들의 경우 , 정상가로 우선 예약 하신후 이용당일 캠핑장 현장에서 증빙자료 확인후 재결제 진행됩니다.</code><br />

	<form:form action="${pageContext.request.contextPath}/reservation/find.do" method="post">
	 <div class="row m-5">
	    <label for="resUsername" class="col-sm-2 col-form-label">예약자 성함</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="resUsername" name="resUsername" placeholder="예) 홍길동" required>
	    </div>
	  </div>
	  <div class="row m-5">
	    <label for="resPhone" class="col-sm-2 col-form-label">휴대폰 번호</label>
	    <div class="col-sm-10">
	      <input type="text" class="form-control" id="resPhone" name="resPhone" placeholder="예) 01012345678" required>
	    </div>
	  </div>
	  <div class="d-grid gap-2 col-6 mx-auto">
	 	 <button class="btn btn-outline-dark" type="submit">조회하기</button>
	  </div>
	</form:form>
</div>
</body>
</html>