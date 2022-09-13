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
<div id="mypage">
	<br>
	<h1>Update Profile!</h1>
	<div class="outter-div">
	<hr>
		<form:form
			action="${pageContext.request.contextPath}/userInfo/profileUpdate.do"
			method="POST" class="row g-3">

			<div class="col-12">
				<label class="form-label">Userid</label> <input type="text"
					class="form-control" name="userId" id="userId"
					value="${result.userId}" readonly required />
			</div>
			<div class="col-12">
				<label class="form-label">Current Password</label> <input type="text"
					class="form-control" name="cPassword" id="cPassword" placeholder="현재 비밀번호를 입력하세요" required />
			</div>
			<div class="col-12">
				<label class="form-label">Password to be replaced</label> <input type="text"
					class="form-control" name= "rPassword" id="rPassword" placeholder="변경할 비밀번호를 입력하세요"/>
			</div>
			<div class="col-12">
				<label class="form-label">Username</label> <input type="text"
					class="form-control" name="userName" id="userName"
					value="${result.userName}" required />

			</div>
			<div class="col-12">
				<label class="form-label">Email</label> <input type="text"
					class="form-control" name="email" id="email"
					value="${result.email}" required />
			</div>
			<div class="col-12">
				<label class="form-label">Phone</label> <input type="text"
					class="form-control" name="phone" id="phone"
					value="${result.phone}" required />
			</div>
			<div class="col-12">
				<label class="form-label">Gender</label>
				<select class="form-control" name="gender" id="gender">
					<option value="M" ${result.gender == "M" ? 'selected' : ""}>M</option>
					<option value="F" ${result.gender == "F" ? 'selected' : ""}>F</option>
				</select>
				<%--  <input type="text"class="form-control" name="gender" id="gender" value="${result.gender}" /> --%>
			</div>
			<div class="col-12">
				<label class="form-label">Notice</label> <input type="text"
					class="form-control" name="yellowCard" id="yellowCard"
					value="${result.yellowCard}" readonly />
			</div>
			<div class="col-12">
				<label class="form-label">Point</label> <input type="text"
					class="form-control" name="point" id="point"
					value="${result.point}" readonly />
			<br>
			</div>
			<hr>
			<input type="submit" value="정보수정" class="btn btn-outline-dark">
		</form:form>
		<form:form
			action="${pageContext.request.contextPath}/userInfo/profileDelete.do"
			method="POST" class="row g-3">
			<input type="hidden" name="userId" id="userId"
				value="${result.userId}" readonly required>
			<input type="submit" value="회원탈퇴" class="btn btn-outline-dark">
		</form:form>
	</div>
</div>
<script>
	
</script>
</body>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>