<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<style>
  .star {
    position: relative;
    font-size: 2rem;
    color: #ddd;
  }
  
  .star input {
    width: 100%;
    height: 100%;
    position: absolute;
    left: 0;
    opacity: 0;
    cursor: pointer;
  }
  
  .star span {
    width: 0;
    position: absolute; 
    left: 0;
    color: purple;
    overflow: hidden;
    pointer-events: none;
  }
</style>
<main>
	<form:form action="${pageContext.request.contextPath}/review/insertReview.do" method="post" enctype="multipart/form-data">
		<table>
		<tr>
			<th>예약번호</th>
			<td><input value="${resNo}" name="resNo" readonly/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="15" cols="70" name="revContent"></textarea></td>
		</tr>
		<tr>
			<th>별점</th>
			<td>
				<span class="star">
				  ★★★★★
				  <span>★★★★★</span>
				  <input type="range" name = "revScore" oninput="drawStar(this)" value="1" step="1" min="0" max="5">
				</span>
			</td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td> 
				<div>
				  <div class="custom-file">
				    <input type="file" name="upFile" id="upFile1" multiple>
				    <label for="upFile1">파일을 선택하세요</label>
				  </div>
				</div>
			</td>
		</tr>
		<tr>
			<c:if test="${not empty notice.photos}">
				<c:forEach items="${notice.photos}" var="photo">	
					<td><img src ="${pageContext.request.contextPath}/resources/upload/notice/${photo.noticeRenamedFilename}" class="upload" width="100px"></td>
				</c:forEach>
			</c:if>
		</tr>
		</table>
		<button type="submit">저장</button>
	</form:form>
<script>
const drawStar = (target) => {
	var percent = target.value*20 + "%";
	console.log(target.value);
    document.querySelector(`.star span`).style.width = percent;
  }
</script>
</main>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>