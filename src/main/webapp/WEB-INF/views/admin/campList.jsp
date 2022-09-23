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
<style>
.error, .noKr {
	display: none;
}
#insertCamp {
	display:none;
}
</style>
				<div class="content-wrap">
					<div class="camp-list-wrap">
						<h2>캠핑 자리 리스트</h2>
						<div class="map-wrap">
							<img src="${pageContext.request.contextPath}/resources/images/reservation/campMap2.png" alt="캠핑구역" width="100%" height="650px"/>
						</div>
						<c:if test="${not empty campList}">
							<c:forEach items="${campList}" var="list" varStatus="tbVs">
								<table class="table text-center" id="camp-list-tbl">
									  <thead>
									    <tr>
									    </tr>
									  </thead>
									<tbody>
										<c:if test="${not empty list.campList}">
											<tr>
												<th scope="col">No</th>
												<td scope="row" colspan="${fn:length(list.campList)}">${tbVs.count}</td>
											</tr>
											<tr>
												<th scope="col">구역</th>
												<td scope="row" colspan="${fn:length(list.campList)}">${list.zoneName}[${list.zoneCode}]</td>
											</tr>
											<tr>
												<th scope="col">자리정보</th>
												<c:forEach items="${list.campList}" var="camp" varStatus="vs">
													<td scope="row">${camp.campId}</td>
												</c:forEach>
											</tr>
											<tr>
												<th scope="col">관리</th> 
												<c:forEach items="${list.campList}" var="camp" varStatus="vs">
												<td scope="row"> 
													<button type="button" id="deleteBtn" data-camp-id="${camp.campId}">삭제</button>
												</td>
												</c:forEach>
											</tr>
										</c:if>
										<c:if test="${empty list.campList}">
											<tr>
												<th scope="col">No</th>
												<td scope="row">${tbVs.count}</td>
											</tr>
											<tr>
												<th scope="col">구역</th>
												<td scope="row">${list.zoneName}[${list.zoneCode}]</td>
											</tr>
											<tr>
												<th scope="col">자리정보</th>
												<td scope="row" colspan="3">등록된 자리가 없습니다.</td>
											</tr>
										</c:if>
									</tbody>
								</table>
							</c:forEach>
						</c:if>
					</div>
					<div class="camp-insert-wrap">
						<h2>캠핑 자리 추가</h2>
						<form:form name="insertCampFrm" action="${pageContext.request.contextPath}/admin/insertCamp.do" method="POST">
							<div class="select-wrap d-flex">
								<select id="selectType" name="selectType" class="form-select">
									<option value="" selected disabled>구역코드</option>
									<c:forEach items="${campZoneList}" var="zone">
										<option value="${zone.zoneCode}">${zone.zoneName}[${zone.zoneCode}]</option>
									</c:forEach>
								</select>
								<div class="input-group" id="insertInputGroup">
									<input type="text" id="insertCamp" name="campId" class="form-control"/>
									<button type="button" id="insertBtn" class="btn searchBtn"><i class="fa-solid fa-plus"></i></button>
								</div>
								<span class="infomsg error">해당 자리코드는 사용할 수 없습니다.</span>
								<span class="infomsg noKr">영문 혹은 숫자만 입력 가능합니다.</span>
							</div>
						</form:form>
					</div>
					<div class="select-camp-wrap">
						
					</div>
					<form:form name="deleteCampFrm" method="POST" action="${pageContext.request.contextPath}/admin/deleteCamp.do">					
						<input type="hidden" name="campId"/>
					</form:form>
				</div>
				
			</div>
	</section>
</main>
<script>
const error = document.querySelector(".error");
const noKr = document.querySelector(".noKr");

