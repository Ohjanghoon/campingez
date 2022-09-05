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
<main>
	<section>
		<h2>리뷰리스트</h2>
		<ul>
		<c:if test="${not empty reviewList}">
			<c:forEach items="${reviewList}" var="review">
				<li>
					<div id="review-photo-box">
						<c:if test="${not empty review.reviewPhotos}">
							<c:forEach items="${review.reviewPhotos}"></c:forEach>
						</c:if>
					</div>
					<div id="review-content-box">
						<div id="review-score">
							
						</div>
						<div id="review-content">${review.revContent}</div>
						<div id="review-member-name">
							${review.reservation.resUsername}
						</div>
						<div id="review-enroll-date">
							<fmt:parseDate value="${review.revEnrollDate}" var="revEnrollDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
							<fmt:formatDate value="${revEnrollDate}" pattern="yyyy/MM/dd" />
						</div>
					</div>
				</li>				
			</c:forEach>
		</c:if>
		</ul>
	</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>