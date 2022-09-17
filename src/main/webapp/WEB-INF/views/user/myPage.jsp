<%@page import="com.kh.campingez.assignment.model.dto.Assignment"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDateTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<script>
	function popup() {
		var url = "${pageContext.request.contextPath}/userInfo/popupAuthentication.do";
		var name = "info authentication";
		var option = "width = 700, height = 700, top = 150, left = 600, location = no"
		window.open(url, name, option);
	}
	function inquire() {
		document.getElementById('inquire').submit();
	}
	function trade() {
		document.getElementById('trade').submit();
	}
</script>
<body>
	<div class="container">
		<h3 style="margin: 40px;">마이페이지</h3>
		<hr style="color: #c6b5e1;">
		<div id="mypage">
			<div class="parent">
				<div id="first">
					<form>
						<div id="first-2">
							<sec:authentication property="principal" var="result"
								scope="page" />
							<c:if test="${result.gender == 'M'}">
								<img style="padding-bottom: 50px;" id="preview"
									src="${pageContext.request.contextPath}/resources/images/mypage/man.png"
									width="250px">
							</c:if>
							<c:if test="${result.gender == 'F'}">
								<img style="padding-bottom: 50px;" id="preview"
									src="${pageContext.request.contextPath}/resources/images/mypage/girl.png"
									width="250px">
							</c:if>
							<div style="margin-top: 20px;">
								<span style="font-size: 22pt;">${result.userName} 님</span><br>
								<br> <span>아이디 : ${result.userId}</span><br> <span>경고횟수
									: ${result.yellowCard}</span><br> <span>잔여 포인트 : <fmt:formatNumber
										value="${result.point}" pattern="#,###" />point
								</span><br>
							</div>
						</div>
					</form>
				</div>
				<div id="second">
					<span style="font-size: 22pt;">1:1 문의</span>
					<form id="inquire"
						action="${pageContext.request.contextPath}/userInfo/inquireList.do"
						method="GET">
						<br>
						<c:forEach items="${inquireCnt}" var="cnt" varStatus="vs">
							<c:if test="${cnt.answerStatus == 0}">
								<span>답변대기 <img
									src="${pageContext.request.contextPath}/resources/images/mypage/arrow.png"
									width="30px"> ${cnt.statusCnt} 건
								</span>
								<br>
								<br>
							</c:if>
							<c:if test="${cnt.answerStatus == 1}">
								<span>답변완료 <img
									src="${pageContext.request.contextPath}/resources/images/mypage/arrow.png"
									width="30px"> ${cnt.statusCnt} 건
								</span>
								<br>
								<br>
							</c:if>
						</c:forEach>
						<br>
					</form>
				</div>
				<div id="third">
					<span style="font-size: 22pt;">중고물품 거래</span>
					<form id="trade"
						action="${pageContext.request.contextPath}/userInfo/myTradeList.do"
						method="GET">
						<br>
						<c:forEach items="${tradeCnt}" var="trade" varStatus="vs">
							<span>${trade.answerStatus} <img
								src="${pageContext.request.contextPath}/resources/images/mypage/arrow.png"
								width="30px"> ${trade.statusCnt} 건
							</span>
							<br>
							<br>
						</c:forEach>
						<br>
					</form>
				</div>
				<div class="button-parent">
					<button onclick="popup()" class="btn btn-outline-dark">정보변경</button>
					<button onclick="inquire()" class="btn btn-outline-dark">1:1문의</button>
					<button onclick="trade()" class="btn btn-outline-dark">중고거래</button>
				</div>
			</div>
			<div style="margin-top : 30px;" class="parent">
				<div style="margin : 35px; width: 80%;" id="coupon">
					<div>
						<span style="font-size: 22pt; margin-left :10px;"> <img style="margin-right:20px; margin-bottom:20px;"
							src="${pageContext.request.contextPath}/resources/images/mypage/coupon.png"
							width="50px">내 쿠폰함
						</span>
						<table class="table">
							<tr>
								<th scope="col">쿠폰이름</th>
								<th scope="col">쿠폰코드</th>
								<th scope="col">할인율 %</th>
								<th scope="col">사용가능기간</th>
								<th scope="col">사용가능여부</th>
							</tr>
							<c:forEach items="${couponList}" var="coupon" varStatus="vs">
								<tr>
									<td>${coupon.couponName}</td>
									<td>${coupon.couponCode}</td>
									<td>${coupon.couponDiscount}%</td>
									<td>${coupon.couponStartday}~${coupon.couponEndday}</td>
									<c:if test="${coupon.couponUsedate == 'Y'}">
										<td>사용가능</td>
									</c:if>
									<c:if test="${coupon.couponUsedate == 'N'}">
										<td>사용완료</td>
									</c:if>

								</tr>
							</c:forEach>
						</table>
					</div>
				</div>

			</div>
			<div style="margin-top : 30px;" class="parent">
				<div  style="margin : 35px; width: 80%;" id="assign">
					<div>
						<form
							action="${pageContext.request.contextPath}/userInfo/assignment.do"
							method="GET">
							<span style="font-size: 22pt; margin-left :10px; ">
							<img style="margin-right:20px; margin-bottom:20px;"
							src="${pageContext.request.contextPath}/resources/images/mypage/reservation.png"
							width="50px">
							등록한 양도글 확인
							</span>
							<button style="margin-left: 480px; margin-bottom: 20px;" type="submit" class="btn btn-outline-dark">상세 보기</button>
							<table class="table">
								<tr>
									<th scope="col">예약번호</th>
									<th scope="col">제목</th>
									<th scope="col">양도 가격</th>
									<th scope="col">양도마감 일자</th>
									<th scope="col">상태</th>
								</tr>
								<c:forEach items="${assignList}" var="assign" varStatus="vs"
									begin="0" end="2">
									<tr>
										<td>${assign.resNo}</td>
										<td>${assign.assignTitle}</td>
										<td><fmt:formatNumber value="${assign.assignPrice}"
												pattern="#,###" />원</td>
										<td><fmt:parseDate value="${assign.assignDate}"
												pattern="yyyy-MM-dd'T'HH:mm:ss" var="assignDate" /> <fmt:formatDate
												value="${assignDate}" pattern="yyyy-MM-dd" /></td>
										<td>${assign.assignState}</td>
									</tr>
								</c:forEach>
							</table>
							<br>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>