<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래게시판" name="title" />
</jsp:include>

<section id="trade-container" class="container">
	<input type="button" value="글쓰기"
		onclick="location.href='${pageContext.request.contextPath}/trade/tradeEnroll.do?'" />
		<c:if test="${empty list}">
			<p>등록된게시글이 없습니다.</p>
		</c:if>
		
	
		<select onchange="if(this.value) location.href=(this.value);">
			<option value="" selected disabled>정렬기준</option>
			<option value="${pageContext.request.contextPath}/trade/tradeList.do">최신글 (기본)</option>
			<option value="${pageContext.request.contextPath}/trade/tradeListLowPrice.do">낮은 금액순</option>
			<option value="highPrice">높은 금액순</option>
		</select>



	<table id="tbl-trade">
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="trade">
				<thead>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th colspan="3">제목</th>
					<th colspan="8">내용</th>
					<th colspan="3">작성일</th>
					<th>조회수</th>
					<th>가격</th>
					<th>거래현황</th>
					<th>상품상태</th>
					<th>좋아요수</th>
					</tr>
				</thead>
				
				<tbody>
				<tr>
					<td>${trade.tradeNo}</td>
					<td>${trade.userId}</td>
					<td colspan="3"><input type="button" name="tradeTitle" id="tradeTitle" value="${trade.tradeTitle}"
						onclick="location.href='${pageContext.request.contextPath}/trade/tradeView.do?no=${trade.tradeNo}'"/></td>
					<td colspan="8">${trade.tradeContent}</td>
					<td colspan="3">
						
						<fmt:parseDate value="${trade.tradeDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="tradeDate"/>
			    		<fmt:formatDate value="${tradeDate}" pattern="yy-MM-dd HH:mm"/>
			    		</td>
					<td>${trade.readCount}</td>
					<td><fmt:formatNumber type="number" value="${trade.tradePrice}" />원</td>
					<td>${trade.tradeSuccess}</td>
					<td>${trade.tradeQuality}</td>
					<td>${trade.likeCount}</td>
				</tr>
				</tbody>

			</c:forEach>
		</c:if>
	</table>
</section>
<script>



</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />