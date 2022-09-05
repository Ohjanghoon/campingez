<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>notice</h2>
	<button id="notice">공지사항 게시글 등록</button>
	<button id="coupon">쿠폰 등록</button>
	<hr />
	<table class="table">
		<thead>
			<tr>
				<th scope="col">공지사항 번호</th>
				<th scope="col">카테고리</th>
				<th scope="col">공지사항 유형</th>
				<th scope="col">제목</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${not empty list}">
				<c:forEach items="${list}" var="list" varStatus="vs">
					<tr data-notice-no="${list.noticeNo}">
						<th scope="row">${vs.count}</th>
						<td>${list.categoryId == 'not1' ? '공지사항' : '이벤트'}</td>
						<td>${list.noticeType}</td>
						<td>${list.noticeTitle}</td>
						<td>${list.noticeDate}</td>
					</tr>
				</c:forEach>
			</c:if>			
		</tbody>
	</table>
	<script>
		// 공지사항 등록
		document.querySelector("#notice").addEventListener('click', (e) => {
			location.href = "${pageContext.request.contextPath}/notice/enrollNotice.do";
		});
		
		// 쿠폰 등록
		document.querySelector("#coupon").addEventListener('click', (e) => {
			location.href = "${pageContext.request.contextPath}/coupon/insertCoupon.do";
		});
	
		const insertHandler = (e) => {
			const parent = e.target.parentElement;
			const noticeNo = parent.dataset.noticeNo;
			console.log(noticeNo);
			
			location.href = `${pageContext.request.contextPath}/notice/detail.do?noticeNo=\${noticeNo}`;
		};
		
		document.querySelectorAll("tr[data-notice-no]").forEach((tr) => {
			tr.addEventListener('click', insertHandler);
		});
	</script>
</body>
</html>