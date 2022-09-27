<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/reservation.css" />
<div class="items" id="myReservationList">
	<c:forEach items="${reservationList}" var="res" end = "5" varStatus="vs">
		<div class="item">
			<div class="firstLine">
				<div class="resDate"><!--예약일자-->
					<fmt:parseDate value="${res.resDate}" pattern="yyyy-MM-dd" var="resDate" />
					<fmt:formatDate value="${resDate}" pattern="yyyy-MM-dd" />
				</div>
				<div class="resStatus"><!--예약상태 -->
					${res.resState}
				</div>
				<div class="resType"><!--결제 수단-->
					${res.resPayment}
				</div>
			</div>
			<div class="resStart"><!-- 입실일자 -->
				<fmt:parseDate value="${res.resCheckin}" pattern="yyyy-MM-dd" var="resCheckin" />
				<fmt:formatDate value="${resCheckin}" pattern="yyyy-MM-dd" />
			</div>
			<div class="resStartTxt">입실일자</div>
			<div class="resName"><!-- 자리이름 -->
				${res.campId}
			</div>
			<img class="arrow"  id="preview" src="${pageContext.request.contextPath}/resources/images/mypage/rightArrow.png">
			<div class="resPrice"><!-- 금액 -->
				<fmt:formatNumber value="${res.resPrice}" pattern="#,###"/>원
			</div>
			<div class="resEnd"><!-- 퇴실일자 -->
				<fmt:parseDate value="${res.resCheckout}" pattern="yyyy-MM-dd" var="resCheckout" />
				<fmt:formatDate value="${resCheckout}" pattern="yyyy-MM-dd" />
			</div>
			<div class="hr">
				<hr>
			</div>
			<div class="resEndTxt">퇴실일자</div>
			<div class="resReview"><!-- 리뷰작성 -->
				<c:if test="${res.review == 'OK'}">
					<button  class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/review/reviewForm.do?resNo=${res.resNo}'" >리뷰작성</button> 
				</c:if>
				<c:if test="${res.review != 'OK'}">
					<button disabled class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/review/reviewForm.do?resNo=${res.resNo}'" >리뷰작성</button> 
				</c:if>
			</div>
			<div class="resDetail">
				<button  class="btn btn-outline-dark" onclick="location.href='${pageContext.request.contextPath}/userInfo/resDetail.do?resNo=${res.resNo}'" >상세보기</button>
			</div>
		</div>
	</c:forEach>	
</div>
	<nav id="nav">
		${pagebar}
	</nav>
	
<script>
function clickPaging() {
	var id = this.id;
	var page = id.substring(4);
	if(page == 0){
		page = -1;
	}
	reservationPaingAjax(page);
	console.log(page);
}

var pagings = document.querySelectorAll(".paging");

pagings.forEach(paging => {
	paging.addEventListener("click", clickPaging);
});
</script>
