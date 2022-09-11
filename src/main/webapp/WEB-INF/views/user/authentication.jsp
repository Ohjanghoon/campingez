<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/popup.css" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div id="con">
    <div id="login">
    <div id="login_form"><!--로그인 폼-->
    <form>
     <h3 class="login" style="letter-spacing:-1px;">아이디 비밀번호 확인</h3>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	 <hr>
		<div>
			 <p style="text-align: left; font-size:12px; color:#666">Username</p>
			<input type="text" id="userId" name="userId" class="size"/>
			  <p style="text-align: left; font-size:12px; color:#666">Password</p>
			<input type="text" id="password" name="password" class="size"/><br>
			<br>
			<hr>
			<br>
			<button id="updateConfirm" type="button" class="btn">Sign in</button>
		</div>
	</form>
 </div>
    </div>
  </div>
</body>

<script>
document.querySelector("#updateConfirm").addEventListener('click', () =>  {
	$.ajax({
		url : "${pageContext.request.contextPath}/userInfo/authentication.do",
		method : "GET",
		data : {
			userId : document.querySelector("#userId").value,
			password : document.querySelector("#password").value
		},
		success(response){
			console.log(response.msg);
			if(response.msg == "success"){
				  window.opener.location.href= "${pageContext.request.contextPath}/userInfo/userInfo.do";
				  window.close();
			}else{
				alert("회원 인증 실패!")
			}
			/* window.close(); */
		},
		error : console.log
	});		
});
</script>

</html>
