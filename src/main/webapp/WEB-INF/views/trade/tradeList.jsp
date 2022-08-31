<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>trade</title>
</head>
<body>
	
	<section id="trade-container" class="container">
		<input type="button" value="글쓰기" />
		<table id="tbl-trade">
		<c:if test="${empty list}">
			<p>등록된게시글이 없습니다.</p>
		</c:if>
		
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="trade">

					<tr>
						<th>작성자</th>
							<td>
								<input type="text" name="userId" id="userId" value="${trade.userId}" />
							</td>
						<th>제목</th>
							<td>
								<input type="text" name="tradeTitle" id="tradeTitle" value="${trade.tradeTitle}" />
							</td>
						<th>내용</th>
							<td>
								<input type="text" name="tradeContent" id="tradeContent" value="${trade.trandContent}" />
							</td>
						<th>작성일</th>
							<td>
								<input type="text" name="tradeDate" id="tradeDate" value="${trade.tradeDate}" />
							</td>
						<th>조회수</th>
							<td>
								<input type="text" name="readCount" id="readCount" value="${trade.readCount}" />
							</td>
						<th>가격</th>
							<td>
								<input type="text" name="price" id="price" value="${trade.price}" />
							</td>
						<th>거래현황</th>
							<td>
								<input type="text" name="tradeSuccess" id="tradeSuccess" value="${trade.tradeSuccess}" />
							</td>
						<th>상품상태</th>
							<td>
								<input type="text" name="tradeQuality" id="tradeQuality" value="${trade.tradeQuality}" />
							</td>
						<th>좋아요수</th>
							<td>
								<input type="text" name="likeCount" id="likeCount" value="${trade.likeCount}" />
							</td>
					</tr>

			</c:forEach>
		</c:if>
		</table>
	</section>
</body>
</html>