<%@page import="java.time.Duration"%>
<%@page import="com.kh.campingez.campzone.model.dto.CampPhoto"%>
<%@page import="com.kh.campingez.reservation.model.dto.Reservation"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.List"%>
<%@page import="com.kh.campingez.assignment.model.dto.Assignment"%>
<%@page import="java.text.DecimalFormat"%>
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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/assignment/assignmentList.css" />
<style>
[name=assignInfo] {
	cursor: pointer;
}

#btn-assignment-enroll {
	font-weight : bold;
	background-color : #A8A4CE;
	color : white;
}

#btn-assignment-enroll:hover {
	color : #495C83;
}

.assignTitle .assignState {
	padding : 0.5rem;
	border-radius : 0.5rem;
	border : 1px solid #495C83;
	color : #495C83;
	vertical-align : text-top;
}
#btn-more-container {
	position : relative;
}
#btn_top{
    width: 50px; 
    height: 50px;
    border: 1px solid #A8A4CE; 
    color: #A8A4CE;
    cursor: pointer;
    position: fixed; bottom: 200px; right: 350px;
    z-index: 100000;
}
#btn_bottom {
	width: 50px; 
    height: 50px;
    border: 1px solid #A8A4CE; 
    color: #A8A4CE;
    cursor: pointer;
    position: fixed; bottom: 150px; right: 350px;
    z-index: 100000;
}
</style>
<div class="container">

	<sec:authorize access="isAuthenticated()">
	<div class="text-center">
		<form:form action="${pageContext.request.contextPath}/assignment/assignmentForm.do" method="POST">
			<input type="hidden" name="userId" value='<sec:authentication property="principal.username"/>' />
			<button type="submit" class="w-50 mb-3 fs-5 btn btn-block" id="btn-assignment-enroll">양도 등록</button>
		</form:form>
	</div>
	</sec:authorize>
	<div id="assign-container"></div>
	<div class="text-center" id='btn-more-container'>
		<button class="w-50 btn btn-outline-dark" id="btn-more" value="" >
			더보기 (<span id="cPage"></span> / <span id="totalPage">${totalPage}</span>)
		</button>
		<button type="button" id="btn_top" onclick="scrollToTop();">▲</button>
		<button type="button" id="btn_bottom" onclick="scrollToBottom();">▼</button>
	</div>
</div>
<script>
document.querySelector("#btn-more").addEventListener('click', (e) => {
	const cPage = Number(document.querySelector("#cPage").textContent) + 1;
	getPage(cPage);
});


