<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container" id="myReservationList">
<h3>예약목록</h3>
<div id="resList">
	
</div>
	<nav>
		${pagebar}
	</nav>
</div>
</body>
<script>
window.onload = function() {
	reservationPaingAjax(1);
};


function clickPaging() {
	var id = this.id;
	var page = id.substring(4);
	if(page == 0){
		page = -1;
	}
	reservationPaingAjax(page);
	console.log(page);
}

const pagings = document.querySelectorAll(".paging");

pagings.forEach(paging => {
	paging.addEventListener("click", clickPaging);
});

function reservationPaingAjax(cPage){
	$("#resList").empty();
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	$.ajax({
		headers,
		url:"<%=request.getContextPath()%>/userInfo/myReservation.do?cPage="+cPage,
		method : "POST",
		success(response){            
			$("#resList").append(response); 
		},
		error:console.log
	});
}

</script>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>