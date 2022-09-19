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
<%--
	List<Assignment> assignList = (List<Assignment>) request.getAttribute("assignmentList");
--%>
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
			더보기(<span id="cPage"></span> / <span id="totalPage">${totalPage}</span>)
		</button>
	</div>
</div>
<script>
window.onload = () => {
		
	document.querySelectorAll(".assignDate").forEach((span) => {
		let assignDate = span.innerHTML; 
	
		span.innerHTML = beforeTime(assignDate);
	});
		
};
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
					campPhotos, reservation : {resCheckin, resCheckout}} = assign;
				
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
					<div>
					`;
					
				campPhotos.forEach((photo) => {
					const {renamedFilename} = photo;
					html += `<img class="w-100" src="${pageContext.request.contextPath}/resources/upload/campPhoto/\${renamedFilename}"/>`;
				});
					
				html += `
						</div>
					</div>
				`;		
							
				
				
				const container = document.querySelector("#assign-container");
				
				container.insertAdjacentHTML('beforeend', html);
			});
		},
		error : console.log,
		complete(){
			document.querySelector('#cPage').innerHTML = cPage;
		}
	});
};

getPage(1);
$(document).ready(function(){
	$('.img-wrapper').slick({
		infinite: true,
		autoplay: true,
        autoplaySpeed: 2000,
        cssEase: 'linear',
        prevArrow : false,
        nextArrow : false
         
	});
});

document.querySelectorAll("[name=assignInfo]").forEach((assignInfo) => {
	
	assignInfo.addEventListener('click', (e) => {
		//console.log(assignInfo.dataset.no);
		const no = assignInfo.dataset.no;
		if(no){
			location.href="${pageContext.request.contextPath}/assignment/assignmentDetail.do?assignNo=" + no;
		}
	});
});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>