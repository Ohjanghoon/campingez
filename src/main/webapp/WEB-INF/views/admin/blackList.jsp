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
				<div class="user-list-wrap">
					<h2 class="text-center fw-bold pt-5 pb-5">회원경고</h2>
					<div class="select-wrap d-flex">
						<select id="selectType" class="form-select">
							<option value="" selected>전체</option>
							<option value="user_id">회원아이디</option>
							<option value="user_name">회원이름</option>
						</select>
						<div class="input-group" id="selectKeywordGroup">
							<input type="text" id="selectKeyword" class="form-control"/>
							<button type="button" id="searchBtn" class="btn searchBtn"><i class="fa-solid fa-magnifying-glass"></i></button>
						</div>
					</div>
					
					<table id="tbl-user-list" class="table text-center">
						<thead>
							<tr>
								<th scope="col">No</th>
								<th scope="col">회원아이디</th>
								<th scope="col">회원명</th>
								<th scope="col">전화번호</th>
								<th scope="col">경고횟수</th>
								<th scope="col">사유</th>
								<th scope="col">경고처리</th>
							</tr>
						</thead>
						<tbody>
						<c:if test="${not empty userList}">
							<c:forEach items="${userList}" var="user" varStatus="userVs">
								<tr>
									<td scope="row">${userVs.count}</td>
									<td scope="row">${user.userId}</td>
									<td scope="row">${user.userName}</td>
									<td scope="row">${user.phone}</td>
									<td scope="row">${user.yellowCard}</td>
									<td scope="row">
										<select id="yellowCardType" class="form-select">
											<option value="" selected disabled>사유를 선택하세요.</option>
											<option value="violation">이용수칙위반</option>
											<option value="noshow">노쇼</option>
											<option value="report">커뮤니티이용수칙위반</option>
										</select>
									</td>
									<td scope="row">
										<button type="button" name="yellowCardBtn" id="${user.userId}" onclick="warningToUser(event)">경고</button>
										<button type="button" name="cancelBtn" id="${user.userId}" onclick="cancelWarningToUser(event)">취소</button>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty userList}">
							<tr>
								<td colspan="7">조회된 회원 목록이 없습니다.</td>
							</tr>
						</c:if>
						</tbody>
					</table>
					<nav id="notBlackPagebar">
						${notBlackPagebar}
					</nav>
				</div>
				<div class="black-list-wrap">
					<h2 class="text-center fw-bold pt-5 pb-5">블랙리스트</h2>
					<table id="tbl-black-list" class="table text-center">
						<thead>
							<tr>
								<th scope="col">No</th>
								<th scope="col">회원아이디</th>
								<th scope="col">회원명</th>
								<th scope="col">전화번호</th>
								<th scope="col">포인트</th>
								<th scope="col">관리</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty blackList}">
								<c:forEach items="${blackList}" var="black" varStatus="blackVs">
									<tr>
										<td scope="row">${blackVs.count}</td>
										<td scope="row">${black.userId}</td>
										<td scope="row">${black.userName}</td>
										<td scope="row">${black.phone}</td>
										<td scope="row">${black.point}</td>
										<td scope="row">
											<button type="button" name="updateBtn" id="${black.userId}" onclick="updateUser(this)">해제</button>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty blackList}">
								<tr>
									<td colspan="5">블랙리스트 명단이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<nav id="blackPagebar">
						${blackPagebar}
					</nav>
				</div>
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
	blackListAjax(page);
	console.log(page);
}

const pagings = document.querySelectorAll(".paging");

pagings.forEach(paging => {
	paging.addEventListener("click", clickPaging);
});

function blackListAjax(cPage) {
	const selectType = document.querySelector("#selectType").value;
	const selectKeyword = document.querySelector("#selectKeyword").value;
	
	if(!selectKeyword) {
		alert("검색어를 입력해주세요.");
		return;
	}
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/selectUserNotBlackList.do?selectType=\${selectType}&selectKeyword=\${selectKeyword}&cPage=`+cPage,
		method : "GET",
		success(response) {
			console.log(response);
			const {userList, pagebar} = response;
			
			const tbody = document.querySelector("#tbl-user-list tbody");
			tbody.innerHTML = '';
			const nav = document.querySelector("#notBlackPagebar");
			nav.innerHTML = pagebar;
			
			if(userList.length == 0) {
				tbody.innerHTML = `
				<tr>
					<td colspan="7" scope="row">조회된 회원 목록이 없습니다.</td>
				</tr>
				`;
				return;
			}
			
			for(let i = 0; i < userList.length; i++) {
				const {userId, userName, phone, yellowCard} = userList[i];

				tbody.innerHTML += `
				<tr>
					<td scope="row">\${i+1}</td>
					<td scope="row">\${userId}</td>
					<td scope="row">\${userName}</td>
					<td scope="row">\${phone}</td>
					<td scope="row">\${yellowCard}</td>
					<td scope="row">
						<select id="yellowCardType">
							<option value="" selected disabled>사유를 선택하세요.</option>
							<option value="violation">이용수칙위반</option>
							<option value="noshow">노쇼</option>
						</select>
					</td>
					<td scope="row">
						<button type="button" name="yellowCardBtn" id="\${userId}" onclick="warningToUser(event)">경고</button>
					</td>
				</tr>
				`;
			};
			const pagings = document.querySelectorAll(".paging");

			pagings.forEach(paging => {
				paging.addEventListener("click", clickPaging);
			});
		},
		error : console.log
	});

}

const updateUser = (button) => {
	const userId = button.id;
	
	if(confirm(`[\${userId}]에 대한 '블랙리스트 해지'를 정말 하시겠습니까?`)) {
		cancelYellowCard(userId, true);
	}
}

const warningToUser = (e) => {
	const userId = e.target.id;
	let reason = e.target.parentElement.previousElementSibling.children[0].selectedOptions[0];
	
	if(!userId) return;
	if(!reason.value) {
		alert('경고 사유를 선택해주세요.');
		return;
	} else {
		if(!confirm(`[\${userId}]님에게 정말 경고를 부여하실건가요?`)) return;
	} 
	reason = reason.innerHTML;

	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/warning.do`,
		headers,
		data : {userId, reason},
		method : "POST",
		success(response) {
			location.reload();
		},
		error : console.log
	});
};

const cancelWarningToUser = (e) => {
	const userId = e.target.id;
	const yellowcard = e.target.parentElement.previousElementSibling.previousElementSibling.innerHTML;
	
	if(yellowcard < 1) {
		alert("경고 횟수가 없는 회원입니다.");
		return;
	} else if(confirm(`[\${userId}]님의 경고를 정말 취소하시겠습니까?`)) {
		cancelYellowCard(userId, false);
	}
}

const cancelYellowCard = (userId, isBlack) => {
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/cancelWarning.do`,
		headers,
		data : {userId, isBlack},
		method : "POST",
		success(response) {
			location.reload();
		},
		error : console.log
	});
};

document.querySelector("#selectType").addEventListener('change', (e) => {
	if(!e.target.value) {
		location.reload();
	}
});

document.querySelector("#searchBtn").addEventListener('click', (e) => {
	blackListAjax(1);
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>