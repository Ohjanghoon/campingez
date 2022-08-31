<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<body>
	<h2>회원관리</h2>
	<select id="selectType">
		<option value="" selected disabled>검색어</option>
		<option value="user_id">회원아이디</option>
		<option value="user_name">회원이름</option>
	</select>
	<input type="text" id="selectKeyword" />
	<button type="button" id="searchBtn">검색</button>
	<table>
		<thead>
			<tr>
				<th>No.</th>
				<th>회원아이디</th>
				<th>회원이름</th>
				<th>이메일</th>
				<th>핸드폰번호</th>
				<th>성별</th>
				<th>경고횟수</th>
				<th>보유포인트</th>
				<th>권한</th>
				<th>회원가입타입</th>
				<th>가입일</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty userList}">
				<c:forEach items="${userList}" var="user" varStatus="vs">
					<tr>
						<td>${vs.count}</td>
						<td>${user.userId}</td>
						<td>${user.userName}</td>
						<td>${user.email}</td>
						<td>${user.phone}</td>
						<td>${user.gender}</td>
						<td>${user.yellowCard}</td>
						<td>${user.point}</td>
						<td>권한</td>
						<td>${user.enrollType}</td>
						<td>
							<fmt:parseDate value="${user.enrollDate}" var="enrollDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
							<fmt:formatDate value="${enrollDate}" pattern="yy/MM/dd"/>
						</td>
						<td>
							<button type="button" name="updateBtn" id="${user.userId}">수정</button>
							<button type="button" name="yellowCardBtn" id="${user.userId}">경고</button>
						</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty userList}">
				<tr>
					<td colspan="11">조회된 회원이 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>
	${pagebar}
<script>
document.querySelectorAll("[name=updateBtn]").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		
	});
});

document.querySelectorAll("[name=yellowCardBtn]").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		const userId = e.target.id;
		
		if(!userId) return;
		if(!confirm(`[\${userId}]님에게 정말 경고를 부여하실건가요?`)) return;

		$.ajax({
			url : `${pageContext.request.contextPath}/admin/warning`,
			data : {userId},
			method : "POST",
			success(response) {
				location.reload();
			},
			error : console.log
		});
	});
});

document.querySelector("#searchBtn").addEventListener('click', (e) => {
	const selectType = document.querySelector("#selectType").value;
	const selectKeyword = document.querySelector("#selectKeyword").value;
	
	if(!selectType) {
		alert("검색어를 선택해주세요.");
		return;
	}
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/selectUser.do?selectType=\${selectType}&selectKeyword=\${selectKeyword}`,
		method : "GET",
		success(response) {
			console.log(response);
		},
		error : console.log
	});
});
</script>
</body>
</html>