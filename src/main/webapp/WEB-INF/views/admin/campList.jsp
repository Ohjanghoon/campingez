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
.ok, .error {
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
							<img src="${pageContext.request.contextPath}/resources/images/reservation/campMap2.png" alt="" width="900px"/>
						</div>
						<c:if test="${not empty campList}">
							<c:forEach items="${campList}" var="list" varStatus="tbVs">
								<table>
									<thead>
										<tr>
											<th>No</th>
											<th>구역명[구역코드]</th>
											<th>자리코드</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${not empty list.campList}">
											<c:forEach items="${list.campList}" var="camp" varStatus="vs">
											${vs.last}
												<tr>
													<c:if test="${vs.first}">
														<td rowspan="3">${tbVs.count}</td>
														<td rowspan="3">${list.zoneName}[${list.zoneCode}]</td>
														<td>${camp.campId}</td>
													</c:if>
													<c:if test="${not vs.first }">
														<td>${camp.campId}</td>
													</c:if>								
												</tr>
											</c:forEach>
										</c:if>
										<c:if test="${empty list.campList}">
											<tr>
												<td>${tbVs.count}</td>
												<td>${list.zoneName}[${list.zoneCode}]</td>
												<td colspan="3">등록된 자리가 없습니다.</td>
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
								<span class="infomsg ok">해당 자리코드는 사용 가능 합니다.</span>
								<input type="hidden" id="isPossable" value="0"/>
							</div>
						</form:form>
					</div>
				</div>
			</div>
	</section>
</main>
<script>
const isPossable = document.querySelector("#isPossable");
const error = document.querySelector(".error");
const ok = document.querySelector(".ok");

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
	isPossable.value = 0;
});

// 중복검사
document.querySelector("#insertCamp").addEventListener('keyup', (e) => {
	const value = e.target.value;
	
	// 모든 문자를 대문자로 변환
	if(/[^a-zA-Z0-9+]/g.test(value)) {
		e.target.value = value.replace(/[^a-zA-Z0-9+]/g, ''); 
	} else {		
		e.target.value = value.toUpperCase();
	}
	
	if(value.length < 3) return;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/duplicateCampId.do",
		data : {campId:value},
		content : "application/json",
		success(response) {
			const {available, camp} = response;
			
			if(available) {
				isPossable.value = 1;
				ok.style.display = 'inline';
				error.style.display = 'none';
			} else {
				isPossable.value = 0;
				ok.style.display = 'none';
				error.style.display = 'inline';
			}
		},
		error : console.log
	});
});

document.querySelector("#insertCamp").addEventListener('focus', (e) => {
	if(!e.target.value) {
		const selectType = document.querySelector("#selectType").value;
		e.target.value = selectType;		
	}
});

// 자리 추가
document.querySelector("#insertBtn").addEventListener('click', (e) => {
	const input = document.querySelector("#insertCamp");
	const selectType = document.querySelector("#selectType").value;
	const regex = new RegExp(`^\${selectType}[0-9]`, "g");
	
	if(!input.value) {
		alert("자리코드를 입력해주세요.");
		return;
	}
	
	// 정규식 검사
	if(regex.test(input.value) && isPossable.value == 1) {
		document.insertCampFrm.submit();
	} else {
		alert("구역코드가 틀리거나 형식이 올바르지 않습니다.");
		input.value = '';
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>