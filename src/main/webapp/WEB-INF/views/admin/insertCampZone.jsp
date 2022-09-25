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
				<h2>기존 구역 리스트</h2>
				<table class="table text-center">
					<thead>
						<tr>
							<th scope="col">No</th>
							<th scope="col">구역번호</th>
							<th scope="col">구역이름</th>
						</tr>
					</thead>
					<tbody>
				<c:if test="${not empty campZoneList}">
					<c:forEach items="${campZoneList}" var="zone" varStatus="vs">
						<tr>
							<td scope="row">${vs.count}</td>
							<td id="zoneCode" scope="row">${zone.zoneCode}</td>
							<td scope="row">${zone.zoneName}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty campZoneList}">
					<tr>
						<td colspan="3" scope="row">등록된 구역 정보가 없습니다.</td>
					</tr>
				</c:if>
					</tbody>
				</table>
				
				<h2>캠프 구역 추가</h2>
				<form:form action="${pageContext.request.contextPath}/admin/insertCampZone.do" method="POST" name="insertCampZoneFrm" enctype="multipart/form-data">
					<div class="camp-name-wrap">
						<div class="form-floating zone-wrap">
							<input type="text" name="zoneCode" id="zoneCode" placeholder="구역코드 ex)ZA" pattern="[A-Za-z]+" class="form-control" value="Z" required/>
							<label for="zoneCode">구역코드 ex)ZA</label>
						</div>
						<div class="form-floating zone-wrap">					
							<input type="text" name="zoneName" id="zoneName" class="form-control" placeholder="구역이름" required />
							<label for="zoneName">구역이름</label>
						</div>
					</div>
					<div class="option-wrap">
						<div class="option-header">
							<div class="strong">* 옵션선택</div>
						</div>
						<div class="option-check-wrap">
							<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo1" value="매점" autocomplete="off"/>
								<label class="check-btn" for="zoneInfo1">매점</label>
							
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo2" value="장작판매" autocomplete="off"/>
								<label class="check-btn" for="zoneInfo2">장작판매</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo3" value="샤워시설" autocomplete="off"/>
								<label class="check-btn" for="zoneInfo3">샤워시설</label>
							
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo4" value="전기" autocomplete="off"/>
								<label class="check-btn" for="zoneInfo3">전기</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo5" value="와이파이"/>
								<label class="check-btn" for="zoneInfo5">와이파이</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo6" value="반려동물"/>
								<label class="check-btn" for="zoneInfo6">반려동물</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo7" value="수영장"/>
								<label class="check-btn" for="zoneInfo7">수영장</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo8" value="어린이놀이터"/>
								<label class="check-btn" for="zoneInfo8">어린이놀이터</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo9" value="노래방"/>
								<label class="check-btn" for="zoneInfo9">노래방</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo10" value="온수제공"/>
								<label class="check-btn" for="zoneInfo10">온수제공</label>
							</div>
						</div>	
					</div>
					<div class="camp-num-wrap">
						<div class="form-floating num-wrap">					
							<input type="number" name="zoneMaximum" id="zoneMaximum" placeholder="허용인원" class="form-control" min="1" value="1" required />
							<label for="zoneMaximum">허용인원</label>
						</div>					
						<div class="form-floating num-wrap">					
							<input type="text" name="zonePrice" id="zonePrice" placeholder="구역가격" class="form-control" value="0" required />
							<label for="zonePrice">구역가격</label>
						</div>	
					</div>				
					<div class="mb-3">
						<input type="file" class="form-control" name="upFile" id="upFile1" />
					</div>
					<div class="btn-wrap">
						<button type="button" id="insert-btn">등록</button>
					</div>
				</form:form>
			</div>
		</div>
	</section>
</main>
<script>
document.querySelector("#insert-btn").addEventListener('click', (e) => {
	const frm = document.insertCampZoneFrm;
	const zoneCodes = document.querySelectorAll("#zoneCode");
	const zoneCode = frm.zoneCode.value;
	
	for(let i = 0; i < zoneCodes.length; i++) {
		if(zoneCodes[i].innerHTML == zoneCode) {
			alert(`[\${zoneCode}]는 이미 등록 되어 있는 구역코드입니다.`);
			frm.zoneCode.value = 'Z';
			return;
		}
	}
	document.querySelector("#zonePrice").value = Number(document.querySelector("#zonePrice").value.replaceAll(',',''));
	frm.submit();
});

//필수 기본값 제공
document.querySelector("[name=zoneCode]").addEventListener('input', (e) => {
	const defaultValue = 'Z';
	const regex = new RegExp(`^\${defaultValue}`, "g");
	const value = e.target.value;
	
	if(!regex.test(value)) {
		e.target.value = defaultValue;
	} else {
		if(/[^a-zA-Z+]/g.test(value)) {
			e.target.value = value.replace(/[^a-zA-Z0-9+]/g, '');
		} else {		
			e.target.value = value.toUpperCase();
		}
	}
});

document.querySelector("#zonePrice").addEventListener('keyup', (e) => {
	let value = e.target.value;
	console.log(value);
	value = Number(value.replaceAll(",", ''));
	console.log(value);
	if(isNaN(value)) {
		e.target.value = 0;
	} else {
		const formatVal = value.toLocaleString('ko-KR');
		e.target.value = formatVal; 
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>