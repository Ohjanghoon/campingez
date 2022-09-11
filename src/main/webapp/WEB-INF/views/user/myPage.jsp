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
</script>
<body>
	<div id="mypage">
		<div class="outter-div">
			<div class="inner-div card" id="userinfo">
				<div class="card-body">
					<form>
						<sec:authentication property="principal" var="result" scope="page" />
						<span>아이디 : ${result.userId}</span><br> 
						<span>이름 : ${result.userName}</span><br> 
						<span>경고횟수 : ${result.yellowCard}</span><br> 
						<span>잔여 포인트 : ${result.point}</span><br>
						<button onclick="popup()" class="btn btn-outline-dark">내정보 수정</button><br>
					</form>
				</div>
			</div>
			<div class="inner-div card" id="answer">
				<div class="card-body">
					<form
						action="${pageContext.request.contextPath}/userInfo/inquireList.do"
						method="GET">

						<c:forEach items="${inquireCnt}" var="cnt" varStatus="vs">
							<c:if test="${cnt.answerStatus == 0}">
								<span>답변대기 -> ${cnt.statusCnt} 건</span>
								<br>
							</c:if>
							<c:if test="${cnt.answerStatus == 1}">
								<span>답변완료 -> ${cnt.statusCnt} 건</span>
								<br>
							</c:if>
						</c:forEach>
						<button type="submit" class="btn btn-outline-dark">내가 쓴
							게시글</button>
						<br>
					</form>
				</div>
			</div>
		</div>
		<div class="outter-div">
			<div class="inner-div card" id="reserv">
				<div class="card-body">
					<form
						action="${pageContext.request.contextPath}/userInfo/myReservation.do"
						method="GET">
						<span>입실예정객실</span>
						<table class="table">
							<tr>
								<th scope="col">예약번호</th>
								<th scope="col">예약자 성명</th>
								<th scope="col">입실일자</th>
								<th scope="col">예약 상태</th>
							</tr>
							<c:forEach items="${reservationList}" var="res" varStatus="vs">
								<tr>
									<td>${res.resNo}</td>
									<td>${res.resUsername}</td>
									<td>${res.resCheckin}</td>
									<td>${res.resState}</td>
								</tr>
							</c:forEach>
						</table>
						<button type="submit" class="btn btn-outline-dark">예약 정보
							상세</button>
						<br>
					</form>
				</div>
			</div>
			<div class="inner-div card" id="coupon">
				<div class="card-body">
					<span>내 쿠폰함</span>
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
	</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>