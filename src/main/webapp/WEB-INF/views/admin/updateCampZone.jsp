<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="com.kh.campingez.campzone.model.dto.CampZone"%>
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
				<h2>캠프 구역 정보 수정</h2>
				<form:form action="${pageContext.request.contextPath}/admin/updateCampZone.do" name="updateFrm" method="POST" enctype="multipart/form-data">
					<div class="camp-name-wrap">
						<div class="form-floating zone-wrap">
							<input type="text" name="zoneCode" id="zoneCode" placeholder="구역코드" pattern="[A-Za-z]+" class="form-control" value="${campZone.zoneCode}" readonly/>
							<label for="zoneCode">구역코드</label>
						</div>
						<div class="form-floating zone-wrap">					
							<input type="text" name="zoneName" id="zoneName" class="form-control" placeholder="구역이름" value="${campZone.zoneName}" required />
							<label for="zoneName" class="zoneName-label">구역이름</label>
						</div>
					</div>
					<%
						String[] campZones = ((CampZone)request.getAttribute("campZone")).getZoneInfo();
						List<String> infoList = Arrays.asList(campZones);
						pageContext.setAttribute("infoList", infoList);
					%>
					<div class="option-wrap">
						<div class="option-header">
							<div class="strong">* 옵션선택</div>
						</div>
						<div class="option-check-wrap">
							<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo1" value="매점" autocomplete="off" ${infoList.contains('매점') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo1">매점</label>
							
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo2" value="장작판매" autocomplete="off" ${infoList.contains('장작판매') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo2">장작판매</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo3" value="샤워시설" autocomplete="off" ${infoList.contains('샤워시설') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo3">샤워시설</label>
							
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo4" value="전기" autocomplete="off" ${infoList.contains('전기') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo4">전기</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo5" value="와이파이" ${infoList.contains('와이파이') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo5">와이파이</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo6" value="반려동물" ${infoList.contains('반려동물') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo6">반려동물</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo7" value="수영장" ${infoList.contains('수영장') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo7">수영장</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo8" value="어린이놀이터" ${infoList.contains('어린이놀이터') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo8">어린이놀이터</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo9" value="노래방" ${infoList.contains('노래방') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo9">노래방</label>
		
								<input type="checkbox" name="zoneInfo" class="btn-check" id="zoneInfo10" value="온수제공" ${infoList.contains('온수제공') ? 'checked' : ''}/>
								<label class="check-btn" for="zoneInfo10">온수제공</label>
							</div>
						</div>	
					</div>
					<div class="camp-num-wrap">
						<div class="form-floating num-wrap">					
							<input type="number" name="zoneMaximum" id="zoneMaximum" placeholder="최대인원" class="form-control" min="1" max="6" value="${campZone.zoneMaximum}" required />
							<label for="zoneMaximum">최대인원</label>
						</div>					
						<div class="form-floating num-wrap">					
							<input type="text" name="zonePrice" id="zonePrice" placeholder="구역가격" class="form-control"  value="<fmt:formatNumber value="${campZone.zonePrice}" pattern="#,###"/>" required />
							<label for="zonePrice">구역가격</label>
						</div>	
					</div>		
					<c:if test="${not empty campZone.campPhotos}">
						<c:forEach items="${campZone.campPhotos}" var="photo" varStatus="vs">
							<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
							    <input type="checkbox" class="btn-check" id="delFile${vs.count}" name="delFile" value="${photo.zonePhotoNo}">
								<label for="delFile${vs.count}" class="btn btn-outline-danger btn-block" style="overflow: hidden" title="">첨부파일 ${photo.originalFilename} 삭제</label>
							</div>
						</c:forEach>
					</c:if>
					<div class="mb-3 mt-1">
						<input type="file" class="form-control" name="upFile" id="upFile1" multiple />
					</div>
					<div class="btn-wrap">
						<button id="update-btn" type="button">수정</button>
					</div>
				</form:form>
			</div>
		</div>
	</section>
</main>
<script>
document.querySelector("#zonePrice").addEventListener('keyup', (e) => {
	let value = e.target.value;
	value = Number(value.replaceAll(",", ''));
	if(isNaN(value)) {
		e.target.value = 0;
	} else {
		const formatVal = value.toLocaleString('ko-KR');
		e.target.value = formatVal; 
	}
});

document.querySelector("#update-btn").addEventListener('click', (e) => {
	const delFileTotal = $("input[name=delFile]").length
	const delFileChecked = $("input[name=delFile]:checked").length;
	const upFile = document.querySelector("[name=upFile]");
	const zoneInfoChecked = $("input[name=zoneInfo]:checked").length;
	const zonePrice = document.querySelector("#zonePrice");
	
	if(upFile.files.length < 1 && (delFileTotal == delFileChecked)) {
		alert("반드시 하나 이상의 사진을 등록해주세요.");
		upFile.focus();
		return;
	} else if(!document.querySelector("#zoneName").value) {
		alert("구역이름을 반드시 입력해주세요");
		document.querySelector("#zoneName").focus();
		return;
	} else if(!document.querySelector("#zoneMaximum").value) {
		alert("최대인원을 반드시 입력해주세요");
		document.querySelector("#zoneMaximum").focus();
		return;
	} else if(zoneInfoChecked < 1) {
		alert("반드시 하나 이상의 옵션을 선택해주세요");
		return;
	} else if(!zonePrice.value || zonePrice.value == 0) {
		alert("구역가격을 반드시 입력해주세요");
		zonePrice.focus();
		return;
	}
	document.querySelector("#zonePrice").value = Number(document.querySelector("#zonePrice").value.replaceAll(',',''));
	document.updateFrm.submit();
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>