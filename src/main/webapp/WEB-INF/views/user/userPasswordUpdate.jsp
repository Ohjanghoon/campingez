<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title" />
</jsp:include>
<div id="enroll-container">
	<form:form name="userEnrollFrm" action="" method="POST">
		<table class="mx-auto">
			<tr>
				<th>새비밀번호</th>
				<td>
					<div>
						<input type="text" name="newPassword" id="newPassword" placeholder="비밀번호">
					</div>
				</td>
			</tr>
			<tr>
				<th>새비밀번호 확인</th>
				<td>
					<div>
						<input type="text" name="newPasswordCheck" id="newPasswordCheck" >
					</div>
				</td>
			</tr>
		</table>
		<input type="hidden" name="_userId" id="_userId" value="${userId}" />
		<input type="submit" value="변경">
	</form:form>
</div>
</body>
</html>