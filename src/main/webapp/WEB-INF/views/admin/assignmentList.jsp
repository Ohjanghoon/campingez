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
				<div class="assign-ing-wrap">
					<h2>양도 현황</h2>
					<div class="select-wrap d-flex">
						<select id="selectType" class="form-select">
							<option value="" selected>전체</option>
							<option value="양도중">양도중</option>
							<option value="양도대기">양도대기</option>
						</select>
					</div>
					<table class="table text-center" id="tbl-assign-list">
						<thead>
							<tr>
								<th scope="col">예약번호</th>
								<th scope="col">양도자</th>
								<th scope="col">양수자</th>
								<th scope="col">양도가</th>
								<th scope="col">원가</th>
								<th scope="col">체크인</th>
								<th scope="col">체크아웃</th>
								<th scope="col">상태</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty assignmentList}">
								<c:forEach items="${assignmentList}" var="ass">
									<tr>
										<td scope="row">${ass.resNo}</td>
										<td scope="row">${ass.userId}</td>
										<td scope="row">${ass.assignTransfer}</td>
										<td scope="row">
											<fmt:formatNumber value="${ass.assignPrice}" type="currency"/>
										</td>
										<td scope="row">
											<fmt:formatNumber value="${ass.reservation.resPrice}" type="currency"/>
										</td>
										<td scope="row">${ass.reservation.resCheckin}</td>
										<td scope="row">${ass.reservation.resCheckout}</td>
										<td scope="row">${ass.assignState}</td>
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<div id="pagebar">
						${pagebar}
					</div>
				</div>
				<div class="assign-before-wrap">
					<h2>양도실패 - ${expireTotalContent}건</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th scope="col">예약번호</th>
								<th scope="col">양도자</th>
								<th scope="col">양수자</th>
								<th scope="col">양도가</th>
								<th scope="col">원가</th>
								<th scope="col">체크인</th>
								<th scope="col">체크아웃</th>
								<th scope="col">신청일</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty expireAssignmentList}">
								<c:forEach items="${expireAssignmentList}" var="ass">
									<tr>
										<td scope="row">${ass.resNo}</td>
										<td scope="row">${ass.userId}</td>
										<td scope="row">${ass.assignTransfer}</td>
										<td scope="row">
											<fmt:formatNumber value="${ass.assignPrice}" type="currency"/>
										</td>
										<td scope="row">
											<fmt:formatNumber value="${ass.reservation.resPrice}" type="currency"/>
										</td>
										<td scope="row">${ass.reservation.resCheckin}</td>
										<td scope="row">${ass.reservation.resCheckout}</td>
										<td scope="row">
											<fmt:parseDate value="${ass.assignDate}" var="assignDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
											<fmt:formatDate value="${assignDate}" pattern="yyyy-MM-dd"/>
										</td>										
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty expireAssignmentList}">
								<tr>
									<td colspan="7" scope="row">조회된 양도 건이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<div id="expirePagebar">
						${expirePagebar}
					</div>
				</div>
			</div>
		</div>
	</section>
</main>
<script>
document.querySelector("#selectType").addEventListener('change', (e) => {
	const selectType = e.target.value;
	
	if(!selectType) {
		location.reload();
		return;
	}
	assignmentListBySelectTypeRender(selectType, 1);
});

const assignmentListBySelectTypeRender = (selectType, cPage) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/assignmentListBySelectType.do",
		data : {selectType, cPage},
		content : "application/json",
		success(response) {
			console.log(response);
			const {assignmentList, pagebar} = response;
			const tbody = document.querySelector("#tbl-assign-list tbody");
			const oldPagebar = document.querySelector("#pagebar");
			
			tbody.innerHTML = '';
			oldPagebar.innerHTML = '';
			
			if(assignmentList == '') {
				const tr = `
				<tr>
					<td colspan="8">조회된 양도 건이 없습니다.</td>
				</tr>
				`;
				tbody.innerHTML += tr;
				return;
			}
			
			assignmentList.forEach((assign) => {
				console.log(assign);
				const {resNo, userId, assignTransfer, assignPrice, reservation, assignState} = assign;
				const {resPrice, resCheckin, resCheckout} = reservation;
				
				const tr = `
				<tr>
					<td>\${resNo}</td>
					<td>\${userId}</td>
					<td>\${assignTransfer == null ? '' : assignTransfer}</td>
					<td>￦\${assignPrice.toLocaleString()}</td>
					<td>￦\${resPrice.toLocaleString()}</td>
					<td>\${resCheckin}</td>
					<td>\${resCheckout}</td>
					<td>\${assignState}</td>
				</tr>
				`;
				tbody.innerHTML += tr;
			});
			oldPagebar.innerHTML = pagebar;
			
			// 페이지 이동
			document.querySelectorAll(".paging").forEach((span) => {
				span.addEventListener('click', (e) => {
					const pageNo = e.target.id.substring(4);
					assignmentListBySelectTypeRender(document.querySelector("#selectType").value, pageNo);
				})
			})
		},
		error : console.log
	});
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>