<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<style>
.btn-outline-dark{
	border-color: #A8A4CE !important;
	color: #A8A4CE !important;
}
.btn-outline-dark:hover{
	background-color: #A8A4CE !important;
	color: white !important;
}
</style>
<main>
	<div class="container">
	<h2 class="text-center fw-bold pt-5">공지사항</h2>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		<div class="d-grid gap-2 d-md-flex justify-content-md-end pt-5">
			<button class="btn btn-outline-dark" type="button" id="notice">공지사항 등록 <i class="fa-regular fa-pen-to-square"></i></button>
			<button class="btn btn-outline-dark" type="button" id="event">이벤트 등록 <i class="fa-regular fa-calendar"></i></button>
			<button class="btn btn-outline-dark" type="button" id="coupon">쿠폰 생성 <i class="fa-solid fa-barcode"></i></button>
		</div>
	</sec:authorize>
	<hr/>
	<table class="table table-lg">
		<thead>
			<tr>
				<th></th>
				<th>Category</th>
				<th>Title</th>
				<th>Date</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty list}">
				<c:forEach items="${list}" var="list" >
					<tr data-notice-no="${list.noticeNo}">
						<td><i class="fa-regular fa-clipboard"></i></td>
						<td>${list.categoryId == 'not1' ? '공지사항' : '이벤트'}</td>
						<td>${list.noticeTitle} [${list.noticeType}]</td>
						<td>${list.noticeDate}</td>
					</tr>
				</c:forEach>
			</c:if>			
		</tbody>
	</table>
	<nav>${pagebar}</nav>
	</div>
</main>
<sec:authorize access="hasRole('ROLE_ADMIN')">
	<script>
	
		// 공지사항 등록
		document.querySelector("#notice").addEventListener('click', (e) => {
			location.href = "${pageContext.request.contextPath}/notice/enrollNotice.do";
		});
		
		// 이벤트 등록
		document.querySelector("#event").addEventListener('click', (e) => {
			location.href = "${pageContext.request.contextPath}/notice/enrollEvent.do";
		});
		
		// 쿠폰 등록
		document.querySelector("#coupon").addEventListener('click', (e) => {
			location.href = "${pageContext.request.contextPath}/coupon/insertCoupon.do";
		});
	</script>
</sec:authorize>
	<script>
	
		const insertHandler = (e) => {
			const parent = e.target.parentElement;
			const noticeNo = parent.dataset.noticeNo;
			console.log(noticeNo);
			
			location.href = `${pageContext.request.contextPath}/notice/detail.do?noticeNo=\${noticeNo}`;
		};
		
		document.querySelectorAll("tr[data-notice-no]").forEach((tr) => {
			tr.addEventListener('click', insertHandler);
		});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>