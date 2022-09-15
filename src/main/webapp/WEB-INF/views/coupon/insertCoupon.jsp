<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<main>
	<div class="container">
		<form name="couponFrm" action="${pageContext.request.contextPath}/coupon/insertCoupon.do" method="post">
			<sec:csrfInput/>
			<div class="form-floating m-5">
			  <input type="text" class="form-control" id="couponName">
			  <label for="couponName">쿠폰명</label>
			</div>
			<div class="m-5">
			<label for="couponDiscount" class="form-label">할인률</label>
			<input type="range" class="form-range" value="10" min="10" max="100" step="10" id="couponDiscount" name="couponDiscount">
			<small>할인률: <span id="value"></span>%</small>
			</div>
			<div class="row g-2 m-5">
				<div class="col-md">
					<label for="couponStartday">쿠폰시작기간 : </label>
					<input type="date" name="startday">
				</div>
				<div class="col-md">
					<label for="couponEndday">쿠폰만료기간 : </label>
					<input type="date" name="endday">
				</div>
			</div>
			<div class="d-grid gap-2 col-6 mx-auto p-3">
			  <button class="btn btn-outline-dark" type="button">등록</button>
			</div>
		</form>
		</div>
</main>
<script>

    var slider = document.getElementById("couponDiscount");
    var output = document.getElementById("value");
    output.innerHTML = slider.value;

    slider.oninput = function() {
        output.innerHTML = this.value;
    }

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>