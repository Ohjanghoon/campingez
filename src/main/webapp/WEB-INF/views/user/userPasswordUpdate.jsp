<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/userPwdUpdate.css" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title" />
</jsp:include>
<style>
    sup{color: red;}
  </style>
<br /><br />
<h1>비밀번호 변경</h1><br /><br />

<h6><span id="msgPassword" class="msg">비밀번호는 영문자+숫자+특수문자(!@#$%^&*) 포함 8글자이상</span></h6><br /><br />
<div id="enroll-container">
	<form:form name="userEnrollFrm" action="" method="POST">
		<table class="mx-auto">
			<tr>
				<th>&nbsp;</th>
				<td>
					<div class="group">      
			          <input type="password" required name="newPassword" id="newPassword" oninput="passwordCK()">
			          <span class="highlight"></span>
			          <span class="bar"></span>
			          <label>새비밀번호 </label>
			        </div>
				</td>
				<td>
		            <div>
		              <span id="msgPassword" class="msg"></span>
		            </div>
	          	</td>
			</tr>
			<tr>
				
			</tr>
			<tr>
				<th>&nbsp;</th>
				<td>
				<div class="group">      
		          <input type="password" required name="newPasswordCheck" id="newPasswordCheck">
		          <span class="highlight"></span>
		          <span class="bar"></span>
		          <label>새비밀번호 확인</label>
		        </div>
				</td>
			</tr>
			<tr>
				<th>&nbsp;</th>
				<td>
					<input type="hidden" name="_userId" id="_userId" value="${userId}" />
					<input class="btn btn-outline-secondary" type="button" value="비밀번호변경하기" onclick="passwordUpdate()">
				</td>
			</tr>
		</table>
	</form:form>
</div>
<script>
	function passwordUpdate() {
		const newPassword = document.querySelector("#newPassword").value;
		const newPasswordCheck = document.querySelector("#newPasswordCheck").value;
		console.log(newPassword, newPasswordCheck);
		
		if(newPassword != newPasswordCheck){
			alert('비밀번호가 일치하지 않습니다.');
			return false;
		}
		else{
			document.userEnrollFrm.submit();
		}
	};
	
	function passwordCK(){
		const newPassword = document.querySelector("#newPassword").value;
		var reg =  /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
		
		if (!reg.test(newPassword)) {
			document.querySelector('#msgPassword').style.color = 'red';
			document.querySelector('#msgPassword').innerHTML = '사용 불가능';
		} 
		else {
			document.querySelector('#msgPassword').style.color = 'blue';
			document.querySelector('#msgPassword').innerHTML = '사용 가능';
		}
	};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>