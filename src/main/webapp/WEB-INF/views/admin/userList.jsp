<%@page import="java.util.ArrayList"%>
<%@page import="com.kh.campingez.user.model.dto.User"%>
<%@page import="com.kh.campingez.user.model.dto.Authority"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/admin/admin.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
			<div class="content-wrap">
				<h2 class="text-center fw-bold pt-5 pb-5">회원관리</h2>
				<div class="select-wrap d-flex">
					<select id="selectType" class="form-select">
						<option value="" selected>전체</option>
						<option value="user_id">회원아이디</option>
						<option value="user_name">회원이름</option>
					</select>
					<div class="input-group user-select-bar" id="selectKeywordGroup">
						<input type="text" id="selectKeyword" class="form-control" />
					    <button class="btn searchBtn" type="button" id="searchBtn"><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>
				</div>
				<table id="user-list-tbl" class="table text-center">
					<thead>
						<tr>
							<th scope="col">No.</th>
							<th scope="col">회원아이디</th>
							<th scope="col">회원이름</th>
							<th scope="col">이메일</th>
							<th scope="col">핸드폰번호</th>
							<th scope="col">성별</th>
							<th scope="col">경고</th>
							<th scope="col">포인트</th>
							<th scope="col">권한</th>
							<th scope="col">가입일</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
						<c:if test="${not empty userList}">
							<c:forEach items="${userList}" var="user" varStatus="vs">
								<tr>
									<td scope="row">${vs.count}</td>
									<td scope="row" id="userId">${user.userId}</td>
									<td scope="row">${user.userName}</td>
									<td scope="row">${user.email}</td>
									<td scope="row">${user.phone}</td>
									<td scope="row">${user.gender}</td>
									<td scope="row" id="yellowCardCount">${user.yellowCard}</td>
									<td scope="row">${user.point}</td>
									<td scope="row">
										<select name="auth" id="auth" data-user-id="${user.userId}" onchange="changeAuth(this);">
										<c:forEach items="${user.authorityList}" var="auth" varStatus="vs">
											<c:if test="${auth.auth == 'ROLE_ADMIN'}">
												<option value="ROLE_ADMIN" selected>관리자</option>
												<option value="ROLE_USER">일반</option>
											</c:if>
											<c:if test="${auth.auth == 'ROLE_USER' && vs.count < 2}">
												<option value="ROLE_ADMIN">관리자</option>
												<option value="ROLE_USER" selected>일반</option>
											</c:if>
										</c:forEach>
										</select>
									</td>
									<td scope="row">
										<fmt:parseDate value="${user.enrollDate}" var="enrollDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
										<fmt:formatDate value="${enrollDate}" pattern="yyyy/MM/dd"/>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty userList}">
							<tr>
								<td colspan="11" scope="row">조회된 회원이 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<nav id="userPagebar">
					${pagebar}
				</nav>
			</div>
		</div>
	</section>
</main>
<script>
function clickPaging() {
	var id = this.id;
	var page = id.substring(4);
	if(page == 0){
		page = -1;
	}
	userListAjax(page);
	console.log(page);
}

const pagings = document.querySelectorAll(".paging");

pagings.forEach(paging => {
	paging.addEventListener("click", clickPaging);
});

function userListAjax(cPage) {
	const selectType = document.querySelector("#selectType").value;
	const selectKeyword = document.querySelector("#selectKeyword").value;
	
 	if(!selectKeyword) {
		alert("검색어를 선택해주세요.");
		return;
	} 
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/selectUser.do?selectType=\${selectType}&selectKeyword=\${selectKeyword}&cPage=`+cPage,
		method : "GET",
		success(response) {
			console.log(response);
			const {userList, pagebar} = response;
			
			const tbody = document.querySelector("#user-list-tbl tbody");
			tbody.innerHTML = '';
			const nav = document.querySelector("#userPagebar");
			nav.innerHTML = pagebar;
			
			let html = '';
			if(userList.length == 0) {
				html += `
				<tr>
					<td colspan="11">조회된 회원 목록이 없습니다.</td>
				</tr>
				`;
				tbody.insertAdjacentHTML('beforeend', html);
				return;
			}
			
			for(let i = 0; i < userList.length; i++) {
				html = '';
				const {userId, userName, email, phone, gender, yellowCard, point, enrollType, enrollDate, authorityList} = userList[i];
				const [yy, _mm, dd] = enrollDate;
				const mm = _mm < 10 ? '0' + _mm : _mm;
				
				html += `
				<tr>
					<td scope="row">\${i+1}</td>
					<td scope="row" id="userId">\${userId}</td>
					<td scope="row">\${userName}</td>
					<td scope="row">\${email}</td>
					<td scope="row">\${phone}</td>
					<td scope="row">\${gender}</td>
					<td scope="row" id="yellowCardCount">\${yellowCard}</td>
					<td scope="row">\${point}</td>
					<td scope="row">
						<select name="auth" id="auth" data-user-id="\${userId}" onchange="changeAuth(this);">
				`;
				
				for(let i = 0; i < authorityList.length; i++) {
					if(authorityList[i].auth == 'ROLE_ADMIN') {
						console.log(123);
						html += `
							<option value="ROLE_ADMIN" selected>관리자</option>
							<option value="ROLE_USER">일반</option>
						`;
					} else if(authorityList[i].auth == 'ROLE_USER' && i < 1) {
						console.log(234);
						html += `
							<option value="ROLE_ADMIN">관리자</option>
							<option value="ROLE_USER" selected>일반</option>
						`;
						
					}
				};
				
				html += `
						</select>
					</td>
					<td scope="row">\${yy}/\${mm}/\${dd}</td>
				</tr>
				`;
				tbody.insertAdjacentHTML('beforeend', html);
			};
			
			// 
			
			// 비동기 페이징 처리
			const pagings = document.querySelectorAll(".paging");

			pagings.forEach(paging => {
				paging.addEventListener("click", clickPaging);
			});
		},
		error : console.log
	});
	
}

const changeAuth = (e) => {
	if(e.dataset == undefined) return;
	
	const userId = e.dataset.userId;
	const changeAuth = e.selectedOptions[0].innerHTML; 
	const changeAuthVal = e.value;

	if(confirm(`[\${userId}]님의 권한을 '\${changeAuth}회원'으로 변경하시겠습니까?`)) {
		const headers = {};
		headers['${_csrf.headerName}'] = '${_csrf.token}';
		
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/updateUserRole.do",
			data : {userId, changeAuth:changeAuthVal},
			headers,
			method : "POST",
			success(response) {
				e.selected = true;
			},
			error : console.log
		});
	} else {
		console.log(e.querySelector("[selected]").selected);
		e.querySelector("[selected]").selected = true;
	}
}

document.querySelectorAll("#auth").forEach((select) => {
	select.addEventListener('change', (e) => {
		changeAuth(e);
	});
});

document.querySelector("#selectType").addEventListener('change', (e) => {
	if(!e.target.value) {
		document.querySelector(".user-select-bar").style.display = 'none';
		document.querySelector("#selectKeyword").value = '';
		location.reload();
	} else {
		document.querySelector(".user-select-bar").style.display = 'inherit';
		document.querySelector("#selectKeyword").value = '';
	}
});

document.querySelector("#searchBtn").addEventListener('click', (e) => {
	userListAjax(1);
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>