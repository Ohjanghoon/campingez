<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.Duration"%>
<%@page import="com.kh.campingez.campzone.model.dto.CampPhoto"%>
<%@page import="com.kh.campingez.reservation.model.dto.Reservation"%>
<%@page import="com.kh.campingez.assignment.model.dto.Assignment"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="캠핑이지" name="title"/>
</jsp:include>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/assignment/assignmentDetail.css" />
<%
	Assignment assign = (Assignment) request.getAttribute("assign");
	Reservation res = assign.getReservation();
	List<CampPhoto> photos = assign.getCampPhotos();
	
	pageContext.setAttribute("res", res);
	pageContext.setAttribute("photos", photos);
	
	int betDay = (int) Duration.between(res.getResCheckin().atStartOfDay(), res.getResCheckout().atStartOfDay()).toDays();
	String schedule = betDay + "박" + (betDay+1) + "일";
	
	LocalDateTime lastDate = (res.getResCheckin().atStartOfDay()).minusDays(1);
	
	pageContext.setAttribute("newLine", "\n");
%>
<style>
.container th {
	width : 30%;
	text-indent : 1.1rem;
	vertical-align : middle;
}

</style>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.username" var="loginUser"/>
</sec:authorize>		
<div class="container w-75 top">
	<!-- 양도 글 -->
	<div class="mx-auto mt-5">
		<strong class="fs-3"><i class="fa-solid fa-campground"></i> 양도글</strong>
		<hr />
		<table class="my-4 mx-auto table" id="assignBoard">
			<tr>
				<th><span>제목</span></th>
				<td>${assign.assignTitle}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${assign.userId}</td>
			</tr>
			<tr>
				<th class="py-5 pl-5">내용</th>
				<td><p>${fn:replace(assign.assignContent, newLine, "<br />")}</p></td>
			</tr>
		</table>
	</div>
	
	<!-- 양도 취소 버튼 영역 -->
	<div class="text-end">
		<c:if test="${loginUser eq assign.userId }">
			<button type="button" class="btn btn-outline-dark" id="btn-assign-delete"
				onclick="deleteClick()">양도취소</button>
		</c:if>
	</div>
	
	<!-- 양도 정보 -->
	<div class="my-5" id="assignInfo">
		<strong class="fs-3"><i class="fa-solid fa-campground"></i> 양도정보</strong>
		<hr />
		<table class="my-2 table">
			<tr>
				<th>양도마감일</th>
				<td><%= lastDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %></td>
				
			</tr>
			<tr>
				<th>구역</th>
				<td>
					<c:choose>
						<c:when test="${fn:startsWith(assign.resNo, 'ZA')}">데크존🌳</c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZB')}">반려견존🐕</c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZC')}">글램핑존🏕️</c:when>
						<c:when test="${fn:startsWith(assign.resNo, 'ZD')}">카라반존🚙</c:when>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>자리번호</th>
				<td>${res.campId}</td>
			</tr>
			<tr>
				<th>예약일자</th>
				<td>${res.resCheckin} ~ ${res.resCheckout} (<%= schedule %>)</td>
			</tr>
			<tr>
				<th>예약금액</th>
				<td><fmt:formatNumber value="${res.resPrice}" pattern="#,###"/>원</td>
			</tr>
			<tr>
				<th>양도금액</th>
				<td><fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</td>
			</tr>
		</table>
	</div>
	
	<div class="img-wrapper w-75 my-5 mx-auto row text-center">
		<p><strong class="fs-5">캠핑장 사진</strong></p>
	  	<c:forEach items="${photos}" var="photo" varStatus="vs">
			<div class="my-2">
				<img class="w-100" src="${pageContext.request.contextPath}/resources/upload/campPhoto/${photo.renamedFilename}" alt="" />
			</div>
	  	</c:forEach>
	  	
	  	<p class="mt-5"><strong class="fs-5">캠핑장 정보</strong></p>
	  	<div class="zoneInfo row d-flex justify-content-center">
	  		
	  	</div>
	</div>
	<div class=" d-flex justify-content-center">
		<button type="button" class="w-100 my-2 py-2 btn btn-outline-dark" id="btn-readmore">더보기▼</button>
	</div>
	
	<div class="mx-auto my-4">
		<strong class="fs-3"><i class="fa-solid fa-house-circle-exclamation"></i> 양도거래 시 유의사항</strong>
		<div class="card p-3">
			<ul>
				<li class="my-2">
					<strong># 반드시 캠핑장의 공지사항/유의사항 등을 숙지하시길 바랍니다. 캠핑장에 입실하여 발생되는 사고 및 분쟁에 대하여 캠핑이지는 책임사유가 없음을 알려 드립니다.
	(예 : 반려견 입장 불가/최대인원 제한/입,퇴실시간 준수 등)</strong>
				</li>
				<li class="my-2">
					<strong># 양도자의 사기거래로 인하여 캠핑장에 입실을 못 하시는 경우, 해당여부를 파악하여 예약양도결제금액에 한하여 전액취소처리가 가능합니다.</strong>
				</li>
			</ul>
		</div>
		<input type="checkbox" name="check" id="check" />
		<label class="align-middle" for="check">캠핑장 이용수칙과 양도거래 유의사항을 확인하였습니다.</label>
	</div>
	<div class="text-center">
	<form:form
		action="${pageContext.request.contextPath}/assignment/assignmentApplyForm.do"
		method="post"
		name="assignApplyForm">
		<input type="hidden" name="assignNo" value="${assign.assignNo}" />
			<c:if test="${loginUser ne null }">
				<!-- (로그인유저 != 양도등록자 and 양도대기상태) or (양도신청자 == 로그인유저) -->
				<c:if test="${(assign.userId ne loginUser) and (assign.assignState eq '양도대기') or (assign.assignTransfer eq loginUser)}">
					<input type="hidden" name="userId" value="${loginUser}" />
					<button type="button" class="w-50 mb-3 fs-5 btn btn-block" id="btn-assignment-apply"
						onclick="applyClick()">해당 예약 양도받기</button>
				</c:if>
			</c:if>
		
	</form:form>
	</div>
</div>
	
<script>
const resNo = "${assign.resNo}";
const zoneInfos = document.querySelector(".zoneInfo");

//---------------------------- 더보기 버튼 클릭시 ---------------------------- 
$(document).ready(function(){
	$("#btn-readmore").click((e) => {
		
		$.ajax({
			url: "${pageContext.request.contextPath}/camp/selectCampZone.do",
			data: {resNo},
			success(response){
				console.log(response);
				const {zoneInfo} = response;

				zoneInfo.forEach((zone) => {
					zoneInfos.innerHTML += `
						<img class="zoneImg col-2 my-3" src="${pageContext.request.contextPath}/resources/images/zone/\${zone}.png" alt="구역사진" />
					`;
				});
				 
			},
			error : console.log
		});
		
		const text = e.target;
	    if(text.textContent === "더보기▼"){
	      text.innerHTML = "접기▲";
	      zoneInfos.innerHTML = "";
	    } else {
	      text.innerHTML = "더보기▼";
	    }
		$(".img-wrapper").toggle();
	});
});

//---------------------------- 양도받기 버튼 클릭시 ---------------------------- 
const applyClick = () => {
	const check = document.querySelector("#check");
	const assignNo = "${assign.assignNo}";
	const assignTransfer = "${loginUser}";
	
	if(!check.checked){
		alert("유의사항을 확인하고 체크 부탁드립니다.");
		return;
	}
	
	const frm = document.assignApplyForm;
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	
	$.ajax({
		url : '${pageContext.request.contextPath}/assignment/assignmentCheck.do',
		headers,
		method : 'POST',
		data : {assignNo, assignTransfer},
		success(response){
			console.log(response);
			
			if(response || ${assign.assignTransfer eq loginUser}){
				frm.submit();
			}
			else {
				alert("다른 회원이 양도중인 예약입니다.");
				location.reload();
			}
		},
		error : console.log
	});
	
};

//---------------------------- 양도취소 버튼 클릭시 ---------------------------- 
const deleteClick = () => {
	
	const assignNo = '${assign.assignNo}';
	const assignState = '${assign.assignState}';
	
	if("양도대기" !== assignState){
		alert("양도중인 예약은 취소 불가능합니다.");
		return;
	}
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	
	if(confirm("해당 양도건을 취소하시겠습니까?")){
		
		$.ajax({
			url : '${pageContext.request.contextPath}/assignment/assignmentDelete.do',
			headers,
			method : 'POST',
			data : {assignNo},
			success(response){
				console.log(response);
				
				if(response){
					location.href="${pageContext.request.contextPath}/assignment/assignmentList.do";
				}
				else {
					alert("양도중인 예약은 취소 불가능합니다.");
					return;
				}
			},
			error : console.log
			
		});
	}
	
};

//화면 로드시 스크롤 이동
$(document).ready(function () {
	$('html, body, .container').animate({scrollTop: $('#myCarousel').outerHeight(true) - $('.blog-header').outerHeight(true) }, 'fast');
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>