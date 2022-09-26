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
					<h2 class="text-center fw-bold pt-5 pb-5">중고거래 신고 내역 - 3건 이상</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th scope="col">No</th>
								<th scope="col">게시글</th>
								<th scope="col">작성자</th>
								<th scope="col">신고자</th>
								<th scope="col">신고유형</th>
								<th scope="col">신고내역</th>
								<th scope="col">신고날짜</th>
								<th scope="col">조치</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty tradeReportList}">
								<c:forEach items="${tradeReportList}" var="trade">
									<tr>
										<td scope="row" rowspan="${fn:length(trade.reportList)}">1</td>
										<td scope="row" rowspan="${fn:length(trade.reportList)}">
											<a href="${pageContext.request.contextPath}/trade/tradeView.do?no=${trade.tradeNo}">
												${trade.tradeNo}
											</a> 
										</td>
										<td scope="row" rowspan="${fn:length(trade.reportList)}">${trade.userId}</td>
									<c:forEach items="${trade.reportList}" var="report" varStatus="vs">
										<c:if test="${vs.first}">
											<td scope="row">${report.userId}</td>
											<td scope="row">${report.categoryName}</td>
											<td scope="row">${report.reportContent}</td>
											<td scope="row">
												<fmt:parseDate value="${report.reportDate}" var="reportDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
												<fmt:formatDate value="${reportDate}" pattern="yy/MM/dd"/>
											</td>
											<td scope="row" rowspan="${fn:length(trade.reportList)}">
												<button type="button" class="report-btn report-del-btn" data-comm-no="${trade.tradeNo}" onclick="deleteComm(event);">삭제처리</button>
												<button type="button" class="report-btn" data-comm-no="${trade.tradeNo}" onclick="noProblemUpdate(event);">문제없음</button>
											</td>
										</c:if>
										<c:if test="${not vs.first}">
											<tr>
												<td scope="row">${report.userId}</td>
												<td scope="row">${report.categoryName}</td>
												<td scope="row">${report.reportContent}</td>
												<td scope="row">
													<fmt:parseDate value="${report.reportDate}" var="reportDate" pattern="yyyy-MM-dd'T'HH:mm:ss"/>
													<fmt:formatDate value="${reportDate}" pattern="yy/MM/dd"/>
												</td>
											</tr>										
										</c:if>
									</c:forEach>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty tradeReportList}">
								<tr>
									<td colspan="8">조회된 신고 내역이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<nav class="pagebar">
						${tradePagebar}
					</nav>
					
					<h2 class="text-center fw-bold pt-5 pb-5">중고거래 신고 내역 - 회원 별 누적 신고</h2>
					<table class="table text-center">
						<thead>
							<tr>
								<th>회원아이디</th>
								<th>누적신고수</th>
								<th>블랙리스트여부</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${not empty userReportTotal}">
								<c:forEach items="${userReportTotal}" var="report">
									<tr>
										<td>${report.commUserId}</td>
										<td>${report.totalReport}회</td>
										<td>${report.isBlacklist == null ? '<i class="fa-solid fa-x"></i>' : '<i class="fa-solid fa-o"></i>'}</td>
										<td>
											<button type="button" class="report-btn" onclick="location.href='${pageContext.request.contextPath}/admin/blackList.do'">경고하러가기</button>
										</td>
									</tr>
								</c:forEach>
							</c:if>
							<c:if test="${empty userReportTotal}">
								<tr>
									<td colspan="3">조회된 신고 내역이 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<form:form name="updateFrm" method="POST">
						<input type="hidden" name="commNo" />
						<input type="hidden" name="type" />
					</form:form>
					<nav id="tradePagebar">
						${tradePagebar}
					</nav>
				</div>
			</div>
	</section>
</main>

<script>
const noProblemUpdate = (e) => {	
	const commNo = e.target.dataset.commNo;
	
	if(confirm(`[\${commNo}] 게시글에 대해 '문제없음' 조치를 취하시겠습니까?`)) {
		document.updateFrm.commNo.value = commNo;
		document.updateFrm.action = "${pageContext.request.contextPath}/admin/updateReportAction.do";
		document.updateFrm.submit();
	}
}

const deleteComm = (e) => {	
	const commNo = e.target.dataset.commNo;

	if(confirm(`[\${commNo}] 게시글에 대해 '삭제' 조치를 취하시겠습니까?`)) {
		document.updateFrm.commNo.value = commNo;
		document.updateFrm.type.value = "T";
		document.updateFrm.action = "${pageContext.request.contextPath}/admin/updateReportActionAndIsDelete.do";
		document.updateFrm.submit();
	} 
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>