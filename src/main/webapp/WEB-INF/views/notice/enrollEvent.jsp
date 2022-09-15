<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<main>
	<div class="container">
	<h1>notice event</h1>
		<form name="noticeEnrollFrm" action="${pageContext.request.contextPath}/notice/enrollNotice.do"
			method="post" enctype="multipart/form-data">
			<sec:csrfInput/>
			<input type="hidden" name="noticeType" value="이벤트"/>
			<input type="hidden" name="noticeContent" value="" />
			<label for="noticeTitle">공지제목</label>
			<input type="text" name="noticeTitle" value=""><br><br />
			<label for="categoryId">카테고리</label>
			<select name="categoryId" id="categoryId">
				<option value="not2">이벤트</option>
			</select><br /><br />
			<label for="couponList">쿠폰</label>
			<select name="couponList" id="couponList">
				<option value="" disabled selected>선택하세요.</option>
			</select><br /><br />
			<label for="">첨부파일1</label>
			<input type="file" name="upFile" id="upFile1" multiple><br /><br />
			<label for="">첨부파일2</label>
			<input type="file" name="upFile" id="upFile2" multiple><br /><br />
			<button>등록</button>
		</form>
		</div>
</main>
	<script>

		const headers = {};
        headers['${_csrf.headerName}'] = '${_csrf.token}';
		
        $.ajax({
			url : "${pageContext.request.contextPath}/coupon/couponlist.do",
			headers,
			method : "POST",
			success(response){
				console.log(response);
				if(response.length){
					response.forEach((couponList) => {
						const {couponCode, couponName, couponDiscount, couponStartday, couponEndday} = couponList;
						const option = `<option value="\${couponCode}">[\${couponDiscount}%]\${couponName} - (\${couponStartday}~\${couponEndday})</option>`;
						document.querySelector("#couponList").innerHTML += option;
					});
				};
			},
			error : console.log
		});

		
		document.querySelector("[name=couponList]").addEventListener('change', (e) => {
			document.querySelector("[name=noticeContent]").value = e.target.value;
		});
		
		document.querySelectorAll("[name=upFile]").forEach((input) => {
			input.addEventListener("change", (e) => {
				const {files} = e.target;
				const label = e.target.nextElementSibling;
				if(files[0]){
					label.textContent = files[0].name;
				}
				else{
					label.textContent = "파일을 선택하세요.";
				}
			});
		});
		
	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>