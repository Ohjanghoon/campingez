<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/admin/admin.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
			<div class="content-wrap">
				<div class="ing-coupon-wrap">
					<h2 class="text-center fw-bold pt-5 pb-5">진행 중인 이벤트</h2>
					<table class="table text-center" >
						<thead>
							<tr>
								<th scope="col">No</th>
								<th scope="col">쿠폰명</th>
								<th scope="col">쿠폰정보</th> 
								<th scope="col">다운로드횟수</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty ingCouponList}">
								<c:forEach items="${ingCouponList}" var="ingCoupon" varStatus="vs">
									<tr>
										<td scope="row">${vs.count}</td>
										<td scope="row">${ingCoupon.couponName}</td>
										<td scope="row">
											<div class="card-wrap d-flex justify-content-center">
												<div class="card text-center " style="width: 18rem;">
												  <h4 class="card-header">${ingCoupon.couponName}</h4>
												  <div class="card-body">
												    <p class="card-text">할인률 : ${ingCoupon.couponDiscount}%</p>
												    <p class="card-text">사용기간 : ${ingCoupon.couponStartday} ~ ${ingCoupon.couponEndday}</p>
												  </div>
												</div>
											</div>
										</td>
										<td scope="row">${ingCoupon.couponDownCount}회</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty ingCouponList}">
								<tr>
									<td colspan="4">진행 중인 이벤트가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<nav class="pagebar">
						${ingPagebar}
					</nav>
				</div>
				<div class="expire-coupon-wrap">
					<h2 class="text-center fw-bold pt-5 pb-5">지난 이벤트</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th scope="col">No</th>
								<th scope="col">쿠폰명</th>
								<th scope="col">쿠폰정보</th> 
								<th scope="col">다운로드횟수</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty expireCouponList}">
								<c:forEach items="${expireCouponList}" var="expireCoupon" varStatus="">
									<tr>
										<td scope="row">${vs.count}</td>
										<td scope="row">${expireCoupon.couponName}</td>
										<td scope="row">
											<div class="card-wrap d-flex justify-content-center">
												<div class="card text-center" style="width: 18rem;" >
												  <h4 class="card-header">${expireCoupon.couponName}</h4>
												  <div class="card-body">
												    <p class="card-text">할인률 : ${expireCoupon.couponDiscount}%</p>
												    <p class="card-text">사용기간 : ${expireCoupon.couponStartday} ~ ${expireCoupon.couponEndday}</p>
												  </div>
												</div>
											</div>
										</td>
										<td scope="row">${expireCoupon.couponDownCount}회</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty expireCouponList}">
								<tr>
									<td colspan="4">지난 이벤트가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<nav class="pagebar">
						${expirePagebar}
					</nav>
				</div>
			</div>
		</div>
	</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>