const getPage = (cPage) => {
	$.ajax({
		url : '${pageContext.request.contextPath}/assignment/assignmentListMore.do',
		data : {cPage},
		success(response){
			console.log(response);
			
			response.forEach((assign) => {
				let {assignNo, resNo, userId, assignDate, assignTitle, assignState, assignPrice, 
					campPhotos, reservation : {campId, resCheckin, resCheckout}} = assign;
				
				assignState = assignStateChange(assignState);	
				
				checkin = new Date(resCheckin);
				checkout = new Date(resCheckout);

				let finish = new Date(new Date(checkin).setDate(checkin.getDate() - 1));
				finish = formatDate(finish);
				//console.log(new Date(resCheckin.setDate(resCheckin.getDate() - 1)));

				const zoneCode = zoneCodeKr(resNo.substring(0, 2));
				const schedule = calSchedule(checkin, checkout);
				
				let html = `
					<div class="w-50 mt-4 mx-auto card" name="assignInfo"  data-no="\${assignNo}">
						<div class="py-2 d-flex justify-content-around" name="userInfo">
						<!-- 양도 작성자 -->
						<span>
							<i class="fa-solid fa-user"></i>
							\${userId}
						</span>
						<!-- 양도글 등록일자 -->
						<span class="assignDate text-secondary">
							\${assignDate}
						</span>
					</div>
					<div class="img-wrapper">
					`;
					
				campPhotos.forEach((photo) => {
					const {renamedFilename} = photo;
					html += `
						<div>
							<img class="w-100" src="${pageContext.request.contextPath}/resources/upload/campPhoto/\${renamedFilename}"/>
						</div>
					`;
				});
					
				html += `
					</div>
					<table class="assignTitle mx-3 mt-3 " name="assignTitle">
						<tr>
							<th class="fs-4">\${assignTitle}</th> <!-- 양도글 제목 -->
							<td class="d-flex justify-content-end"> <!-- 양도 상태 -->
								\${assignState}
							</td>
						</tr>
						<tr>
							<td class="pt-2">양도마감일 <strong>\${finish}</strong></td> <!-- 양도마감일 -->
						</tr>
					</table>
					<!-- 예약 정보 -->
					<table class="m-3" name="resInfo">
						<tr>
							<th>예약일자</th>
							<td>입실 : \${resCheckin} / 퇴실 : \${resCheckout} <span>(\${schedule})</span></td>
						</tr>
						<tr>
							<th>구역</th>
							<td>\${zoneCode}</td>
						</tr>
						<tr>
							<th>자리번호</th>
							<td>\${campId}</td>
						</tr>
						<tr>
							<th>양도금액</th>
							<td>\${assignPrice.toLocaleString('ko-KR')}원</td>
						</tr>
					</table>
				</div>
				`;		
				const container = document.querySelector("#assign-container");
				container.insertAdjacentHTML('beforeend', html);
				
				
			});
			document.querySelectorAll(".assignDate").forEach((span) => {
				let assignDate = span.innerHTML; 
				console.log();
				if(!(assignDate.includes('전'))){
					span.innerHTML = beforeTime(assignDate);
				}
			
			});
			
			
		},
		error : console.log,
		complete(){
			
			// 더보기 버튼에 현재 페이지 표시
			document.querySelector('#cPage').innerHTML = cPage;

			// 현재 페이지 == 마지막 페이지 일 때, 더보기 버튼 비활성화 
			if(cPage == ${totalPage}){
				document.querySelector("#btn-more").disabled = true;
			}
			
			// 이미지 슬라이더 슬릭
			const slider = $('.img-wrapper');
			const slickOptions = {
					infinite: true,
					autoplay: true,
				    autoplaySpeed: 2000,
				    cssEase: 'linear',
				    prevArrow : false,
				    nextArrow : false
			};	
			
			$(document).ready(function(){
				slider.not('.slick-initialized').slick(slickOptions);
			});
			
			//본문 링크 이동
			document.querySelectorAll("[name=assignInfo]").forEach((assignInfo) => {
				
				assignInfo.addEventListener('click', (e) => {
					//console.log(assignInfo.dataset.no);
					const no = assignInfo.dataset.no;
					if(no){
						location.href="${pageContext.request.contextPath}/assignment/assignmentDetail.do?assignNo=" + no;
					}
				});
			});
		}
	});
};

// 첫 화면
getPage(1);

// 날짜 포맷팅
const formatDate = (val) => {
	const yyyy = val.getFullYear();
	let MM = val.getMonth() + 1;
	let dd = val.getDate();
	
	if(MM < 10){
		MM = "0" + MM; 
	}
	if(dd < 10){
		dd = "0" + dd;
	}
	
	return yyyy + "-" + MM + "-" + dd;
};

// N박 M일 포맷팅
const calSchedule = (date1, date2) => {
	const date = (date2 - date1) / 1000 / 60 / 60 / 24;
	return date + '박' + (date + 1) + '일';
};

// 구역 코드
const zoneCodeKr = (zoneCode) => {
	switch(zoneCode) {
	case 'ZA' : return '데크존🌳';
	case 'ZB' : return '반려견존🐕';
	case 'ZC' : return '글램핑존🏕️';
	case 'ZD' : return '카라반존🚙';
	}
};

// 양도 상태
const assignStateChange = (assignState) => {
	switch(assignState){
	case "양도대기" : return `<strong class="assignState"><i class="fa-solid fa-hourglass-start"></i>&nbsp;\${assignState}</strong>`;
	case "양도중" : return `<strong class="assignState"><i class="fa-solid fa-hourglass-half"></i>&nbsp;\${assignState}</strong>`; 
	}
};

// 스크롤 제어
const scrollToTop = () => {
	window.scrollTo({
	    top: 0
	});
};
const scrollToBottom = () => {
	window.scrollTo(0, document.body.scrollHeight);
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>