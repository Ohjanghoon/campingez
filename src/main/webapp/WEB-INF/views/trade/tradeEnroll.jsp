<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래게시판" name="title" />
</jsp:include>

<section id="trade-container" class="container">

<form name="tradeEnrollFrm" action="${pageContext.request.contextPath}/trade/tradeEnroll.do?${_csrf.parameterName}=${_csrf.token}" method="post" 
enctype="multipart/form-data" >


<p>글제목: </p><input type="text" name="tradeTitle"><br>

<!--  <p>작성자: </p><input type="text" name="userId" value="${trade.userId}" readonly><br> -->
<p>작성자: </p><input type="text" name="userId"><br>

<p>중고물품 구분</p>
<input type="radio" name="categoryId" value="tra1" checked>텐트/타프
<input type="radio" name="categoryId" value="tra2">캠핑 테이블 가구
<input type="radio" name="categoryId" value="tra3">캠핑용 조리도구
<input type="radio" name="categoryId" value="tra4">기타 캠핑용품

<p>상품 상태</p>
<input type="radio" name="tradeQuality" value="S" checked>상태 좋음 (S급)
<input type="radio" name="tradeQuality" value="A">상태 양호 (A급)
<input type="radio" name="tradeQuality" value="B">아쉬운 상태 (B급)

<p>가격</p><input type="text" name="tradePrice" id="tradePrice"/>

<p>글내용: </p><textarea rows="5" cols="30" name="tradeContent"></textarea>

<br /><br />
<div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일1</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1" accept="image/*" multiple>
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
<br><br>
<input type="submit" value="저장">
</form>




</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />