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
	
	<form:form action="${pageContext.request.contextPath}/admin/updateCampZone.do" method="POST">
		<input type="text" name="zoneCode" value="${campZone.zoneCode}" readonly/>
		<input type="text" name="zoneName" value="${campZone.zoneName}" placeholder="구역이름" required />
		<input type="text" name="zoneInfo" value="${campZone.zoneInfo}" placeholder="구역설명" required/>
		<input type="number" name="zoneMaximum" value="${campZone.zoneMaximum}" min="1" max="6" placeholder="최대인원" required/>
		<input type="number" name="zonePrice" value="${campZone.zonePrice}" placeholder="구역가격" required/>
		<button>수정</button>
	</form:form>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>