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
    width: 30px; 
    height: 30px;
    border: 1px solid #A8A4CE; 
    color: #A8A4CE;
    cursor: pointer;
    position: fixed; bottom: 30%; right: 5%;
    z-index : 2;
}
#btn_bottom {
	width: 30px; 
    height: 30px;
    border: 1px solid #A8A4CE; 
    color: #A8A4CE;
    cursor: pointer;
    position: fixed; bottom: 26%; right: 5%;
    z-index : 2;
}
#assignListHeader {
	height : 20%;
	background-color : black;
}

#zoneSelect {
}
</style>
<header class="py-2 top">
	<div class="container px-4 px-lg-5 mt-5">
		<h1 class="display-4 text-center fw-bolder">양도</h1>
		<hr />
	</div>
</header>
<div class="container w-75">
	<div class="text-center">
		<p><strong>구역별로 모아보기 </strong></p>

		<select class="w-25 p-2 form-select mx-auto border border-dark" name="zoneSelect" id="zoneSelect">
			<option value="" selected>전체보기</option>
			<option value="ZA">🌳 데크존</option>
			<option value="ZB">🐕 반려견존</option>
			<option value="ZC">🏕️ 글램핑존</option>
			<option value="ZD">🚙 카라반존</option>
		</select>
		<div class="my-3 text-end">
		<sec:authorize access="isAuthenticated()">
			<form:form action="${pageContext.request.contextPath}/assignment/assignmentForm.do" method="POST">
				<input type="hidden" name="userId" value='<sec:authentication property="principal.username"/>' />
				<button type="submit" class="mb-3 btn btn-block" id="btn-assignment-enroll">양도 등록</button>
			</form:form>
		</sec:authorize>
	</div>
		
	</div>
	
	
	<div id="assign-container"></div>
	<div class="text-center mt-4" id='btn-more-container'>
		<button class="w-75 p-2 btn btn-outline-dark" id="btn-more" value="" >
			<strong>더보기 ( <span id="cPage"></span> / <span id="totalPage">${totalPage}</span> )</strong>
		</button>
		<button type="button" id="btn_top" onclick="scrollToTop();">▲</button>
		<button type="button" id="btn_bottom" onclick="scrollToBottom();">▼</button>
	</div>
</div>
<script>
let zoneSelect = "";

const getPage = (cPage, zoneSelect) => {
	//console.log(typeof zoneSelect);
	$.ajax({
		url : '${pageContext.request.contextPath}/assignment/assignmentListMore.do',
		data : {cPage, zoneSelect},
		success(response){
			console.log(response);
			const {list, totalPage} = response;
			
			let html = ``;
			if(totalPage == 0){
				html = `
					<div class="w-75 mt-4 mx-auto card text-center">
						<p class="p-5">해당 구역의 양도건이 존재하지 않습니다.</p>
					</div>
				`;
				const container = document.querySelector("#assign-container");
				container.insertAdjacentHTML('beforeend', html);
			}
			list.forEach((assign) => {
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
				
				html = `
					<div class="w-75 mt-4 mx-auto card" name="assignInfo"  data-no="\${assignNo}">
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
			
			const total = document.querySelector("#totalPage");
			
			total.innerHTML = totalPage;
			
			// 더보기 버튼에 현재 페이지 표시
			document.querySelector('#cPage').innerHTML = cPage;

			// 현재 페이지 == 마지막 페이지 일 때, 더보기 버튼 비활성화
			if(cPage >= total.innerHTML){
				document.querySelector("#btn-more").disabled = true;
			} else {
				document.querySelector("#btn-more").disabled = false;
			}
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

//첫 화면
getPage(1, "");


document.querySelector("#zoneSelect").addEventListener('change', (e) => {
	const container = document.querySelector("#assign-container");
	container.innerHTML = "";
	zoneSelect = e.target.value;
	getPage(1, zoneSelect);
});

document.querySelector("#btn-more").addEventListener('click', (e) => {
	const cPage = Number(document.querySelector("#cPage").textContent) + 1;
	getPage(cPage, zoneSelect);
});


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
	$('html, body').animate({scrollTop: $('#top').offset().top - 135}, 'fast');
};
const scrollToBottom = () => {
	window.scrollTo(0, document.body.scrollHeight);
}

//화면 로드시 스크롤 이동
$(document).ready(function () {
	$('html, body, .container').animate({scrollTop: $('#myCarousel').outerHeight(true) - $('.blog-header').outerHeight(true) }, 'fast');
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>