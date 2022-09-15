<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:out value="${assignList}"></c:out>
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
<div class="container" id="myAssignmentList">
<h3>양도목록</h3>
	<table class="table">
		<thead>
			<th scope="col">양도번호</th>
			<th scope="col">사용자 아이디</th>
			<th scope="col">예약번호</th>
			<th scope="col">제목</th>
			<th scope="col">내용</th>
			<th scope="col">양도가격</th>
			<th scope="col">마감일자</th>
			<th scope="col">좋아요</th>
			<th scope="col">양도상태</th> 
		</thead>
		<tbody id="assignTbody">
			<c:forEach items="${assignList}" var="assign" varStatus="vs" >
				<tr data-no="${assign.assignNo}">
					<td>${assign.assignNo}</td>
					<td>${assign.userId}</td>
					<td>${assign.resNo}</td>
					<td>${assign.assignTitle}</td>
					<td>${assign.assignContent}</td>
					<td><fmt:formatNumber value="${assign.assignPrice}" pattern="#,###"/>원</td>
					<td>
						<fmt:parseDate value="${assign.assignDate}" pattern="yyyy-MM-dd" var="assignDate" />
						<fmt:formatDate value="${assignDate}" pattern="yyyy-MM-dd" />
					</td>
					<td>${assign.assignLikeCount}</td>
					<td>${assign.assignState}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<nav>
		${pagebar}
	</nav>	
</div>
</body>
<script>

function clickPaging() {
	var id = this.id;
	console.log("그아아아아악");
	console.log(id);
	var page = id.substring(4);
	if(page == 0){
		page = -1;
	}
	assignmentPaingAjax(page);
}

const pagings = document.querySelectorAll(".paging");

pagings.forEach(paging => {
	paging.addEventListener("click", clickPaging);
});

function assignmentPaingAjax(cPage){
	$("#assignTbody").empty();
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	$.ajax({
		headers,
		url:"<%=request.getContextPath()%>/userInfo/assignment.do?cPage="+cPage,
		method : "POST",
		success(response){
            var results = response.assignList;
            console.log(results);
            var str = "";
            for(var i = 0; i < results.length; i++){
            	str += 	'<tr data-no="'+results[i].assignNo+'">'+
								'<td>'+results[i].assignNo+'</td>'+
								'<td>'+results[i].userId+'</td>'+
								'<td>'+results[i].resNo+'</td>'+
								'<td>'+results[i].assignTitle+'</td>'+
								'<td>'+results[i].assignContent+'</td>'+
								'<td>'+results[i].assignPrice+'</td>'+
								'<td>'+
									results[i].assignDate+
								'</td>'+
								'<td>'+results[i].assignLikeCount+'</td>'+
								'<td>'+results[i].assignState+'</td>'+
						'</tr>';            	
            }
			$("#assignTbody").append(str); 
            /* var str = '<TR>';
            $.each(results , function(i){
                str += '<TD>' + results[i].bdTitl + '</TD><TD>' + results[i].bdWriter + '</TD><TD>' + results[i].bdRgDt + '</TD>';
                str += '</TR>';
           });
           $("#boardList").append(str);  */
		},
		error:console.log
	});
}

</script>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>