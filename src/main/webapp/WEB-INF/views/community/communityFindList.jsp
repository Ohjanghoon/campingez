<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="커뮤니티게시판" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/community.css" />
<sec:authentication property="principal" var="loginMember" scope="page" />

<div class="panel">
			<div class="form-inline" style="display:flex; justify-content : center; margin:50px;">
			<br />
				<input class="btn btn-outline-dark mt-auto" id="freeBoard" onclick="location.href='${pageContext.request.contextPath}/community/communityListFree.do'" type="button" value="게시판으로" style="margin-right:30px;"/>
			</div>
		</div>	

<div style="text-align: center;">
	<span>
		<c:if test="${categoryType eq 'com1'}" >
			<span class="strong">자유게시판</span>
		</c:if>
		<c:if test="${categoryType eq 'com2'}" >
			<span class="strong">꿀팁게시판</span>
		</c:if>
		 : "${searchKeyword}"
		(<c:if test="${searchType eq 'comm_title'}">제목</c:if><c:if test="${searchType eq 'comm_content'}">내용</c:if>)에 대한 검색 결과입니다.
	</span>
</div>

<div id="free">
<section id="community-container" class="container">
      <c:if test="${empty list}">
         <table class="table search-list-tbl">
         	<thead>
				 <tr>
				      <th scope="col">분류</th>
				      <th scope="col" colspan="10" class="title">제목</th>
				      <th scope="col">작성자</th>
				      <th scope="col">조회수</th>
				      <th scope="col">신고수</th>
				      <th scope="col">좋아요</th>
				      <th scope="col">작성일</th>
			    </tr>
         	</thead>
         	<tbody>
         		<tr>
         			<td colspan="17" scope="row" class="not-list">등록된 게시글이 없습니다.</td>
         		</tr>
         	</tbody>
         </table>
      </c:if>
      <c:if test="${not empty list}">
		   <table class="table table-hover search-list-tbl" style="margin-top:30px;">
			<thead>
		    <tr>
		      <th scope="col">분류</th>
		      <th scope="col" colspan="10" class="title">제목</th>
		      <th scope="col">작성자</th>
		      <th scope="col">조회수</th>
		      <th scope="col">신고수</th>
		      <th scope="col">좋아요</th>
		      <th scope="col">작성일</th>
		    </tr>
		  </thead>
			  <tbody>
		         <c:forEach items="${list}" var="comm">
		         <div id="contentArea">
			    <tr onclick="location.href='${pageContext.request.contextPath}/community/communityView.do?no=${comm.commNo}';" style="cursor:pointer;">
			      <td scope="row">
			      	<span class="badge category-name-badge ${param.categoryType == 'com1' ? 'free-badge' : 'honey-badge'}">${comm.categoryName}</span>
			      </td>
			      <td colspan="10" style="width:40%;" class="title">${comm.commTitle}</td>
			      <td>${comm.userId}</td>
			      <td style="width:7%;"><img src="${pageContext.request.contextPath}/resources/images/eye.png" style="width:30px;heigh:30px;" />
			      ${comm.readCount}</td>
			      <td style="width:7%;"><img src="${pageContext.request.contextPath}/resources/images/siren.png" style="width:15px;heigh:15px;" />
			      ${comm.reportCount}</td>
			      <td style="width:7%;"><img id="heart" src="${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png" style="width:15px; heigh:15px;" />
			      ${comm.likeCount}</td>
			      <td><fmt:parseDate value="${comm.commDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="commDate"/>
			          <fmt:formatDate value="${commDate}" pattern="yy-MM-dd HH:mm"/></td>
				</tr>
		         </div>
		         </c:forEach>
			  </tbody>
		</table>
      </c:if>
      <sec:authorize access="isAuthenticated()"> 
   		<input type="button" value="글쓰기"  class="btn btn-outline-dark flex-shrink-0"
     	 onclick="location.href='${pageContext.request.contextPath}/community/communityEnroll.do?'" />
      </sec:authorize>
      
	<c:if test="${not empty list}">
	   <nav style="text-align:center;">
	        ${pagebar}
	   </nav>
	</c:if>
   <div id="search-container">
		<form action="${pageContext.request.contextPath}/community/communityFind.do" method="get">
			<div id="select">
				<div class="selCategory-wrap">
					<select class="form-select selCategory" id='selCategory' name="categoryType">
						<option value='com1' ${param.categoryType == 'com1' ? 'selected' : ''}>자유게시판</option>
						<option value='com2' ${param.categoryType == 'com2' ? 'selected' : ''}>꿀팁게시판</option>
					</select>
				</div>
				<div class="selSearchOption-wrap">
					<select class="form-select selSearchOption" id='selSearchOption' name="searchType">
						<option value='comm_title' ${param.searchType == 'comm_title' ? 'selected' : ''}>제목</option>
						<option value='comm_content' ${param.searchType == 'comm_content' ? 'selected' : ''}>내용</option>
					</select>
				</div>
				<div class="searchKeyword-wrap">
					<input type="text" class="form-control searchKeyword" name="searchKeyword" value="${param.searchKeyword}"/>
				</div>
				<div class="btn-wrap">
					<button type="submit" class="btn btn-outline-primary" id="search-btn">검색</button>
				</div>
			</div>
		</form>
	</div>
</section>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />