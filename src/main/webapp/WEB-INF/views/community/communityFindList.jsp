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

<sec:authentication property="principal" var="loginMember" scope="page" />


<header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder" style="cursor:pointer;">자유게시판</h1>
                    <p class="lead fw-normal text-white-50 mb-0">당신의 글을 작성하세요!</p>
                </div>
            </div>
        </header>


<div class="panel">
			<div class="form-inline" style="display:flex; justify-content : center; margin:50px;">
			<br />
				<input class="btn btn-outline-dark mt-auto" id="freeBoard" onclick="location.href='${pageContext.request.contextPath}/community/communityList.do'" type="button" value="게시판으로" style="margin-right:30px;"/>
			</div>
		</div>	

<div style="text-align: center;">
	<span>
		<c:if test="${categoryType eq 'com1'}" >자유게시판</c:if>
		<c:if test="${categoryType eq 'com2'}" >꿀팁게시판</c:if>
		 : "${searchKeyword}"
		(<c:if test="${searchType eq 'comm_title'}">제목</c:if><c:if test="${searchType eq 'comm_content'}">내용</c:if>)에 대한 검색 결과입니다.
	</span>
</div>

<div id="free">
<section id="community-container" class="container">
      <c:if test="${empty list}">
         <p>등록된게시글이 없습니다.</p>
      </c:if>

   <table class="table table-hover" style="margin-top:30px;">
	<thead>
    <tr>
      <th scope="col"></th>
      <th scope="col" colspan="10">제목</th>
      <th scope="col">작성자</th>
      <th scope="col">조회수</th>
      <th scope="col">신고수</th>
      <th scope="col">좋아요</th>
      <th scope="col">작성일</th>

    </tr>
  </thead>
	  <tbody>
     <c:if test="${not empty list}">
         <c:forEach items="${list}" var="comm">
         <div id="contentArea">
	    <tr onclick="location.href='${pageContext.request.contextPath}/community/communityView.do?no=${comm.commNo}';" style="cursor:pointer;">
	      <th scope="row">${comm.commNo}</th>
	      <td colspan="10" style="width:40%;">${comm.commTitle}</td>
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
      </c:if>
	  </tbody>
</table>
      <sec:authorize access="isAuthenticated()"> 
   		<input type="button" value="글쓰기"  class="btn btn-outline-dark flex-shrink-0"
     	 onclick="location.href='${pageContext.request.contextPath}/community/communityEnroll.do?'" />
      </sec:authorize>
      
   <div style="text-align:center;">
        ${pagebar}
        
   </div>
   <div id="search-container">
		<div id="select">
			<form action="${pageContext.request.contextPath}/community/communityFind.do" method="get">
				<select id='selCategory' name="categoryType">
					<option value='com1'>자유게시판</option>
					<option value='com2'>꿀팁게시판</option>
				</select>
				<select id='selSearchOption' name="searchType">
					<option value='comm_title'>제목</option>
					<option value='comm_content'>내용</option>
				</select>
				<input type="text" name="searchKeyword"/>
				<input type="submit" value="검색" />
			</form>
		</div>
	</div>
</section>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />