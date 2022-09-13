<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래게시판" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/trade/tradeList.css" />
<sec:authentication property="principal" var="loginMember" scope="page" />

<!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">중고거래</h1>
                    <p class="lead fw-normal text-white-50 mb-0">여러분의 물건을 자유롭게 거래하세요!</p>
                    
                </div>
            </div>
        </header>

        <c:if test="${empty list}">
			<p>등록된게시글이 없습니다.</p>
		</c:if>
		
		<sec:authorize access="isAuthenticated()">
			<input type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/trade/tradeEnroll.do?'" />
		</sec:authorize>


        <!-- Section-->
                <section class="py-5">
                    <div class="container px-4 px-lg-5 mt-5">
                        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

        				<c:if test="${not empty list}">
          				  <c:forEach items="${list}" var="trade">
                            <div class="col mb-5">
                                <div class="card h-100">
                                    <!-- Sale badge-->
                                    <c:if test="${trade.tradeSuccess eq '거래 대기중'}">
                                    <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                                    </c:if>
                                    <c:if test="${trade.tradeSuccess eq '거래완료'}">
                                    <div class="badge bg-success text-white position-absolute" style="top: 0.5rem; right: 0.5rem">complete</div>
                                    </c:if>
                                    
                                    <!-- Product image-->
                                    <c:forEach items="${trade.photos}" var="photo">
                                    <img class="card-img-top" src="${pageContext.request.contextPath}/resources/upload/trade/${photo.renamedFilename}" id="thumnail" style="width:100%; height:100%;"/>
                                    </c:forEach>
                                    <!-- Product details-->
                                    <div class="card-body p-4">
                                        <div class="text-center">
                                            <!-- Product name-->
                                            <h5 class="fw-bolder">${trade.tradeTitle}</h5>
                                            <!-- Product price-->
                                            <fmt:formatNumber type="number" value="${trade.tradePrice}" />원
                                        </div>
                                    </div>
                                    <!-- Product actions-->
                                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                        <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="${pageContext.request.contextPath}/trade/tradeView.do?no=${trade.tradeNo}">상품 자세히 보기</a></div>
                                    </div>
                                </div>
                            </div>
                            
          				  </c:forEach>
    				     </c:if>
                        </div>
                    </div>
                </section>
                        <div style="text-align:center;">${pagebar}</div>
                        

<jsp:include page="/WEB-INF/views/common/footer.jsp" />