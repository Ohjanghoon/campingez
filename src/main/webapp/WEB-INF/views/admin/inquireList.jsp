<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/admin/admin.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
			<div class="content-wrap">
				<h2 class="text-center fw-bold pt-5 pb-5">1:1 문의 리스트</h2>
				<div id="select-bar">
					<select name="inquireType" id="inquireType" class="form-select">
						<option value="" selected>전체</option>
						<c:if test="${not empty categoryList}">
							<c:forEach items="${categoryList}" var="category">
								<option value="${category.categoryId}">${category.categoryName}</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
				<table id="tbl-inquire-list" class="table text-center table-hover">
					<thead>
						<tr>
							<th scope="col">문의번호</th>
							<th scope="col">카테고리명</th>
							<th scope="col">작성자</th>
							<th scope="col">제목</th>
							<th scope="col">답변여부</th>
							<th scope="col">문의날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${not empty inquireList}">
							<c:forEach items="${inquireList}" var="inquire">
								<tr data-inq-no="${inquire.inqNo}">
									<td scope="row">${inquire.inqNo}</td>
									<td scope="row">${inquire.categoryName}</td>
									<td scope="row">${inquire.inqWriter}</td>
									<td scope="row">${inquire.inqTitle}</td>
									<td scope="row" ${inquire.answerStatus == 0 ? 'class="power"' : ''}>
										${inquire.answerStatus == 0 ? '답변대기' : '답변완료'}
									</td>
									<td scope="row" ${inquire.answerStatus == 0 ? 'class="strong"' : ''}>
										<fmt:parseDate value="${inquire.inqDate}" var="inqDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
										<fmt:formatDate value="${inqDate}" pattern="yyyy/MM/dd HH:mm"/>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${empty inquireList}">
							<tr>
								<td colspan="6" scope="row">조회된 문의가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<nav id="inqPagebar">
					${pagebar}
				</nav>
			</div>
		</div>
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
			const oldPagebar = document.querySelector("#inqPagebar");
			
			tbody.innerHTML = '';
			oldPagebar.innerHTML = '';
			
			if(inquireList == '') {
				const tr = `
				<tr>
					<td colspan="6">조회된 문의가 없습니다.</td>
				</tr>
				`;
				tbody.innerHTML += tr;
				return;
			};
			
			inquireList.forEach((inquire) => {				
				const [yyyy, MM, dd, HH, mm] = inquire.inqDate;
				
				const tr = `
				<tr data-inq-no="\${inquire.inqNo}">
					<td scope="row">\${inquire.inqNo}</td>
					<td scope="row">\${inquire.categoryName}</td>
					<td scope="row">\${inquire.inqWriter}</td>
					<td scope="row">\${inquire.inqTitle}</td>
					<td scope="row" \${inquire.answerStatus == 0 ? 'class="power"' : ''}>
						\${inquire.answerStatus == 0 ? '답변대기' : '답변완료'}
					</td>
					<td scope="row" \${inquire.answerStatus == 0 ? 'class="strong"' : ''}>
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