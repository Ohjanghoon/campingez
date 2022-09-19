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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/review.css" />
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
	<sec:authentication property="principal" var="loginMember" scope="page" />
		
	<section>
		<h2>리뷰리스트</h2>
		<form:form action="${pageContext.request.contextPath}/review/reviewListBySearchType.do" method="GET" name="searchFrm">
			<div id="select-bar" class="d-flex">
				캠핑구역별		
				<select name="campZoneType" id="campZoneType" onchange="enrollFrm()" class="form-select form-select-sm" aria-label="Default select example">
					<option value="">전체</option>
					<c:forEach items="${campZoneList}" var="zone">
						<option value="${zone.zoneCode}" ${param.campZoneType eq zone.zoneCode ? 'selected' : ''}>${zone.zoneCode} - ${zone.zoneName}</option>
					</c:forEach>
				</select>
			
				<select name="searchType" id="searchType" onchange="enrollFrm()" class="form-select form-select-sm" aria-label="Default select example">
					<option value="rev_enroll_date" ${param.searchType eq 'rev_enroll_date' ? 'selected' : ''}>최신순</option>
					<option value="rev_score" ${param.searchType eq 'rev_score' ? 'selected' : ''}>평점순</option>
					<option value="rev_photo_no" ${param.searchType eq 'rev_photo_no' ? 'selected' : ''}>사진리뷰</option>
				</select>
			</div>
		</form:form>
		<div class="card-group">
			<ul class="review-list">
			<c:if test="${not empty reviewList}">
				<c:forEach items="${reviewList}" var="review">
					<div class="card" data-review-id="${review.revId}" data-bs-toggle="modal" data-bs-target="#reviewDetailModal" >
						<li class="review">
							<div id="review-photo-box">
								<c:if test="${not empty review.reviewPhotos}">
									<c:forEach items="${review.reviewPhotos}" var="photo">
										<img src="${pageContext.request.contextPath}/resources/upload/review/${photo.revRenamedFilename}" class="card-img-top" width="150px"/>
									</c:forEach>
								</c:if>
								<c:if test="${empty review.reviewPhotos}">
									<img src="${pageContext.request.contextPath}/resources/images/reservation/noimages.png" width="150px" />
								</c:if>
							</div>
							<div class="content-wrap">
								<div class="user-info-wrap">
										<div id="review-member-name" class="card-text">
											${review.userName}
										</div>
										<div id="review-score-${review.revId}" class="card-text">
											<script>renderStart(${review.revScore}, ${review.revId});</script>
											(${review.revScore}/5)
										</div>
									</div>
									<div id="review-camp-box" class="card-text">
										${review.reservation.campId}
									</div>
									<div id="review-content" class="card-text">${review.revContent}</div>
								<div id="review-enroll-date" class="card-text">
									<fmt:parseDate value="${review.revEnrollDate}" var="revEnrollDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
									<fmt:formatDate value="${revEnrollDate}" pattern="yyyy/MM/dd" />
								</div>
								<button type="button" id="review-detail-btn">리뷰 상세보기</button>
							</div>
						</li>				
					</div>
				</c:forEach>
			</c:if>
			<c:if test="${empty reviewList}">
				<li>조회된 리뷰가 없습니다.</li>
			</c:if>
			</ul>
		</div>
		<!-- 모달 -->
		<div class="modal" tabindex="-1" id="reviewDetailModal">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">리뷰 상세보기</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <div class="modal-body" id="reviewDetailBody">
		      </div>
		      <div class="modal-footer" id="reviewDetailFooter">
		      		<div class="btn-wrap"></div>
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
		<nav>
			${pagebar}
		</nav>
	</section>
</main>
<script>
const enrollFrm = () => {
	const frm = document.searchFrm;
	frm.submit();
};

document.querySelectorAll(".card").forEach((li) => {
	li.addEventListener('click', (e) => {
		const revId = e.target.offsetParent.dataset.reviewId;
		if(!revId) return;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/review/reviewDetail.do",
			data : {revId},
			content : "application/json",
			success(response) {
				console.log(response);
				const {reservation, revContent, revEnrollDate, revId, reviewPhotos, zoneCode, userName} = response;
				const {campId, resUsername, userId} = reservation;
				const [yy, MM, dd] = revEnrollDate;
				
				const body = document.querySelector("#reviewDetailBody");
				body.innerHTML = '';	
				const html = `
				<div id="userinfo-wrap">
					<div id="name">\${userName}</div>
					<div id="enroll-date">
						\${yy}/\${MM}/\${dd}
					</div>
					<div id="campinfo-wrap">
						<div id="zone-code">
							[\${zoneCode}구역] - \${campId}자리
						</div>
					</div>
				</div>
				<div id="photo-wrap"></div>
				<div id="content-wrap">
					\${revContent}
				</div>
				`;
				body.insertAdjacentHTML('beforeend', html);
				
				// 사진 처리
				const photowrap = document.querySelector("#photo-wrap");
				photowrap.innerHTML = '';
				if(reviewPhotos.length > 0) {
					reviewPhotos.forEach((photo) => {
						const {revRenamedFilename} = photo;
						
						photowrap.innerHTML = `
						<img src="${pageContext.request.contextPath}/resources/upload/review/\${revRenamedFilename}" width="150px"/>
						`;
					});
				} else {
					photowrap.innerHTML = `
					<img src="${pageContext.request.contextPath}/resources/images/reservation/noimages.png" width="150px" />
					`;
				}
				
				// 버튼 처리
				const user = "<sec:authentication property='principal.username'/>";
				const auth = "<sec:authorize access='hasRole("ROLE_ADMIN")' />";
				const footer = document.querySelector(".btn-wrap");
				footer.innerHTML = '';
				if(user == userId || auth.indexOf("ADMIN") > 0) {
					const btn = `
						<button id="update-btn">수정</button>
						<button id="delete-btn">삭제</button>
					`;
					footer.insertAdjacentHTML('beforeend', btn);
				}
			},
			error : console.log
		})
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>