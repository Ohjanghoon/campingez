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

<sec:authentication property="principal" var="result" scope="page" />
<style>
.row{
	margin-top :10px;
}
</style>
<div id="mypage">
	<br>
	<h1>예약정보 상세</h1>
	<div class="outter-div g-3">
	<hr>
		<div class="row g-3">
			<div class="col">
				<label class="form-label">예약번호</label> 
				<input type="text"class="form-control" name="userId" id="userId"value="${res.resNo}" readonly/>
			</div>
			<div class="col">
				<label class="form-label">자리 아이디</label> 
				<input type="text" class="form-control"  value="${res.campId}" readonly/>
			</div>
		</div>
		<div class="row g-3">
			<div class="col">
				<label class="form-label">회원 아이디</label> 
				<input type="text" class="form-control"  value="${res.userId}" readonly/>
			</div>
			<div class="col">
				<label class="form-label">예약자 성명</label> 
				<input type="text" class="form-control"  value="${res.resUsername}" readonly/>
			</div>
		</div>
		<div class="row g-3">
			<div class="col">
				<label class="form-label">전화번호</label> 
				<input type="text" class="form-control"  value="${res.resPhone}" readonly/>
			</div>
			<div class="col">
				<label class="form-label">인원</label> 
				<input type="text" class="form-control"  value="${res.resPerson}" readonly/>
			</div>
		</div>
		<div class="row g-3">
			<div class="col">
				<label class="form-label">금액</label> 
				<input type="text" class="form-control"  value="${res.resPrice}" readonly/>
			</div>
			<div class="col">
				<label class="form-label">예약일자</label> 
				<input type="text" class="form-control"  value="${res.resDate}" readonly/>
			</div>
		</div>
		<div class="row g-3">
			<div class="col">
				<label class="form-label">입실일자</label> 
				<input type="text" class="form-control"  value="${res.resCheckin}" readonly/>
			</div>
			<div class="col">
				<label class="form-label">퇴실일자</label> 
				<input type="text" class="form-control"  value="${res.resCheckout}" readonly/>
			</div>
		</div>
		<div class="row g-3">
			<div class="col">
				<label class="form-label">차량번호</label>
				<input type="text" class="form-control"  value="${res.resCarNo}" readonly/>
			</div>
			<div class="col">
				<label class="form-label">상태</label> 
				<input type="text" class="form-control"  value="${res.resState}" readonly/>
			</div>
			<div class="col">
				<label class="form-label">결제수단</label> 
				<input type="text" class="form-control"  value="${res.resPayment}" readonly/>
			</div>
		</div>
	    <div class="row g-3">
			<div class="col-12">
				<label class="form-label">예약 요청사항</label> 
				<input type="text" class="form-control"  value="${res.resRequest}" readonly/>
			</div>
		</div>
	</div>
</div>
</body>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>