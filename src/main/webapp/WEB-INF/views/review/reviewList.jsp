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
						사진
					</div>
					<div id="review-content-box">
						<div id="review-score">
							${review.revScore}
						</div>
						<div id="review-content">${review.revContent}</div>
						<div id="review-enroll-date">${review.revEnrollDate}</div>
					</div>
				</li>				
			</c:forEach>
		</c:if>
		</ul>
	</section>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>