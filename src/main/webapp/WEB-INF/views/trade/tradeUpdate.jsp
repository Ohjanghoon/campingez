<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<sec:authentication property="principal" var="loginMember" scope="page" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래게시판" name="title" />
</jsp:include>
<script src="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/summernote.js"></script>
<script src="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/summernote-0.8.18-dist/summernote.css">
<style>
.trade-header > * {
    margin: 30px 0;
    border-bottom: 1px solid gray;
    padding-bottom: 20px;
}
.spec-wrap{
	width: 49%;
}
.title-wrap {
	width:70%;
}
.price-wrap {
	width: 20%;
}
.title-wrap {
	margin-top: 10px;
}
#title {
	width:79%;
}
.info-wrap {
    height: 150px;
    border: 1px solid lightgray;
    background-color: #d3d3d347;
    margin-bottom: 10px;
    color: gray;
    padding: 20px;
    font-size: 14px;
}
.title-price-wrap {
	margin: 10px 0 10px 0;
}
.trade-font-color {
	color: gray;
}
</style>
<section id="trade-container" class="container">
	<sec:authentication property="principal.username" var="loginUser"/>
	<div class="trade-header">
		<h2>게시글 수정</h2>
	</div>
	<form name="tradeUpdateFrm" action="${pageContext.request.contextPath}/trade/tradeUpdate.do?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data" >
		<input type="hidden" name="tradeNo" value="${trade.tradeNo}" />
		<div class="trade-select-wrap d-flex justify-content-between">
			<div class="form-floating spec-wrap">
			  <select class="form-select" id="category" name="categoryId">
			    <option value="tra1" ${trade.categoryId == 'tra1' ? 'selected' : ''}>텐트/타프</option>
			    <option value="tra2" ${trade.categoryId == 'tra2' ? 'selected' : ''}>캠핑 테이블 가구</option>
			    <option value="tra3" ${trade.categoryId == 'tra3' ? 'selected' : ''}>캠핑용 조리도구</option>
			    <option value="tra4" ${trade.categoryId == 'tra4' ? 'selected' : ''}>기타 캠핑용품</option>
			  </select>
			  <label for="category">중고물품 구분</label>
			</div>
			<div class="form-floating spec-wrap">
			  <select class="form-select" id="tradeQuality" name="tradeQuality">
			    <option value="" disabled>선택(필수)</option>
			    <option value="S" ${trade.tradeQuality == 'S' ? 'selected' : ''}>상태 좋음 (S급)</option>
			    <option value="A" ${trade.tradeQuality == 'A' ? 'selected' : ''}>상태 양호 (A급)</option>
			    <option value="B" ${trade.tradeQuality == 'B' ? 'selected' : ''}>아쉬운 상태 (B급)</option>
			  </select>
			  <label for="category">상품 상태</label>
			</div>	
		</div>
		<div class="form-floating d-flex justify-content-between align-items-center title-price-wrap">
	  		<input type="text" class="form-control" id="title" placeholder="게시글 제목" name="tradeTitle" value="${trade.tradeTitle}" required>
	  		<label for="title" class="trade-font-color">게시글 제목</label>
 			<div class="form-floating price-wrap">
			  <input type="text" class="form-control" id="price" placeholder="\ 판매가격" name="tradePrice" value="<fmt:formatNumber value="${trade.tradePrice}" pattern="#,###"/>" required> 
			  <label for="price" class="trade-font-color">\ 판매가격</label>
			</div>	
		</div>	
		<div class="info-wrap">
			중고물품 거래를 위한 게시판입니다. 일반 게시판 이용은 자유게시판을 이용해주세요.
			<br/><br/>
			사기/스팸홍보/도배/욕설/생명경시/혐오/차별적 표현/음란물/금전 요구 등 게시판 유형에 올바르지 않은 게시글 등록 시 임의 삭제 처리 됩니다.
			<br/><br/>
			건전한 게시판 문화를 위해 노력해주세요.🙂	
		</div>
		<textarea id="summernote" name="tradeContent" required>${trade.tradeContent}</textarea>
		<c:forEach items="${trade.photos}" var="photo" varStatus="vs">
			<div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
			  <input type="checkbox" class="btn-check" id="delFile${vs.count}" name="delFile" value="${photo.tradePhotoNo}">
				<label for="delFile${vs.count}" class="btn btn-outline-danger btn-block" style="overflow: hidden" title="">첨부파일삭제 - ${photo.originalFilename}</label>
			</div>
		</c:forEach>
		<div class="mb-3">
		  <input class="form-control" type="file" id="upFile" accept="image/*" name="upFile" multiple>
		</div>
		<div class="btn-wrap d-flex justify-content-center">
			<button type="button" class="btn btn-primary" id="enroll-btn">수정</button>
		</div>		
</form>
<script>
$(document).ready(function() {
	$('#summernote').summernote({
		  height: 500,                 
		  minHeight: null,             
		  maxHeight: null,             
		  focus: true,                  
		  lang: "ko-KR",					
		  placeholder: '중고거래 게시판에 올릴 게시글 내용을 작성해주세요.'
          
	});
});

document.querySelector("#price").addEventListener('keyup', (e) => {
 	let value = e.target.value;
	value = Number(value.replaceAll(",", ''));
	if(isNaN(value)) {
		e.target.value = 0;
	} else {
		const formatVal = value.toLocaleString('ko-KR');
		e.target.value = formatVal; 
	}
});

document.querySelector("#enroll-btn").addEventListener('click', (e) => {
	const upFile = document.querySelector("#upFile");
	const tradeQuality = document.querySelector("#tradeQuality");
	const content = document.querySelector("#summernote");
	const title = document.querySelector("#title");
	let price = document.querySelector("#price");
	const delFileTotal = $("input[name=delFile]").length
	const delFileChecked = $("input[name=delFile]:checked").length;

	if(upFile.files.length < 1 && (delFileTotal == delFileChecked)) {
		alert("반드시 하나 이상의 사진을 등록해주세요.");
		upFile.focus();
		return;
	} else if(!tradeQuality.value) {
		alert("상품 상태를 반드시 선택해주세요.");
		tradeQuality.focus();
		return;
	} else if(!content.value) {
		alert("반드시 게시글 내용을 입력해주세요.");
		content.focus();
		return;
	} else if(!title.value) {
		alert("반드시 게시글 제목을 입력해주세요.");
		title.focus();
		return;
	} else if(!price.value || price.value == 0) {
		alert("반드시 물품 가격을 입력해주세요.");
		price.focus();
		return;
	}
	price.value = Number(price.value.replaceAll(',',''));
	document.tradeUpdateFrm.submit();
});
</script>


</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />