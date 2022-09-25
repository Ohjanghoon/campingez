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
<style>
a {
	text-decoration: none;
	color: black;
}
#adminNav {
	display:flex;
	justify-content: space-evenly;
}
.accordion-body {
	font-size:14px;
}
tr > th {
	font-size:16px;
	vertical-align: middle;
}
tr > td {
	font-size:15px;
	vertical-align: middle;
	height: 70px;
}
#selectType, #searchType, #inquireType, .selectType {
    width: 150px;
    margin-right: 5px;
}
#selectKeywordGroup, #insertInputGroup {
	width:300px;
}
.searchBtn {
	background-color: #c8b6e269;
    border: 1px solid lightgray;
}
.searchBtn:hover {
	background-color: #A8A4CE;
    color: white;
}
#updateBtn, [name=updateBtn], [name=yellowCardBtn], #deleteBtn, #noProblemBtn, [name=cancelBtn], #update-btn, #delete-btn, .report-btn, #insert-btn {
	height: 35px;
    width: 50px;
   	border: 1px solid #A8A4CE;
    color: #A8A4CE;
    background-color: white;
}
#updateBtn:hover, [name=updateBtn]:hover, [name=yellowCardBtn]:hover, #deleteBtn:hover, #noProblemBtn:hover, [name=cancelBtn]:hover, #update-btn:hover, .report-btn:hover, #delete-btn:hover, #insert-btn:hover {
	background-color: #A8A4CE;
    color:white;
}
.report-btn {
	width: 100px;
}
#user-list-tbl, #reservation-tbl, .select-camp-wrap {
	margin-top: 30px;
}
#camp-list-tbl, .camp-insert-wrap {
	margin-top: 60px;
}
#camp-list-tbl tr:last-child {
	border-bottom: 2px solid black;
}
.input-date {
	width: 370px
}
.input-date > * {
	vertical-align: middle;
}
.content-wrap {
    width: 100%;
    margin: 30px 20px;
}
.black-list-wrap {
	margin-top: 50px;
}
.power {
    font-weight: bold;
    color: red;
}
.strong{
	font-weight: bold;
}
.camp-name-wrap, .camp-num-wrap {
	display: flex;
    justify-content: space-between;
}
.zone-wrap, .num-wrap {
	width: 49%;
}
.zone-wrap {
	margin-top: 20px;
}
.check-btn {
	margin: 0 15px;
	border: 1px solid lightgray;
    width: 100px;
    height: 40px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: darkslategray;
}
.check-btn:hover, .btn-check:checked + label {
	border:none;
	background-color: gray;
	color:white;
}
.option-wrap, .camp-num-wrap {
	margin: 20px 0;
}
.btn-wrap {
	display: flex;
    align-items: center;
    justify-content: center;
}
.admin-nav-wrap {
	width:220px;
	margin-right: 15px;
	margin-top: 30px;
    border: 1px solid lightgray;
}
.collapse-four {
	border-bottom: 1px solid lightgray;
}
.tbl-camp-zone {
	border-top: 1px solid gray;
}
.tbl-login-count {
    margin: 40px 0 20px 0;
}
.count-wrap {
	margin-top: 20px;
	display: flex;
}
#totalCount-wrap {
	padding-right: 20px;
    border-right: 1px solid gray;
}
#totalCountByDate-wrap {
	padding-left: 20px;
}
#myChart {
	margin: 30px 0;
}
.zoneName-label {
	color: gray;
}
</style>
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
