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
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="/css/summernote/summernote-lite.css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<style>
#tbl-inquire-enroll th {
	vertical-align : middle;
	text-align : center;
}
</style>
<div class="w-75 container">
	<sec:authentication property="principal.username" var="userId"/>
	<form:form
		name="inquireFrm"
		action="${pageContext.request.contextPath}/inquire/inquireEnroll.do"
		method="post"
		>
		<table class="table" id="tbl-inquire-enroll">
			<tr>
				<th>제목</th>
				<td><input class="form-control" type="text" name="inqTitle"/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td> ${userId}
					<input type="hidden" name="inqWriter" value="${userId}" />
				</td>
			</tr>
			<tr>
				<th>문의유형</th>
				<td>
					<div class="dropdown">
						<div class="dropend">
							<button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
							  Dropright
							</button>
						<div class="dropend">캠핑장관련</div>
						<div class="dropend">예약관련</div>
					</div>
					<select class="form-control" name="categoryId" id="inqType">
						<option value="inq1">환불문의</option>
						<option value="inq2">예약문의</option>
						<option value="inq3">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td>
					<textarea id="summernote" name="inqContent" id="inqContent" cols="30" rows="10"></textarea>
				</td>
			</tr>
		</table>
		<div>
			<button type="submit" id="btn-submit">작성</button>
		</div>
	</form:form>
</div>
	
<script>
$(document).ready(function() {
    $('#summernote').summernote({
    	placeholder: '자유롭게 글을 작성할 수 있습니다.\n 명예훼손이나 상대방을 비방, 불쾌감을 주는 글, 욕설, 남을 모욕하는 글은 임의로 제제가 있을 수 있습니다.',
        height: 300,

    });
});
document.querySelector("#btn-submit").addEventListener('click', (e) => {
	const frm = document.inquireFrm;
	
	
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>