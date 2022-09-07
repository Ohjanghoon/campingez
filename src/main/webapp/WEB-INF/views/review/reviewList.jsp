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
			revScore.innerHTML += '★';
		} else {
			revScore.innerHTML += '☆';
		}
	};
};
</script>
<style>
/* 말줄임 적용 */
#review-content {
  width: 100px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;  
}
</style>
<main>
	<section>
		<h2>리뷰리스트</h2>
		<form:form action="${pageContext.request.contextPath}/review/reviewListBySearchType.do" method="GET" name="searchFrm">
			<div id="select-bar">
				캠핑구역별		
				<select name="campZoneType" id="campZoneType" onchange="enrollFrm()">
					<option value="">전체</option>
					<c:forEach items="${campZoneList}" var="zone">
						<option value="${zone.zoneCode}" ${param.campZoneType eq zone.zoneCode ? 'selected' : ''}>${zone.zoneCode} - ${zone.zoneName}</option>
					</c:forEach>
				</select>
			
				<select name="searchType" id="searchType" onchange="enrollFrm()">
					<option value="rev_enroll_date" ${param.searchType eq 'rev_enroll_date' ? 'selected' : ''}>최신순</option>
					<option value="rev_score" ${param.searchType eq 'rev_score' ? 'selected' : ''}>평점순</option>
					<option value="rev_photo_no" ${param.searchType eq 'rev_photo_no' ? 'selected' : ''}>사진리뷰</option>
				</select>
			</div>
		</form:form>
		
		<ul>
		<c:if test="${not empty reviewList}">
			<c:forEach items="${reviewList}" var="review">
				<li data-review-id="${review.revId}">
					<div id="review-photo-box">
						<c:if test="${not empty review.reviewPhotos}">
							<c:forEach items="${review.reviewPhotos}" var="photo">
								<img src="${pageContext.request.contextPath}/resources/upload/review/${photo.revRenamedFilename}" width="150px"/>
							</c:forEach>
						</c:if>
					</div>
					<div id="review-score-${review.revId}">
						<script>renderStart(${review.revScore}, ${review.revId});</script>
						(${review.revScore}/5)
					</div>
					<div id="review-camp-box">
						${review.reservation.campId}
					</div>
					<div id="review-content">${review.revContent}</div>
					<div id="review-member-name">
						${review.reservation.resUsername}
					</div>
					<div id="review-enroll-date">
						<fmt:parseDate value="${review.revEnrollDate}" var="revEnrollDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
						<fmt:formatDate value="${revEnrollDate}" pattern="yyyy/MM/dd" />
					</div>
				</li>				
			</c:forEach>
		</c:if>
		<c:if test="${empty reviewList}">
			<li>조회된 리뷰가 없습니다.</li>
		</c:if>
		</ul>
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

document.querySelectorAll("li[data-review-id]").forEach((li) => {
	li.addEventListener('click', (e) => {
		const revId = e.target.parentElement.dataset.reviewId;
		if(!revId) return;
		location.href = `${pageContext.request.contextPath}/review/reviewDetail.do?revId=\${revId}`;
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>