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

<main>
	<section>
		<table>
			<thead>
				<tr>
					<th>문의번호</th>
					<th>카테고리명</th>
					<th>작성자</th>
					<th>제목</th>
					<th>답변여부</th>
					<th>문의날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty inquireList}">
					<c:forEach items="${inquireList}" var="inquire">
						<tr data-inq-no="${inquire.inqNo}">
							<td>${inquire.inqNo}</td>
							<td>${inquire.categoryName}</td>
							<td>${inquire.inqWriter}</td>
							<td>${inquire.inqTitle}</td>
							<td>
								${inquire.answerStatus == 0 ? '답변대기' : '답변완료'}
							</td>
							<td>
								<fmt:parseDate value="${inquire.inqDate}" var="inqDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
								<fmt:formatDate value="${inqDate}" pattern="yyyy/MM/dd HH:mm"/>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
	</section>
</main>
<script>
document.querySelectorAll("tr[data-inq-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		const tr = e.target.parentElement;
		const inqNo = tr.dataset.inqNo;
		
		if(!inqNo) return;
		
		location.href = `${pageContext.request.contextPath}/inquire/inquireDetail.do?no=\${inqNo}`;
	});
})
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>