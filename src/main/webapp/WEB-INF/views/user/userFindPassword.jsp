<%@page import="com.kh.campingez.inquire.model.dto.Answer"%>
<%@page import="com.kh.campingez.inquire.model.dto.Inquire"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userPwdUpdate.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<br /><br />
<h1>개인정보조회</h1><br /><br />
<div class="pwFind">
         <form name="pwFindFrm">
             <table class="mx-auto">
				<tr>
					<th>&nbsp;</th>
					<td>
					<div class="group">      
			          <input type="text" required name="userId" id="userId" value="sinsa">
			          <span class="highlight"></span>
			          <span class="bar"></span>
			          <label>Id</label>
			        </div>
						<!-- <input type="text" name="userId" id="userId" placeholder="아이디를 입력하세요" required value="sinsa"/> -->
					</td>
				</tr>
				<tr>
					<th>&nbsp;</th>
					<td>
						<div class="group">      
				          <input type="text" required name="phone" id="phone" value="01098989898">
				          <span class="highlight"></span>
				          <span class="bar"></span>
				          <label>Phone</label>
				        </div>
						<!-- <input type="text" name="phone" id="phone" placeholder="휴대폰번호 (- 제외)" required maxlength="13" value="01098989898"/> -->
					</td>
				</tr>
				<tr>
					<th>&nbsp;</th>
					<td>
						<div class="group">      
				          <input type="text" required name="email" id="email" value="honggd@gmail.com">
				          <span class="highlight"></span>
				          <span class="bar"></span>
				          <label>Email</label>
				        </div>
						<!-- <input type="email" placeholder="abc@xyz.com" name="email" id="email" value="honggd@gmail.com"> -->
					</td>
				</tr>
				<tr>
					<th>&nbsp;</th>
					<td>
						<input class="btn btn-outline-secondary" type="button" value="비밀번호변경하기" onclick="findPassword()">
					</td>
				</tr>
			</table>
			<div>
				<span id="findIdResult"></span>
			</div>
         </form>
		<form id="passwordUpdateFrm" 
		action="${pageContext.request.contextPath}/user/userPasswordUpdate.do"
		method="get">
			<input type="hidden" name="userId" id="updateUserId" value=""/>
		</form>
    </div>
    
<script>	
function findPassword(){
	const userId = document.querySelector('#userId').value;
	const phone = document.querySelector('#phone').value;
	const email = document.querySelector('#email').value;
	
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	
	$.ajax({
		headers,
		url : `${pageContext.request.contextPath}/user/userFindPassword.do`,
		async: false,
		method : "POST",
		data : {
			userId, phone, email
		},
		success(user){
			//console.log(user);
			if(user == 0){
				//document.querySelector('#findIdResult').innerHTML = '잘못된 회원정보입니다.';
				alert('잘못된 회원정보입니다.');
				return false;
			}
			else{
				//console.log(user.userId);
				document.querySelector('#updateUserId').value = user.userId;
				document.querySelector('#passwordUpdateFrm').submit();
			}
		},
		error : console.log
	});
}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>