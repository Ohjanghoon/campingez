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
	
	
	<table>
		<thead>
			<tr>
				<th>No</th>
				<th>문의유형</th>
				<th>작성자</th>
				<th>문의제목</th>
				<th>작성일</th>
				<th>답변상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${inquireList}" var="inq" varStatus="vs">
				<tr data-no="${inq.inqNo}">
					<td>${vs.count}</td>
					<td>${inq.categoryId}</td>
					<td>${inq.inqWriter}</td>
					<td>${inq.inqTitle}</td>
					<td>
						<fmt:parseDate value="${inq.inqDate}" pattern="yyyy-MM-dd'T'HH:mm" var="inqDate" />
						<fmt:formatDate value="${inqDate}" pattern="yyyy/MM/dd" />
					</td>
					<td>${inq.answerStatus == 0 ? "답변대기" :"답변완료" }</td>
				</tr>
			</c:forEach>
			<tr>
				<td>
					<c:if test="${empty prePageName}">
						<button
							type="button"
							onclick="location.href='${pageContext.request.contextPath}/inquire/inquireForm.do'">문의하기
						</button>
					</c:if>
						
				</td>
			</tr>
		</tbody>
	</table>
	
	<script>
	document.querySelectorAll("tr[data-no]").forEach((tr) => {
		
		tr.addEventListener('click', (e) => {
			console.log(e.target);
			const tr = e.target.parentElement;
			const no = tr.dataset.no;
			if(no){
				location.href=`${pageContext.request.contextPath}/inquire/inquireDetail.do?no=` + no;
			}
		});
	});
	</script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>