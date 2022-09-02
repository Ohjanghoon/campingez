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
		<div id="select-bar">
			<select name="inquireType" id="inquireType">
				<option value="" selected disabled>문의유형</option>
				<option value="">전체</option>
				<c:if test="${not empty categoryList}">
					<c:forEach items="${categoryList}" var="category">
						<option value="${category.categoryId}">${category.categoryName}</option>
					</c:forEach>
				</c:if>
			</select>
		</div>
		<table id="tbl-inquire-list">
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
				<c:if test="${empty inquireList}">
					<tr>
						<td colspan="6">조회된 문의가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<nav>
			${pagebar}
		</nav>
	</section>
</main>
<script>
document.querySelectorAll("tr[data-inq-no]").forEach((tr) => {
	tr.addEventListener('click', (e) => {
		moveToInquireDetail(e);
	});
});

const moveToInquireDetail = (e) => {
	const tr = e.target.parentElement;
	const inqNo = tr.dataset.inqNo;
	
	if(!inqNo) return;
	
	location.href = `${pageContext.request.contextPath}/inquire/inquireDetail.do?no=\${inqNo}`;
}

const inquireListByCategoryIdRender = (categoryId, pageNo) => {
	$.ajax({
		url : `${pageContext.request.contextPath}/admin/inquireListByCategoryId.do?categoryId=\${categoryId}&cPage=\${pageNo}`,
		method : "GET",
		content : "application/json",
		success(response) {
			const {inquireList, pagebar} = response;
			const tbody = document.querySelector("#tbl-inquire-list tbody");
			const oldPagebar = document.querySelector("nav");
			
			console.log(pagebar);
			
			tbody.innerHTML = '';
			oldPagebar.innerHTML = '';
			
			if(!inquireList) {
				const tr = `
				<tr>
					<td colspan="6">조회된 문의가 없습니다.</td>
				</tr>
				`;
				tbody.innerHTML += tr;
				return;
			}
			
			inquireList.forEach((inquire) => {				
				const [yyyy, MM, dd, HH, mm] = inquire.inqDate;
				
				const tr = `
				<tr data-inq-no="\${inquire.inqNo}">
					<td>\${inquire.inqNo}</td>
					<td>\${inquire.categoryName}</td>
					<td>\${inquire.inqWriter}</td>
					<td>\${inquire.inqTitle}</td>
					<td>
						\${inquire.answerStatus == 0 ? '답변대기' : '답변완료'}
					</td>
					<td>
						\${yyyy}/\${MM}/\${dd} \${HH}:\${mm}
					</td>
				</tr>
				`;
				tbody.innerHTML += tr;
				
				document.querySelectorAll("tr[data-inq-no]").forEach((tr) => {
					tr.addEventListener('click', (e) => {
						moveToInquireDetail(e);
					});
				});
			});
			oldPagebar.innerHTML = pagebar;
			
			// 페이지 이동
			document.querySelectorAll(".paging").forEach((span) => {
				span.addEventListener('click', (e) => {
					const pageNo = e.target.id.substring(4);
					inquireListByCategoryIdRender(categoryId, pageNo);
				});
			});
		},
		error : console.log()
	});
};

document.querySelector("#inquireType").addEventListener('change', (e) => {
	const categoryId = e.target.value;
	
	if(!categoryId) {
		location.href = "${pageContext.request.contextPath}/admin/inquireList.do";
		return;
	};
	inquireListByCategoryIdRender(categoryId, 1);
});

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>