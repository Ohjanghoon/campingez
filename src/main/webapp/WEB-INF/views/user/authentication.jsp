<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/popup.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="con">
		<div id="login">
			<div id="login_form">
				<!--로그인 폼-->
				<form>
					<h3 class="login" style="letter-spacing: -1px;">아이디 비밀번호 확인</h3>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<hr>
					<div>
						<p style="text-align: left; font-size: 12px; color: #666">Username</p>
						<input type="text" id="userId" name="userId" class="size" />
						<p style="text-align: left; font-size: 12px; color: #666">Password</p>
						<input type="text" id="password" name="password" class="size" /><br>
						<br>
						
						<div style="overflow: hidden">
							<div>
								<img title="캡차이미지" src="/captchaImg.do" alt="캡차이미지" />
								<div id="ccaudio" style="display: none"></div>
							</div>
						</div>
						<div style="padding: 3px">
							<input id="reload" type="button" onclick="javaScript:getImage()" class="btn btn-outline-dark" value="새로고침" /> 
							<input id="soundOn" type="button" onclick="javaScript:audio()" class="btn btn-outline-dark" value="음성듣기" />
						</div>
						<div style="padding: 3px">
							<input id="answer" type="text" value="">
						</div>
						
						<hr>
						<br>
						<button id="updateConfirm" type="button" class="btn btn-outline-dark">Sign in</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>

<script>
function confirmUpdate(){
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
				getImage();
				document.querySelector('#answer').value = "";
				alert("회원 인증 실패!")
			}
			/* window.close(); */
		},
		error : console.log
	});		
}
//캡차 script
window.onload = function(){
	getImage();	// 이미지 가져오기
	
	document.querySelector("#updateConfirm").addEventListener('click', function(){
		var params = {answer : document.querySelector('#answer').value};
		const headers = {};
		headers['${_csrf.headerName}'] = '${_csrf.token}';
		$.ajax({
			headers,
			url : '${pageContext.request.contextPath}/userInfo/chkAnswer.do',
			method : "POST",
			data : params,
			success(returnData){
				if(returnData == 200){
					confirmUpdate();
					// 성공 코드
				}else{
					alert('입력값이 일치하지 않습니다.');
					getImage();
					document.querySelector('#answer').value = "";
				}
			},
			error : console.log
		});
	}); 
}
/*매번 랜덤값을 파라미터로 전달하는 이유 : IE의 경우 매번 다른 임의 값을 전달하지 않으면 '새로고침' 클릭해도 정상 호출되지 않아 이미지가 변경되지 않는 문제가 발생된다*/
function audio(){
	var rand = Math.random();
	var uAgent = navigator.userAgent;
	var soundUrl = '${pageContext.request.contextPath}/userInfo/captchaAudio.do?rand='+rand;
	if(uAgent.indexOf('Trident')>-1 || uAgent.indexOf('MISE')>-1){	/*IE 경우 */
		audioPlayer(soundUrl);
	}else if(!!document.createElement('audio').canPlayType){ /*Chrome 경우 */
		try {
			new Audio(soundUrl).play();
		} catch (e) {
			audioPlayer(soundUrl);
		}
	}else{
		window.open(soundUrl,'','width=1,height=1');
	}
}
function getImage(){
	var rand = Math.random();
	var url = '${pageContext.request.contextPath}/userInfo/captchaImg.do?rand='+rand;
	document.querySelector('img').setAttribute('src', url);
}
function audioPlayer(objUrl){
	document.querySelector('#ccaudio').innerHTML = '<bgsoun src="' +objUrl +'">';
}

</script>

</html>
