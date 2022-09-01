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

	<h2>회원관리</h2>
	<select id="selectType">
		<option value="" selected disabled>검색어</option>
		<option value="user_id">회원아이디</option>
		<option value="user_name">회원이름</option>
	</select>
	<input type="text" id="selectKeyword" />
	<button type="button" id="searchBtn">검색</button>
	<table id="user-list-tbl">
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
						<td id="yellowCardCount">${user.yellowCard}</td>
						<td>${user.point}</td>
						<td>
							권한					
						</td>
						<td>${user.enrollType}</td>
						<td>
							<fmt:parseDate value="${user.enrollDate}" var="enrollDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
							<fmt:formatDate value="${enrollDate}" pattern="yyyy/MM/dd"/>
						</td>
						<td>
							<button type="button" name="updateBtn" id="${user.userId}">수정</button>
							<button type="button" name="yellowCardBtn" id="${user.userId}" onclick="warningToUser(event)">경고</button>
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
	<nav>
		${pagebar}
	</nav>
<script>
console.log(123);
console.log("${userList}");

const warningToUser = (e) => {
	const userId = e.target.id;
	
	if(!userId) return;
	if(!confirm(`[\${userId}]님에게 정말 경고를 부여하실건가요?`)) return;

	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/warning`,
		headers,
		data : {userId},
		method : "POST",
		success(response) {
			updateUser(e.target);
		},
		error : console.log
	});
};

const updateUser = (button) => {
	const userId = button.id;
	const tr = button.parentElement.parentElement;
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/updateUserList`,
		data : {userId},
		method : "GET",
		success(response) {
			console.log(response);
			const {yellowCard} = response;
			tr.querySelector("#yellowCardCount").innerHTML = yellowCard; 
		},
		error : console.log
	});
}

document.querySelectorAll("[name=updateBtn]").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		
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
			const {userList, pagebar} = response;
			
			const tbody = document.querySelector("#user-list-tbl tbody");
			tbody.innerHTML = '';
			const nav = document.querySelector("nav");
			nav.innerHTML = pagebar;
			
			if(userList.length == 0) {
				tbody.innerHTML = `
				<tr>
					<td colspan="11">조회된 회원 정보가 없습니다.</td>
				</tr>
				`;
				return;
			}
			
			for(let i = 0; i < userList.length; i++) {
				const {userId, userName, email, phone, gender, yellowCard, point, enrollType, enrollDate} = userList[i];
				const [yy, mm, dd] = enrollDate;

				tbody.innerHTML += `
				<tr>
					<td>\${i+1}</td>
					<td>\${userId}</td>
					<td>\${userName}</td>
					<td>\${email}</td>
					<td>\${phone}</td>
					<td>\${gender}</td>
					<td id="yellowCardCount">\${yellowCard}</td>
					<td>\${point}</td>
					<td>권한</td>
					<td>\${enrollType}</td>
					<td>
						\${yy}/\${mm}/\${dd}
					</td>
					<td>
						<button type="button" name="updateBtn" id="\${userId}">수정</button>
						<button type="button" name="yellowCardBtn" id="\${userId}" onclick="warningToUser(event)">경고</button>
					</td>
				</tr>
				`;
			};
		},
		error : console.log
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>