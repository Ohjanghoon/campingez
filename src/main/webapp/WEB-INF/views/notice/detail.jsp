<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<%
	pageContext.setAttribute("newLine", "\n");
%>
<main>
	<div class="container">
	<h2 class="text-center fw-bold pt-5">공지사항</h2>
		<div class="d-grid gap-2 d-md-flex justify-content-md-end pt-5">
	<sec:authorize access="hasRole('ROLE_ADMIN')">
			<button class="btn btn-outline-dark" type="button" id="update" onclick="location.href ='${pageContext.request.contextPath}/notice/update.do?noticeNo=${notice.noticeNo}';">수정 <i class="fa-solid fa-wrench"></i></button>
			<button class="btn btn-outline-dark" type="button" id="delete">삭제 <i class="fa-solid fa-xmark"></i></button>
	</sec:authorize>
			<button class="btn btn-outline-dark" type="button" onclick="location.href='${pageContext.request.contextPath}/notice/list';">목록으로 <i class="fa-solid fa-list"></i></button>
		</div>
	<hr />
	<!-- 공지사항용 jsp -->
	<c:if test="${notice.categoryId == 'not1'}">
		<div class="px-4 pt-2 my-5 text-center border-bottom">
		    <h5 class="display-10 fw-bold">${notice.noticeTitle} [${notice.noticeType}]</h5>
		    <h6>${notice.noticeDate}</h6>
		    <div class="col-lg-6 mx-auto">
		      <p class="lead mb-5">${fn:replace(notice.noticeContent, newLine, '<br/>')}</p>
		    </div>
			<div class="container px-5">
				<c:forEach items="${notice.photos}" var="photo">	
					<c:if test="${photo.noticeRenamedFilename != null}">
						<img src ="${pageContext.request.contextPath}/resources/upload/notice/${photo.noticeRenamedFilename}" class="img-fluid border rounded-3 shadow-lg mb-4" width="700" height="500">
					</c:if>
				</c:forEach>
			</div>
		  </div>
	</c:if>
	<!-- 이벤트용 -->
	<c:if test="${notice.categoryId == 'not2'}">
		<div class="px-4 pt-2 my-5 text-center border-bottom">
		    <h5 class="display-10 fw-bold">${notice.noticeTitle} [${notice.noticeType}]</h5>
		    <h6>${notice.noticeDate}</h6>
			<div class="coupon p-5 d-flex justify-content-center"></div>
			<div class="container px-5">
				<c:forEach items="${notice.photos}" var="photo">	
					<c:if test="${photo.noticeRenamedFilename != null}">
						<img src ="${pageContext.request.contextPath}/resources/upload/notice/${photo.noticeRenamedFilename}" class="img-fluid border rounded-3 shadow-lg mb-4" width="700" height="500">
					</c:if>
				</c:forEach>
			</div>
		</div>
	</c:if>
	</div>
</main>
	<script>
	<sec:authorize access="isAuthenticated()">
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
					<div class="card text-center" style="width: 18rem;">
					  <h4 class="card-header">\${couponName}</h4>
					  <div class="card-body">
					    <p class="card-text">할인률 : \${couponDiscount}%</p>
					    <p class="card-text">사용기간 : \${couponStartday}~\${couponEndday}</p>
					    <button type="button" class="btn btn-md btn-outline-dark mt-3 w-100" id="btn3"><i class="fa-solid fa-download"></i></button>
					  </div>
					</div>
					</form:form>
				`;
				
				// 쿠폰 받기
				document.querySelector("#btn3").addEventListener('click', (e) => {
					e.preventDefault();
					const couponCode = "${notice.noticeContent}";
					const userId = "<sec:authentication property='principal.username'/>";
					$.ajax({
						url : "${pageContext.request.contextPath}/coupon/couponDown.do",
						headers,
						data : {couponCode, userId},
						method : "POST",
						success(map){
							console.log(map);
							alert(map.resultMessage);
						},
						error : console.log
					});
				});
				
			},
			error : console.log
		});
	</sec:authorize>
	<sec:authorize access="hasRole('ROLE_ADMIN')">
		document.querySelector("#delete").addEventListener('click', (e) => {
			const result = confirm("정말 삭제하시겠습니까?");
			if(result == true){
				location.href = "${pageContext.request.contextPath}/notice/delete.do?noticeNo=${notice.noticeNo}";
			}
		});
	</sec:authorize>
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>