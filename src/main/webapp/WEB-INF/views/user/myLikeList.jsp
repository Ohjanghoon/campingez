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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container" id="myTradeList">
	<div>
	<h3 id="titleLeft">내 찜목록</h3>
	</div>
	<table class="table">
		<thead>
			<th scope="col">No</th>
			<th scope="col">거래번호</th>
			<th scope="col">유저 아이디</th>
			<th scope="col">제품카테고리</th>
			<th scope="col">제목</th>
			<th scope="col">내용</th>
			<th scope="col">가격</th>
			<th scope="col">거래상태</th>
			<th scope="col">제품상태</th>
			<th scope="col">좋아요</th>
			<th scope="col">작성일</th>
			<th scope="col">조회수</th>
		</thead>
		<tbody id="tradeTbody">
			<c:forEach items="${result}" var="trade" varStatus="vs">
				<tr onclick="location.href='${pageContext.request.contextPath}/trade/tradeView.do?no=${trade.tradeNo}'" data-no="${trade.tradeNo}">
					<td>${vs.count}</td>
					<td>${trade.tradeNo}</td>
					<td>${trade.userId}</td>
					<td>${trade.categoryId}</td>
					<td>${trade.tradeTitle}</td>
					<td>
						<div class="tradeContent">
						${trade.tradeContent}
						</div>
					</td>
					<td><fmt:formatNumber value="${trade.tradePrice}" pattern="#,###"/>원</td>
					<td>${trade.tradeSuccess}</td>
					<td>${trade.tradeQuality}</td>
					<td>${trade.likeCount}</td>
					<td>
						<fmt:parseDate value="${trade.tradeDate}" pattern="yyyy-MM-dd" var="resDate" />
						<fmt:formatDate value="${resDate}" pattern="yyyy/MM/dd" />
					</td>
					<td>${trade.readCount}</td>
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
	var page = id.substring(4);
	if(page == 0){
		page = -1;
	}
	tradePaingAjax(page);
	console.log(page);
}

const pagings = document.querySelectorAll(".paging");

pagings.forEach(paging => {
	paging.addEventListener("click", clickPaging);
});

function tradePaingAjax(cPage){
	$("#tradeTbody").empty();
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	$.ajax({
		headers,
		url:"<%=request.getContextPath()%>/userInfo/myLikeList.do?cPage="+cPage,
		method : "POST",
		success(response){
            var results = response.result;
            var str = "";
            for(var i = 0; i < results.length; i++){
            	var months = results[i].tradeDate[1] < 10 ? '0' + results[i].tradeDate[1] : results[i].tradeDate[1];
            	var days = results[i].tradeDate[2] < 10 ? '0' + results[i].tradeDate[2] : results[i].tradeDate[2];
            	str += 	`<tr onclick="location.href='${pageContext.request.contextPath}/trade/tradeView.do?no=`+results[i].tradeNo+`'" data-no="'+results[i].tradeNo+'">`+
								'<td>'+ (i+1) +'</td>'+
								'<td>'+results[i].tradeNo+'</td>'+
								'<td>'+results[i].userId+'</td>'+
								'<td>'+results[i].categoryId+'</td>'+
								'<td>'+results[i].tradeTitle+'</td>'+
								'<td>'+
								'<div class="tradeContent">'+
									results[i].tradeContent +
								'</div>'+
								'</td>' +
								'<td>'+results[i].tradePrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+'원</td>'+
								'<td>'+results[i].tradeSuccess+'</td>'+
								'<td>'+results[i].tradeQuality+'</td>'+
								'<td>'+results[i].likeCount+'</td>'+
								'<td>'+
									results[i].tradeDate[0]+'-' + months + '-' + days +
								'</td>'+
								'<td>'+results[i].readCount+'</td>' + 
						'</tr>';            	
            }
			$("#tradeTbody").append(str); 
		},
		error:console.log
	});
}

</script>
</html>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>