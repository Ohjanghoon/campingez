<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래게시판" name="title" />
</jsp:include>

<section id="trade-container" class="container">
	<input type="button" value="글쓰기"
		onclick="location.href='${pageContext.request.contextPath}/trade/tradeEnroll.do';" />
	<table id="tbl-trade">
		<c:if test="${empty list}">
			<p>등록된게시글이 없습니다.</p>
		</c:if>

		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="trade">
				<thead>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>가격</th>
					<th>거래현황</th>
					<th>상품상태</th>
					<th>좋아요수</th>
					</tr>
				</thead>
				
				<tbody>
				<tr>
					<td><input type="text" name="tradeNo" id="tradeNo"
						value="${trade.tradeNo}" /></td>
					<td><input type="text" name="userId" id="userId"
						value="${trade.userId}" /></td>
					<td><input type="button" name="tradeTitle" id="tradeTitle" value="${trade.tradeTitle}"
						onclick="location.href='${pageContext.request.contextPath}/trade/tradeView.do?no=${trade.tradeNo}'"/></td>
					<td><input type="text" name="tradeContent" id="tradeContent"
						value="${trade.tradeContent}" /></td>
					<td><input type="text" name="tradeDate" id="tradeDate"
						value="${trade.tradeDate}" /></td>
					<td><input type="text" name="readCount" id="readCount"
						value="${trade.readCount}" /></td>
					<td><input type="text" name="price" id="price"
						value="${trade.price}" /></td>
					<td><input type="text" name="tradeSuccess" id="tradeSuccess"
						value="${trade.tradeSuccess}" /></td>
					<td><input type="text" name="tradeQuality" id="tradeQuality"
						value="${trade.tradeQuality}" /></td>
					<td><input type="text" name="likeCount" id="likeCount"
						value="${trade.likeCount}" /></td>
				</tr>
				</tbody>

			</c:forEach>
		</c:if>
	</table>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />