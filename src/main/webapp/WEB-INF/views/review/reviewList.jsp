<%@page import="com.kh.campingez.review.model.dto.Review"%>
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
<script>
const renderStart = (score, revId) => {
	const revScore = document.querySelector(`#review-score-\${revId}`);

	for(let i = 0; i < 5; i++) {
		if(i < score) {
			revScore.innerHTML += '<i class="fa-solid fa-star"></i>';
		} else {
			revScore.innerHTML += '<i class="fa-regular fa-star"></i>';
		}
	};
};
</script>
<main>
	<div class="container">
		<h2 class="text-center fw-bold pt-5">캠핑이지 리뷰</h2>
		<form:form action="${pageContext.request.contextPath}/review/reviewListBySearchType.do" method="GET" name="searchFrm">
			<div id="select-bar" class="d-flex align-items-center">
				<strong class="text-muted p-2 "><i class="fa-solid fa-star"></i>구역별 리뷰 상세 조회<i class="fa-solid fa-star"></i></strong>		
				<select name="campZoneType" id="campZoneType" onchange="enrollFrm()" class="form-select-sm p-1 m-1" aria-label="Default select example">
					<option value="">전체</option>
					<c:forEach items="${campZoneList}" var="zone">
						<option value="${zone.zoneCode}" ${param.campZoneType eq zone.zoneCode ? 'selected' : ''}>${zone.zoneCode} - ${zone.zoneName}</option>
					</c:forEach>
				</select>
			
				<select name="searchType" id="searchType" onchange="enrollFrm()" class="form-select-sm p-1 m-1" aria-label="Default select example">
					<option value="rev_enroll_date" ${param.searchType eq 'rev_enroll_date' ? 'selected' : ''}>최신순</option>
					<option value="rev_score" ${param.searchType eq 'rev_score' ? 'selected' : ''}>평점순</option>
					<option value="rev_photo_no" ${param.searchType eq 'rev_photo_no' ? 'selected' : ''}>사진리뷰</option>
				</select>
			</div>
		</form:form>
		<hr />
		<div class="row row-cols-1 row-cols-md-3 g-4">
		<c:if test="${not empty reviewList}">
		<c:forEach items="${reviewList}" var="review">
			<div class="col">
				<div class="card">
					<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner">
							<c:if test="${not empty review.reviewPhotos}">
								<c:forEach items="${review.reviewPhotos}" var="photo">
									<div class="carousel-item active">
										<img src="${pageContext.request.contextPath}/resources/upload/review/${photo.revRenamedFilename}" class="d-block w-100" width="150px"/>
									</div>
								</c:forEach>
							</c:if>
							<c:if test="${empty review.reviewPhotos}">
								<div class="carousel-item active">
									<img src="${pageContext.request.contextPath}/resources/images/reservation/noimages.png" class="d-block w-100" />
								</div>
							</c:if>
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#carouselExampleControls" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#carouselExampleControls" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
					<div class="card-body">
						<h5 class="card-title">${review.userName} - ${review.reservation.campId}</h5>
						<p class="card-text">
							${review.revContent}
							<br />							
							<small class="text-muted">
									<code id="review-score-${review.revId}" class="card-text">
											<script>renderStart(${review.revScore}, ${review.revId});</script>
											(${review.revScore}/5)
									</code>
									<br />
									<fmt:parseDate value="${review.revEnrollDate}" var="revEnrollDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
									<fmt:formatDate value="${revEnrollDate}" pattern="yyyy/MM/dd" />
							</small>
						</p>
						<sec:authorize access="isAuthenticated()">
							<sec:authentication property="principal.username" var="loginUser"/>
							<sec:authorize access="hasRole('ROLE_ADMIN') or ${loginUser eq review.reservation.userId}" />
							<button class="btn btn-primary" id="update-btn" onclick="location.href ='${pageContext.request.contextPath}/review/reviewForm.do?resNo=${review.resNo}';">수정</button>
							<button class="btn btn-danger" id="delete-btn" onclick="location.href ='${pageContext.request.contextPath}/review/deleteReview.do?resNo=${review.resNo}';">삭제</button>
						</sec:authorize>
					</div>
				</div>
			</div>
			</c:forEach>
			</c:if>
		</div>
		<nav class="pt-5 m-3">
			${pagebar}
		</nav>
	</div>
</main>
<script>
	const enrollFrm = () => {
		const frm = document.searchFrm;
		frm.submit();
	};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>