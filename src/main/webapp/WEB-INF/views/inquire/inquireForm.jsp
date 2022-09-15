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

	<form:form
		name="inquireFrm"
		action="${pageContext.request.contextPath}/inquire/inquireEnroll.do"
		method="post"
		>
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="inqTitle"/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="inqWriter" value="<sec:authentication property="principal.username"/>" />
				</td>
			</tr>
			<tr>
				<th>문의유형</th>
				<td>
					<select name="categoryId" id="inqType">
						<option value="inq1">환불문의</option>
						<option value="inq2">예약문의</option>
						<option value="inq3">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td>
					<textarea name="inqContent" id="inqContent" cols="30" rows="10"></textarea>
				</td>
			</tr>
		</table>
		<div>
			<button type="submit" id="btn-submit">작성</button>
		</div>
	</form:form>
	
	<script>
	document.querySelector("#btn-submit").addEventListener('click', (e) => {
		const frm = document.inquireFrm;
		
		
	});
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>