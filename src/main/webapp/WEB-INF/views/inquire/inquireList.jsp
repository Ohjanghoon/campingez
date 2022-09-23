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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css" />
	<div class="container" id="inquireList">
		<h3 style="margin-top:20px;" id="titleLeft">
			<img style="margin-right:20px;" src="${pageContext.request.contextPath}/resources/images/mypage/question.png" width="50px">
			1:1 문의
		</h3>
		<c:if test="${empty prePageName}">
			<sec:authorize access="isAuthenticated()">
				<div class="my-3 d-flex justify-content-end">
					<button
						style="margin-top:20px;"
						type="button"
						class="btn btn-outline-dark"
						onclick="location.href='${pageContext.request.contextPath}/inquire/inquireForm.do'">문의하기
					</button>
				</div>
			</sec:authorize>
		</c:if>
	<table class="table table-striped table-hover" id="tradeTable">
		<thead style=" line-height: 46px;" class="table-light">
			<tr class="text-center">
				<th style="width: 5%">No</th>
				<th style="width: 9%">문의유형</th>
				<th>작성자</th>
				<th>문의제목</th>
				<th>작성일</th>
				<th style="width: 12%">답변상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${inquireList}" var="inq" varStatus="vs">
				<sec:authorize access="isAnonymous()" var="anonymous" />
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal.username" var="userId"/>
					<sec:authorize access="!hasRole('ROLE_ADMIN') and !${userId eq inq.inqWriter}" var="notAllow" />
				</sec:authorize>
				<tr style=" line-height: 46px; cursor:pointer;" data-no="${inq.inqNo}" data-allow="${anonymous or notAllow}">
					<td class="text-center">${(cPage - 1) * limit + vs.count}</td>
					<td class="text-center">${inq.categoryName}</td>
					<td class="text-center">${inq.inqWriter}</td>
					<td class="text-left">
						<c:if test="${anonymous or notAllow}">
							&nbsp;<i class="fa-sharp fa-solid fa-lock"></i>&nbsp;
						</c:if>
						${inq.inqTitle}
					</td>
					<td class="text-center">
						<fmt:parseDate value="${inq.inqDate}" pattern="yyyy-MM-dd'T'HH:mm" var="inqDate" />
						<fmt:formatDate value="${inqDate}" pattern="yyyy/MM/dd" />
					</td>
					<td class="text-center">${inq.answerStatus == 0 ? "답변대기" :"답변완료" }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="d-flex justify-content-center">
		<nav aria-label="Page navigation example">
			${pagebar}
		</nav>
	</div>
	</div>
	<script>
	document.querySelectorAll("tr[data-no]").forEach((tr) => {
		
		tr.addEventListener('click', (e) => {
			const td = e.target;
			const tr = td.parentElement;
			
			const inqNo = tr.dataset.no;
			const allow = tr.dataset.allow;
			//console.log(inqNo, allow, typeof allow);
			
			if(allow === 'true') {
				alert("해당 작성자와 관리자만 열람 가능합니다.");
				return;
			}
			if(inqNo){
				location.href="${pageContext.request.contextPath}/inquire/inquireDetail.do?no=" + inqNo;
			}
		});
	});
	
	//화면 로드시 스크롤 이동
	$(document).ready(function () {
		$('html, body, .container').animate({scrollTop: $('#myCarousel').outerHeight(true) - $('.blog-header').outerHeight(true) }, 'fast');
	});
	</script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>