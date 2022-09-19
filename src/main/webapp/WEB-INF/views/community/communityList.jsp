<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="커뮤니티게시판" name="title" />
</jsp:include>

<section id="community-container" class="container">
	<input type="button" value="글쓰기"
		onclick="location.href='${pageContext.request.contextPath}/community/communityEnroll.do?'" />
		<c:if test="${empty list}">
			<p>등록된게시글이 없습니다.</p>
		</c:if>
		
	


	<table id="tbl-trade">
		<c:if test="${not empty list}">
			<c:forEach items="${list}" var="comm">
				<thead>
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th colspan="3">제목</th>
					<th colspan="5">작성일</th>
					<th colspan="3">조회수</th>
					<th colspan="3">신고수</th>
					<th colspan="3">삭제여부</th>
					<th colspan="3">좋아요수</th>
					</tr>
				</thead>
				
				<tbody>
				<tr>
					<td>${comm.commNo}</td>
					<td>${comm.userId}</td>
					<td colspan="3"><input type="button" name="commTitle" id="commTitle" value="${comm.commTitle}"
						onclick="location.href='${pageContext.request.contextPath}/community/communityView.do?no=${comm.commNo}'"/></td>
					<td colspan="5">
						
						<fmt:parseDate value="${comm.commDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="commDate"/>
			    		<fmt:formatDate value="${commDate}" pattern="yy-MM-dd HH:mm"/>
			    		</td>
					<td colspan="3">${comm.readCount}</td>
					<td colspan="3">${comm.reportCount}</td>
					<td colspan="3">${comm.isDelete}</td>
					<td colspan="3">${comm.likeCount}</td>
				</tr>
				</tbody>
				

			</c:forEach>
		</c:if>
	</table>
	
	<nav>
 		 ${pagebar}
 		 
	</nav>
	
</section>
<script>


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />