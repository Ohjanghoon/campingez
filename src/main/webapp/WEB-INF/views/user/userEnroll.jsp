<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원가입" name="title" />
</jsp:include>
<style>
.correct{
    color : blue;
}
.incorrect{
    color : red;
}
</style>
<div id="enroll-container" class="mx-auto text-center">
	<form:form name="userEnrollFrm" action="" method="POST">
		<table class="mx-auto">
			<tr>
				<th>아이디</th>
				<td>
					<div id="userId-container">
						<input type="text" class="form-control" placeholder="아이디(4글자이상)"
							name="userId" id="userId" required oninput="checkId()">
					</div>
				</td>
				<td>
					<div>
						<span id="msguserId" class="msg"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" class="form-control" name="userName"
					id="userName" value="신사임당" required></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" class="form-control" name="password"
					id="password" value="" required oninput="passwordCK()"></td>
				<td>
					<div>
						<span id="msgPassword" class="msg"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td><input type="password" class="form-control"
					id="passwordCheck" value="" required></td>
				<td>
					<div>
						<span id="msgPasswordCheck" class="msg"></span>
					</div>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="email" class="form-control"
					placeholder="abc@xyz.com" name="email" id="email"
					value="kei01105@nate.com"></td>
				<td>
					<button type="button" class="btn btn-primary" id="mail-Check-Btn">본인인증</button>
				</td>
				<td>
					<input class="mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled">
				</td>
				
			</tr>
			<tr>
				<td colspan="3">
					<span id="mail-check-warn">&nbsp;</span>
					<input type="hidden" name="mailCheckVal" id="mailCheckVal" value="0"/>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td><input type="tel" class="form-control"
					placeholder="(-없이)01012345678" name="phone" id="phone"
					maxlength="11" value="01098989898" required></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<div class="form-check form-check-inline">
						<input type="radio" class="form-check-input" name="gender"
							id="gender0" value="M" checked> <label
							class="form-check-label" for="gender0">남</label> &nbsp; <input
							type="radio" class="form-check-input" name="gender" id="gender1"
							value="F"> <label class="form-check-label" for="gender1">여</label>
					</div>
				</td>
			</tr>
		</table>
		<input type="hidden" name="${_csrf.parameterName}"
			value="${_csrf.token}" />
		<input type="submit" value="가입">
		<input type="reset" value="취소">
	</form:form>
</div>
<script>
document.userEnrollFrm.addEventListener('submit', (e) => {
	const mailCheckVal = document.querySelector('#mailCheckVal').value;
	e.preventDefault(); // 제출방지
	if(mailCheckVal == 0){
		alert('메일 인증이 필요합니다.');
		return false;
	}
	else{
		document.userEnrollFrm.submit();
	}
	
});

//인증 이메일
var code = "";

$('#mail-Check-Btn').click(function() {
	const email = $('#email').val(); // 이메일 주소값 얻어오기!
	console.log('이메일 : ' + email); // 이메일 오는지 확인
	const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
	
	$.ajax({
		url : `${pageContext.request.contextPath}/user/userEamilCheck.do`,
		data : {
			email
		},
		success(data){
			console.log(data);
			checkInput.attr("disabled",false);
			document.querySelector('.mail-check-input').value = data;
			code = data;
		},		
		error : console.log
	});
});

//인증번호 비교
$(".mail-check-input").blur(function(){
	const inputCode = document.querySelector('.mail-check-input').value; 
	const checkResult = document.querySelector('#mail-check-warn'); 
	const mailCheckVal = document.querySelector('#mailCheckVal').value;
	
    if(inputCode == code){
    	console.log('일치');
        checkResult.innerHTML = "인증번호가 일치합니다.";
        checkResult.classList.add("correct");
        document.querySelector('#mailCheckVal').value = "1";
        
    } else {
    	console.log('불일치');
        checkResult.innerHTML = "인증번호를 다시 확인해주세요."
        checkResult.classList.add("incorrect");
        return false;
    }    
});


const availableCheck = (input, result, msg) => {
	if (result === "fail") {
	  input.style.color = 'red';
	} else {
		input.style.color = 'blue';
	}
	input.innerHTML = msg;
};

function checkId(){
	let userId = document.querySelector('#userId').value;
	
	const headers = {};
	headers['${_csrf.headerName}'] = '${_csrf.token}';
	
	$.ajax({
		headers,
		url : `${pageContext.request.contextPath}/user/userIdCheck.do`,
		data : {userId},
		method : "GET",
		success(response){
			//console.log(response);
			if(response != 0){	
				$("#msguserId").html('사용할 수 없는 아이디입니다');
				$("#msguserId").css("color", 'red');
			}	
			else if(userId == ''){
				document.querySelector('#msguserId').innerHTML = '';
			}
			else if(response == 0) {
				$("#msguserId").html('사용가능한 아이디입니다');
				$("#msguserId").css("color", 'blue');
			}
			
		},
		error : console.log
		
	});
};

const password = document.querySelector("#password");
const msgPassword = document.querySelector("#msgPassword");
const passwordCheck = document.querySelector("#passwordCheck");
const msgPasswordCheck = document.querySelector("#msgPasswordCheck"); 

function passwordCK () {
	if (!/\d{4}/.test(password.value)) {
		availableCheck(msgPassword, "fail", "실패");
		if(password.value == ''){
			document.querySelector('#msgPassword').innerHTML = '';
		}
	} 
	else {
		availableCheck(msgPassword, "clear", "성공");
	}
};

passwordCheck.addEventListener('blur', (e) => {
	if (password.value !== passwordCheck.value) {
		availableCheck(msgPassword, "fail", "실패");
		availableCheck(msgPasswordCheck, "fail", "다시입력하세요");
		passwordCheck.select();
		passwordCheck.value ="";
	}
	else{
		availableCheck(msgPassword, "clear", "");
		document.querySelector('#msgPasswordCheck').innerHTML = '';
	}
});
</script>
</body>
</html>