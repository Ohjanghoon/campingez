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

<div class="container">
	<form:form
		name="inquireUpdateForm"
		method="post"
		action="${pageContext.request.contextPath}/inquire/inquireUpdate.do"
		>
	<input type="hidden" name="inqNo" value="${inquire.inqNo}" />
	<table class="table w-75 mx-auto">
		<tr>
			<th>제목</th>
			<td>
				<input class="w-75" type="text" name="inqTitle" value="${inquire.inqTitle}" required/>
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${inquire.inqWriter}</td>
		</tr>
		<tr>
			<th>문의유형</th>
			<td>
				<select name="categoryId">
					<option value="inq1" ${inquire.categoryId eq 'inq1' ? 'selected' : ''}>환불문의</option>
					<option value="inq2" ${inquire.categoryId eq 'inq2' ? 'selected' : ''}>예약문의</option>
					<option value="inq3" ${inquire.categoryId eq 'inq3' ? 'selected' : ''}>기타</option>
				</select>
			</td>
		</tr>
		<tr>
			<th class="align-middle">내용</th>
			<td>
				<textarea class="w-100" name="inqContent" rows="10" cols="" required>${inquire.inqContent}</textarea>
			</td>
		</tr>
	</table>
	<div class="text-center">
		<button type="submit" class="btn btn-primary"id="btn-inquire-update">수정</button>
	</div>
	</form:form>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>