<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래 상세보기" name="title" />
</jsp:include>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tradeView.css" />

<section id="trade-container" class="container">
	<input type="button" value="글수정"
		onclick="location.href='${pageContext.request.contextPath}/trade/tradeUpdate.do?no=${trade.tradeNo}';" />
	<input type="button" value="글삭제" id="delete"
	onclick="deleteTrade();" />	
		
		
	<table id="tbl-trade">


	

				<tr>
					<th>번호</th>
					<td>${trade.tradeNo}</td>
					<th>작성자</th>
					<td>${trade.userId}</td>
					<th>제목</th>
					<td>${trade.tradeTitle}</td>
					<th>내용</th>
					<c:if test="${not empty trade.photos}">
						<c:forEach items="${trade.photos}" var="photo">	
							<td><img src ="${pageContext.request.contextPath}/resources/upload/trade/${photo.renamedFilename}" id="upload-img"></td>
						</c:forEach>
					</c:if>
					<td>${trade.tradeContent}</td>
					<th>작성일</th>
					<td>
					<fmt:parseDate value="${trade.tradeDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="tradeDate"/>
			    		<fmt:formatDate value="${tradeDate}" pattern="yy-MM-dd HH:mm"/>
					</td>
					<th>조회수</th>
					<td>${trade.readCount}</td>
					<th>가격</th>
					<td>
					<fmt:formatNumber type="number" value="${trade.tradePrice}" />원</td>
					<th>거래현황</th>
					<td>${trade.tradeSuccess}</td>
					<th>상품상태</th>
					<td>
					${trade.tradeQuality == 'S' ? '상태좋음(S급)' : trade.tradeQuality == 'A' ? '상태 양호(A급)' : '상태 아쉬움(B급)'}
					</td>
					<th>좋아요수<th> 
					<td><input type="button" id="like-btn" name="like-btn" value="♥" onclick="goodCheck()"/>${trade.likeCount}</td>
					</tr>


	</table>
</section>
<script>
function deleteTrade(){
	if(confirm("삭제?")){
		location.href="${pageContext.request.contextPath}/trade/tradeDelete.do?no=${trade.tradeNo}";
	}else return;
}
	


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />