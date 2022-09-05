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

<main>
	<section>
		<h2>기존 구역 리스트</h2>
		<table>
			<thead>
				<tr>
					<th>No</th>
					<th>구역번호</th>
					<th>구역이름</th>
				</tr>
			</thead>
			<tbody>
		<c:if test="${not empty campZoneList}">
			<c:forEach items="${campZoneList}" var="zone" varStatus="vs">
				<tr>
					<td>${vs.count}</td>
					<td id="zoneCode">${zone.zoneCode}</td>
					<td>${zone.zoneName}</td>
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty campZoneList}">
			<tr>
				<td colspan="3">등록된 구역 정보가 없습니다.</td>
			</tr>
		</c:if>
			</tbody>
		</table>
		
		<h2>캠프 구역 추가</h2>
		<form:form action="${pageContext.request.contextPath}/admin/insertCampZone.do" method="POST" name="insertCampZoneFrm" enctype="multipart/form-data">
			<input type="text" name="zoneCode" placeholder="구역코드 ex)ZA" pattern="[A-Za-z]+" value="Z" required/>
			<input type="text" name="zoneName" placeholder="구역이름" required />
			<br />
			
			<input type="checkbox" name="zoneInfo" id="zoneInfo1" value="매점"/>
			<label for="zoneInfo1">매점</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo2" value="장작판매"/>
			<label for="zoneInfo2">장작판매</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo3" value="샤워시설"/>
			<label for="zoneInfo3">샤워시설</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo4" value="전기"/>
			<label for="zoneInfo3">전기</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo5" value="와이파이"/>
			<label for="zoneInfo5">와이파이</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo6" value="반려동물"/>
			<label for="zoneInfo6">반려동물</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo7" value="수영장"/>
			<label for="zoneInfo7">수영장</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo8" value="어린이놀이터"/>
			<label for="zoneInfo8">어린이놀이터</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo9" value="노래방"/>
			<label for="zoneInfo9">노래방</label>
			<input type="checkbox" name="zoneInfo" id="zoneInfo10" value="온수제공"/>
			<label for="zoneInfo10">온수제공</label>
			
			<br />	
			<input type="number" name="zoneMaximum" placeholder="허용인원" min="1" value="1" required />
			<input type="number" name="zonePrice" placeholder="구역가격" step="1000" value="0" required />
			<br />
			<label for="upFile1">파일을 선택하세요</label>
			<input type="file" name="upFile" id="upFile1" />
			<button type="button" id="insert-btn">등록</button>
		</form:form>
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
	frm.submit();
});

document.querySelector("[name=zoneCode]").addEventListener('keyup', (e) => {
	const value = e.target.value;
	
	if(/[^a-zA-Z+]/g.test(value)) {
		e.target.value = value.replace(/[^a-zA-Z+]/g, ''); 
	} else {		
		e.target.value = value.toUpperCase();
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>