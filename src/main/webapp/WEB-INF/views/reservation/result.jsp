<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>캠핑이지 예약조회</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body>
<div class="col-lg-11 mx-auto p-1 py-md-5">
	<h2 class="">예약 조회하기</h2>
	<hr class="mb-3" />
	<table class="table">
	  <thead>
	    <tr>
	      <th scope="col">캠핑구역</th>
	      <th scope="col">예약자 성함</th>
	      <th scope="col">휴대폰 번호</th>
	      <th scope="col">예약인원</th>
	      <th scope="col">입실일</th>
	      <th scope="col">퇴실일</th>
	      <th scope="col">요청사항</th>
	      <th scope="col">결제수단</th>
	    </tr>
	  </thead>
	  <tbody>
	  <c:if test="${empty reservations}">
			<tr>
	    		<td colspan="8" class="text-center">예약내역이 없습니다</td>
	    	</tr>
	  </c:if>
	  <c:if test="${not empty reservations}">
		  <c:forEach items="${reservations}" var="reservation">
		    <tr>
		      <th scope="row">${reservation.campId}</th>
		      <td>${reservation.resUsername}</td>
		      <td>${reservation.resPhone}</td>
		      <td>${reservation.resPerson}</td>
		      <td>${reservation.resCheckin}</td>
		      <td>${reservation.resCheckout}</td>
		      <td>${reservation.resRequest}</td>
		      <td>${reservation.resPayment}</td>
		    </tr>
		  </c:forEach>
	  </c:if>
	  </tbody>
	</table>
	 <div class="d-grid gap-2 col-6 mx-auto">
	 	 <input class="btn btn-outline-dark" type="button" value="닫기" onClick="window.close()">
	  </div>
</div>
</body>
</html>