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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
    .correct {color: blue;}
    .incorrect { color: red; }
    sup{color: red;}
    th{text-align: left; width: 130px;}
    td{padding: 10px; width: 250px;}
  </style>
  <br />
 <div id="enroll-container" class="mx-auto text-center">
    <h1>회원가입</h1><br>
    <form:form name="userEnrollFrm" action="" method="POST">
      <table class="mx-auto">
        <tr>
          <th>아이디<sup>*</sup></th>
          <td>
            <div id="userId-container">
              <input type="text" class="form-control" placeholder="아이디(4글자이상)" name="userId" id="userId" required
                oninput="checkId()">
               <input type="hidden" name="idCheckVal" id="idCheckVal" value="0"/>
            </div>
          </td>
          <td>
            <div>
              <span id="msguserId" class="msg"></span>
            </div>
          </td>
        </tr><tr><th>&nbsp;</th></tr>
        <tr>
          <th>이름<sup>*</sup></th>
          <td><input type="text" class="form-control" name="userName" id="userName" value="" required></td>
        </tr><tr><th>&nbsp;</th></tr>
        <tr>
          <th>비밀번호<sup>*</sup></th>
          <td><input type="password" class="form-control" name="password" id="password" value="" required
              oninput="passwordCK()"></td>
          <td>
            <div>
              <span id="msgPassword" class="msg"></span>
            </div>
          </td>
        </tr>
        	<tr>
        		<th>&nbsp;</th>
        		<td colspan="2" style="font-size: 0.85em; text-align: left;">
        			<sup>**</sup>비밀번호는 영문자+숫자+특수문자(!@#$%^&*) 포함 8글자이상<sup>**</sup>
        		</td>
        	</tr>
        <tr>
          <th>패스워드확인</th>
          <td><input type="password" class="form-control" id="passwordCheck" value="" required></td>
          <td>
            <div>
              <span id="msgPasswordCheck" class="msg"></span>
            </div>
          </td>
        </tr><tr><th>&nbsp;</th></tr>
        <tr>
          <th>이메일<sup>*</sup></th>
          <td><input type="email" class="form-control" placeholder="abc@xyz.com" name="email" id="email"
              value="" required oninput="emailCK()"></td>
          <td>
            <button type="button" class="btn btn-primary" id="mail-Check-Btn" style="width: 100%;" disabled>이메일인증</button>
          </td>
        </tr><tr><th>&nbsp;</th></tr>
        <tr>
          <th>이메일 확인 </th>
          <td>
            <input class="form-control mail-check-input" placeholder="인증번호 6자리" disabled="disabled">
          </td>
          <td colspan="3">
            <span id="mail-check-warn"></span>
            <input type="hidden" name="mailCheckVal" id="mailCheckVal" value="0" />
          </td>
        </tr><tr><th>&nbsp;</th></tr>
        <tr>
          <th>휴대폰<sup>*</sup></th>
          <td><input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone"
              maxlength="11" value="" required></td>
        </tr><tr><th>&nbsp;</th></tr>
        <tr>
          <th>성별</th>
          <td>
              <input type="radio" class="form-check-input" name="gender" id="gender0" value="M">
              <label class="form-check-label" for="gender0">남</label> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
              <input type="radio" class="form-check-input" name="gender" id="gender1" value="F"> 
              <label class="form-check-label" for="gender1">여</label>
          </td>
        </tr><tr><th>&nbsp;</th></tr>
      </table>
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
      <input class="btn btn-outline-primary" type="submit" value="가입">
      <input class="btn btn-outline-secondary" type="button" value="취소" onclick="location.href='${pageContext.request.contextPath}';">
    </form:form>
  </div>
<script>
const password = document.querySelector("#password");
const msgPassword = document.querySelector("#msgPassword");
const passwordCheck = document.querySelector("#passwordCheck");
const msgPasswordCheck = document.querySelector("#msgPasswordCheck"); 

//이메일 유효성
function emailCK () {
	const email = document.querySelector("#email");
	const emailCheck = document.querySelector('#mail-Check-Btn');
	if(/^([\w\.-]+)@([\w-]+)(\.[\w-]+){1,2}$/.test(email.value)) {
		emailCheck.disabled = false;
	}
	else {
		return false;
	}
};

//가입버튼
document.userEnrollFrm.addEventListener('submit', (e) => {
	const mailCheckVal = document.querySelector('#mailCheckVal').value;
	const idCheckVal = document.querySelector('#idCheckVal').value;
	
	e.preventDefault(); // 제출방지
	if(idCheckVal == 1){
		if(password.value == passwordCheck.value){
			if(mailCheckVal == 0){
				alert('메일 인증이 필요합니다.');
				return false;
			}
			else{
				//document.userEnrollFrm.submit();
			}
		}
		else{
			alert('비밀번호를 다시 입력해주세요.');
		}
	}
	else{
		alert('사용할 수 없는 아이디입니다.');
	}
	
});

//인증 이메일
var code = "";

$('#mail-Check-Btn').click(function() {
	const email = $('#email').val(); // 이메일 주소값 얻어오기!
	console.log('이메일 : ' + email); // 이메일 오는지 확인
	const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
	const emailCheck = document.querySelector('#mail-Check-Btn');
	emailCheck.disabled = true;
	
	$.ajax({
		url : `${pageContext.request.contextPath}/user/userEmailCheck.do`,
		data : {
			email
		},
		success(data){
			console.log(data);
			checkInput.attr("disabled",false);
			//document.querySelector('.mail-check-input').value = data;
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
        checkResult.classList.remove("incorrect");
        checkResult.classList.add("correct");
        document.querySelector('#mailCheckVal').value = "1";
        
    } else {
    	console.log('불일치');
        checkResult.innerHTML = "인증번호를 다시 확인해주세요."
        checkResult.classList.remove("correct");
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
			if(response != 0 || userId.length < 4){	
				$("#msguserId").html('사용할 수 없는 아이디입니다');
				$("#msguserId").css("color", 'red');
				document.querySelector('#idCheckVal').value = "0";
			}	
			else if(userId == '' || userId.length == 0){
				document.querySelector('#msguserId').innerHTML = '';
			}
			else if(response == 0) {
				$("#msguserId").html('사용가능한 아이디입니다');
				$("#msguserId").css("color", 'blue');
				document.querySelector('#idCheckVal').value = "1";
			}
			
		},
		error : console.log
		
	});
};

function passwordCK () {
	var reg =  /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
	
	if (!reg.test(password.value)) {
		availableCheck(msgPassword, "fail", "사용 불가능");
		if(password.value == ''){
			document.querySelector('#msgPassword').innerHTML = '';
		}
	} 
	else {
		availableCheck(msgPassword, "clear", "사용 가능");
	}
};

passwordCheck.addEventListener('input', (e) => {
	var reg =  /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;
	
	if (password.value !== passwordCheck.value) {
		availableCheck(msgPassword, "fail", "실패");
		//availableCheck(msgPasswordCheck, "fail", "다시입력하세요");
		//passwordCheck.focus();
		//passwordCheck.value ="";
	}
	else{
		availableCheck(msgPassword, "clear", "사용 가능");
		document.querySelector('#msgPasswordCheck').innerHTML = '';
	}

	if(passwordCheck.value == ''){
		document.querySelector('#msgPassword').innerHTML = '';
	}
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>