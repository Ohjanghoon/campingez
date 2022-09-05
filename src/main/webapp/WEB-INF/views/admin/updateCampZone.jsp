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
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
	<h2>캠프 구역 정보 수정</h2>
	
	<form:form action="${pageContext.request.contextPath}/admin/updateCampZone.do" method="POST" enctype="multipart/form-data">
		<input type="text" name="zoneCode" value="${campZone.zoneCode}" readonly/>
		<input type="text" name="zoneName" value="${campZone.zoneName}" placeholder="구역이름" required />
		<br />
		<%
			String[] campZones = ((CampZone)request.getAttribute("campZone")).getZoneInfo();
			List<String> infoList = Arrays.asList(campZones);
			pageContext.setAttribute("infoList", infoList);
		%>
		<input type="checkbox" name="zoneInfo" id="zoneInfo1" value="매점" ${infoList.contains('매점') ? 'checked' : ''}/>
		<label for="zoneInfo1">매점</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo2" value="장작판매" ${infoList.contains('장작판매') ? 'checked' : ''}/>
		<label for="zoneInfo2">장작판매</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo3" value="샤워시설" ${infoList.contains('샤워시설') ? 'checked' : ''}/>
		<label for="zoneInfo3">샤워시설</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo4" value="전기" ${infoList.contains('전기') ? 'checked' : ''}/>
		<label for="zoneInfo3">전기</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo5" value="와이파이" ${infoList.contains('와이파이') ? 'checked' : ''}/>
		<label for="zoneInfo5">와이파이</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo6" value="반려동물" ${infoList.contains('반려동물') ? 'checked' : ''}/>
		<label for="zoneInfo6">반려동물</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo7" value="수영장" ${infoList.contains('수영장') ? 'checked' : ''}/>
		<label for="zoneInfo7">수영장</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo8" value="어린이놀이터" ${infoList.contains('어린이놀이터') ? 'checked' : ''}/>
		<label for="zoneInfo8">어린이놀이터</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo9" value="노래방" ${infoList.contains('노래방') ? 'checked' : ''}/>
		<label for="zoneInfo9">노래방</label>
		<input type="checkbox" name="zoneInfo" id="zoneInfo10" value="온수제공" ${infoList.contains('온수제공') ? 'checked' : ''}/>
		<label for="zoneInfo10">온수제공</label>
		<br />
		<input type="number" name="zoneMaximum" value="${campZone.zoneMaximum}" min="1" max="6" placeholder="최대인원" required/>
		<input type="number" name="zonePrice" value="${campZone.zonePrice}" placeholder="구역가격" required/>
		<br />
		<c:if test="${not empty campZone.campPhotos}">
			<c:forEach items="${campZone.campPhotos}" var="photo" varStatus="vs">
				<input type="checkbox" name="delFile" id="delFile${vs.count}" value="${photo.zonePhotoNo}" />
				<label for="delFile${vs.count}">첨부파일${vs.count} 삭제 - ${photo.originalFilename}</label>
			</c:forEach>
		</c:if>
		<br />
		<label for="upFile1">파일업로드</label>
		<input type="file" name="upFile" id="upFile1" />
		<br />
		<button>수정</button>
	</form:form>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>