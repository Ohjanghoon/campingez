<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>
<body>
	<h3>공지사항은 뭘까요?</h3>
	<button id="update">수정</button>
	<button id="delete">삭제</button>
	<hr />
	<c:if test="${notice.categoryId == 'not1'}">
	<!-- 공지사항용 jsp -->
		<table class="table">
		<tr>
			<th>제목</th>
			<td>[${notice.categoryId == 'not1' ? '공지사항' : '이벤트'}] ${notice.noticeTitle}</td>
			<th>내용</th>
			<td>${notice.noticeContent}</td>
			<th>작성일</th>
			<td>${notice.noticeDate}</td>
		</tr>
		<tr>
			<c:if test="${not empty notice.photos}">
				<c:forEach items="${notice.photos}" var="photo">	
					<td><img src ="${pageContext.request.contextPath}/resources/upload/notice/${photo.noticeRenamedFilename}" class="upload" width="100px"></td>
				</c:forEach>
			</c:if>
		</tr>
		</table>
	</c:if>
	<c:if test="${notice.categoryId == 'not2'}">
	<!-- 이벤트용 -->
	<table class="table">
		<tr>
			<th>제목</th>
			<td>[${notice.categoryId == 'not1' ? '공지사항' : '이벤트'}] ${notice.noticeTitle}</td>
			<th>작성일</th>
			<td>${notice.noticeDate}</td>
		</tr>
		<tr>
			<c:if test="${not empty notice.photos}">
				<c:forEach items="${notice.photos}" var="photo">	
					<td colspan="3"><img src ="${pageContext.request.contextPath}/resources/upload/notice/${photo.noticeRenamedFilename}" class="upload" width="350px"></td>
				</c:forEach>
			</c:if>
		</tr>
	</table>
	<div class="coupon"></div>
	</c:if>
	<script>
		const headers = {};
        headers['${_csrf.headerName}'] = '${_csrf.token}';
        
		$.ajax({
			url : "${pageContext.request.contextPath}/coupon/couponInfo.do",
			headers,
			data : ("${notice.noticeContent}"),
			method : "POST",
			success(response){
				console.log(response);
				const {couponCode, couponName, couponDiscount, couponStartday, couponEndday} = response;
				
				document.querySelector(".coupon").innerHTML =`
					<form:form name="couponDownFrm" action="" method="POST">
					<input type="hidden" name="userId" value="<sec:authentication property='principal.username'/>"/>
					<input type="hidden" name="couponCode" value="${notice.noticeContent}"/>
					<h3>쿠폰</h3>
					<span name="couponName" >쿠폰명 : \${couponName}</span><br />
					<sppn name="couponDiscount">할인률 : \${couponDiscount}%</span><br />
					<sppn name="coupon">기간 : \${couponStartday}~\${couponEndday}</span><br />
					<button type="button" id="btn3">쿠폰 다운로드</button>
					</form:form>
					
				`;
				
				// 쿠폰 받기
				document.querySelector("#btn3").addEventListener('click', (e) => {
					e.preventDefault();
					const userId = "<sec:authentication property='principal.username'/>";
					const couponCode = "${notice.noticeContent}";
					$.ajax({
						url : "${pageContext.request.contextPath}/coupon/couponDown.do",
						headers,
						data : {couponCode, userId},
						method : "POST",
						success(response){
							alert("쿠폰을 받았습니다.");
						},
						error : console.log
					});
				});
				
			},
			error : console.log
		});
		
		// 수정
		document.querySelector("#update").addEventListener('click', (e) => {
			location.href = "${pageContext.request.contextPath}/notice/update.do?noticeNo=${notice.noticeNo}";
		});
		// 삭제
		document.querySelector("#delete").addEventListener('click', (e) => {
			const result = confirm("정말 삭제하시겠습니까?");
			if(result == true){
				location.href = "${pageContext.request.contextPath}/notice/delete.do?noticeNo=${notice.noticeNo}";
			}
		});
	</script>
</body>
</html>