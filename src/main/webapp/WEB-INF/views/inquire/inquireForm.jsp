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

<style>
#tbl-inquire-enroll th {
	text-indent : 1.1rem;
	vertical-align : middle;
	text-align : center;
}
::placeholder {
  color: black;
  font-size: 0.8rem;
}
textarea {
	resize : none;
}
</style>
<div class="w-75 container">
	<sec:authentication property="principal.username" var="loginUser"/>
	<div class="text-center my-5">
		<strong class="fs-3"><i class="fa-regular fa-circle-question"></i> 1:1 문의</strong>
	</div>
	<form:form
		name="inquireFrm"
		action="${pageContext.request.contextPath}/inquire/inquireEnroll.do"
		method="post"
		>
		<table class="table" id="tbl-inquire-enroll">
			<tr>
				<th>제목</th>
				<td><input class="w-75 form-control" type="text" name="inqTitle" required/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td> ${loginUser}
					<input type="hidden" name="inqWriter" value="${loginUser}" />
				</td>
			</tr>
			
			<tr>
				<th>문의유형</th>
				<td>
					<select class="w-50 form-select" name="categoryId" required>
						<option value="">문의유형 선택</option>
						<option value="inq1">시설 문의</option>
						<option value="inq2">이용 문의</option>
						<option value="inq3">예약 문의</option>
						<option value="inq4">양도 문의</option>
						<option value="inq5">커뮤니티 문의</option>
						<option value="inq6">중고거래 문의</option>
						<option value="inq7">회원관련 문의</option>
						<option value="inq8">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td>
					<textarea class="form-control w-100 p-2" name="inqContent" id="inqContent" cols="30" rows="10"
					placeholder="자유롭게 글을 작성할 수 있습니다. 명예훼손이나 상대방을 비방, 불쾌감을 주는 글, 욕설, 남을 모욕하는 글은 임의로 제제가 있을 수 있습니다." required></textarea>
				</td>
			</tr>
		</table>
		<div class="text-center">
			<button type="submit" class="w-50 py-2 btn btn-primary" id="btn-submit"><strong>작성</strong></button>
		</div>
	</form:form>
</div>
	
<script>

document.querySelector("#btn-submit").addEventListener('click', (e) => {
	const frm = document.inquireFrm;
});

//화면 로드시 스크롤 이동
$(document).ready(function () {
	$('html, body, .container').animate({scrollTop: $('#myCarousel').outerHeight(true) - $('.blog-header').outerHeight(true) }, 'fast');
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>