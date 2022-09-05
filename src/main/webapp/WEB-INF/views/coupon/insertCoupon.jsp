<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>coupon</h1>
		<form name="couponFrm" action="${pageContext.request.contextPath}/coupon/insertCoupon.do" method="post">
			<sec:csrfInput/>
			<label for="couponName">쿠폰이름</label>
			<input type="text" name="couponName"><br><br />
			<label for="couponDiscount">할인률</label>
			<input type="number" name="couponDiscount" value="10" min='10' step="10">&nbsp;%<br><br />
			<label for="couponStartday">쿠폰시작기간</label>
			<input type="date" name="startday"><br><br />
			<label for="couponEndday">쿠폰시작기간</label>
			<input type="date" name="endday"><br><br />
			<button>등록</button>
		</form>
	<script>
	</script>
</body>
</html>