// select 변경 시
document.querySelector("#selectType").addEventListener('change', (e) => {
	const zoneCode = e.target.value;
	const input = document.querySelector("#insertCamp");
	
	if(zoneCode) {
		input.style.display = 'inline';
	} else {
		input.style.display = 'none';
	}
	
	// 값 초기화 및 placeholder 설정
	input.value = '';
	input.placeholder = 'ex) ' + zoneCode + '1';
	
	// 해당 selectType만 보여주기
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/findCampByZoneCode.do",
		data : {zoneCode},
		content : "application/json",
		success(response) {
			const {campList, zoneCode, zoneName} = response[0];
			console.log(campList, zoneCode, zoneName);
			const wrap = document.querySelector(".select-camp-wrap");
			wrap.innerHTML = '';
			
			let html = `
			<h5>[\${zoneName} \${zoneCode}] - 자리 리스트</h5>
			<table class="table text-center">
				<tbody>
			`;
			if(campList.length > 0) {
				html += `
					<tr>
						<th scope="col">구역</th>
						<td scope="row" colspan="\${campList.length}">\${zoneName}[\${zoneCode}]</td>
					</tr>
					<tr>
						<th scope="col">자리정보</th>
					`;
					
				campList.forEach((camp) => {
					html += `
					<td scope="row">\${camp.campId}</td>
					`;
				});		
				
				html += `
				</tr>
				`;
			} else {
				html += `
				<tr>
					<th scope="col">구역</th>
					<td scope="row">\${zoneName}[\${zoneCode}]</td>
				</tr>
				<tr>
					<th scope="col">자리정보</th>
					<td scope="row" colspan="3">등록된 자리가 없습니다.</td>
				</tr>
				`;
			}
			
			html += `
				</tbody>
			</table>
			`;
			
			wrap.insertAdjacentHTML('beforeend', html);
		},
		error : console.log
	});
});

// 필수 기본값 제공
document.querySelector("#insertCamp").addEventListener('input', (e) => {
	const selectType = document.querySelector("#selectType").value;
	const regex = new RegExp(`^\${selectType}`, "g");
	const value = e.target.value;
	
	if(!regex.test(value)) {
		e.target.value = selectType;
	} else {
		if(/[^a-zA-Z0-9+]/g.test(value)) {
			e.target.value = value.replace(/[^a-zA-Z0-9+]/g, '');
			noKr.style.display = 'inline';
			error.style.display = 'none';
		} else {		
			noKr.style.display = 'none';
			error.style.display = 'none';
			e.target.value = value.toUpperCase();
		}
	}
});

// 기본 값 제공
document.querySelector("#insertCamp").addEventListener('focus', (e) => {
	if(!e.target.value) {
		const selectType = document.querySelector("#selectType").value;
		e.target.value = selectType;		
	}
});

// 자리 추가
document.querySelector("#insertBtn").addEventListener('click', (e) => {
	e.preventDefault();
	
	const input = document.querySelector("#insertCamp").value;
	const selectType = document.querySelector("#selectType").value;
	const regex = new RegExp(`^\${selectType}[0-9]`, "g");
	
	if(!input) {
		alert("자리코드를 입력해주세요.");
		return;
	}
	
	// 정규식 검사
	if(regex.test(input)) {
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/duplicateCampId.do",
			data : {campId:input},
			content : "application/json",
			success(response) {
				const {available, camp} = response;
				
				if(available) {
					error.style.display = 'none';
					noKr.style.display = 'none';
					document.insertCampFrm.submit();
					return;
				} else {
					noKr.style.display = 'none';
					error.style.display = 'inline';
				}
			},
			error : console.log
		});
	} else {
		alert("구역코드가 틀리거나 형식이 올바르지 않습니다.");
		input.value = '';
	}
});

// 삭제
document.querySelectorAll("#deleteBtn").forEach((btn) => {
	btn.addEventListener('click', (e) => {
		const campId = e.target.dataset.campId;
		if(confirm(`[\${campId}]자리를 정말로 삭제하시겠습니까?`)) {
			const frm = document.deleteCampFrm;
			frm.campId.value = campId;
			frm.submit();
		}
	});
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>