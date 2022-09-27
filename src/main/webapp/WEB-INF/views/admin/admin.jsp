<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
<script>
$(document).ready(function () {
    $('html, body, .container').animate({scrollTop: $('.content-wrap').offset().top - 135}, 'fast');
});
</script>
<main>
	<section>
		<div class="container" id="adminNav">
			<div class="nav-wrap">
				<nav>
					<div class="accordion accordion-flush admin-nav-wrap" id=accordionExample>
					  <div class="accordion-item">
					    <h2 class="accordion-header" id="headingOne">
					      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
					        예약관리
					      </button>
					    </h2>
					    <div id="collapseOne" class="accordion-collapse collapse" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/reservationList.do">예약현황</a>
					      </div>
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/assignmentList.do">양도현황</a>
					      </div>
					    </div>
					  </div>
					  <div class="accordion-item">
					    <h2 class="accordion-header" id="headingTwo">
					      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
					        회원관리
					      </button>
					    </h2>
					    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/userList.do">회원관리</a>
					      </div>
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/blackList.do">블랙리스트관리</a>
					      </div>
					    </div>
					  </div>
					  <div class="accordion-item">
					    <h2 class="accordion-header" id="headingThree">
					      <button class="accordion-button collapsed fs-6" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
					        커뮤니티관리
					      </button>
					    </h2>
					    <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/tradeReportList.do">중고거래 신고관리</a>
					      </div>
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/commReportList.do">커뮤니티 신고관리</a>
					      </div>
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/inquireList.do">1:1문의 답변</a>
					      </div>
					    </div>
					  </div>
					  <div class="accordion-item">
					    <h2 class="accordion-header" id="headingFour">
					      <button class="accordion-button collapsed collapse-four" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
					        캠핑장관리
					      </button>
					    </h2>
					    <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/campZoneList.do">캠핑구역관리</a>
					      </div>
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/insertCampZone.do">캠핑구역추가</a>
					      </div>
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/campList.do">캠핑자리관리</a>
					      </div>
					    </div>
					  <div class="accordion-item">
					    <h2 class="accordion-header" id="headingFive">
					      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
					      	통계
					      </button>
					    </h2>
					    <div id="collapseFive" class="accordion-collapse collapse" aria-labelledby="headingFive" data-bs-parent="#accordionExample">
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/statsVisited.do">일자별 로그인 회원 수 조회</a>
					      </div>
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/monthlySales.do">월별 매출 조회</a>
					      </div>
					      <div class="accordion-body">
					      	<a href="${pageContext.request.contextPath}/admin/statsCouponDown.do">쿠폰 이용 조회</a>
					      </div>
					    </div>
					  </div>
					  </div>
					</div>		
				</nav>
			</div>