<%@page import="com.kh.campingez.inquire.model.dto.Answer"%>
<%@page import="com.kh.campingez.inquire.model.dto.Inquire"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css" />
<style>
#modal.modal-overlay {
	width: 100%;
	height: 100%;
	position: fixed;
	left: 0;
	top: 0;
	display: none;
	background: rgb(94 94 94/ 50%);
}

#modal .modal-window {
	background: rgba(255, 255, 255);
	border-radius: 4px;
	width: 400px;
	height: 300px;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	margin: auto;
	padding: 10px;
}

#modal .title {
	padding-top: 10px;
	padding-left: 10px;
	display: inline;
	color: gray;
}

#modal .title h4 {
	display: inline;
	font-size: 20px;
	vertical-align: -webkit-baseline-middle;
}

#modal .close-area {
	display: inline;
	float: right;
	padding-right: 10px;
	cursor: pointer;
	text-shadow: 1px 1px 2px rgb(87, 87, 87);
	color: grey;
	font-size: 20px;
}

#modal .content {
	margin-top: 30px;
	padding: 0px 10px;
	color: black;
}
#pwd-show {
	border: none;
    background-color: white;
    z-index: 999;
    cursor: pointer;
}
}
#pwd-show > img {
    width: 30px;
    height: 30px;
}
.show-wrap {
	height: 100%;
    display: flex;
    justify-content: flex-end;
    align-items: center;
    margin-right: 14px;
    cursor: pointer;
}
</style>

<div class="login-container" style="height: 700px;">
    <div class="loginImg">
      <img src="${pageContext.request.contextPath}/resources/images/loginCamping.png" style="border-radius: 10%;"/>
    </div>
    <div class="login-content">
      <form:form action="" method="post">
        <h2 class="title">Welcome</h2>
	    <c:if test="${param.error != null}">
			<div class="alert alert-danger alert-dismissible fade show" role="alert" style="font-size: 12px;">
			  <strong style="font-size: 13px;">아이디 또는 비밀번호가</strong> 일치하지 않습니다.
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
		</c:if>
        <div class="input-div one">
          <div class="i">
            <i class="fas fa-user"></i>
          </div>
          <div class="div">
            <h5>Id</h5>
            <input type="text" name="userId" required id="userId" class="input"> 
          </div>
        </div>
        <div class="input-div pass">
          <div class="i">
            <i class="fas fa-lock"></i>
          </div>
		  <div class="div">
            <h5>Password</h5>
            <input type="password" name="password" required class="input">
			<div class="show-wrap">
	           <button type="button" id="pwd-show">
	           	<img src="${pageContext.request.contextPath}/resources/images/eye_visible_icon.png" />
	           </button>
			</div>
          </div>
        </div>
        <div style="text-align: right;">
	        <span class="find" id="btnModal" style="display: inline; cursor: pointer;">Forgot Id?</span><br />
	        <a href="${pageContext.request.contextPath}/user/userFindPassword.do" class="find" style="display: inline;">Forgot Password?</a>
        </div>
		<div>
			<button type="submit" class="login-btn">Login</button>
			<%-- <input type="hidden" id="loginTest" name="targetUrl" value="${loginRedirect}"/>
			<script>console.log(document.querySelector('#loginTest').value);</script> --%>
		</div>
      </form:form>
    </div>
  </div>
<div id="modal" class="modal-overlay">
	<div class="modal-window">
		<div class="title">
			<h4>아이디 찾기</h4>
		</div>
		<div class="close-area">X</div>
		<div class="content">
			<table class="mx-auto">
				<tr>
					<th style="text-align: left;">이름>&nbsp;</th>
					<td><input type="text" class="form-control" name="findUserName"
						id="findUserName" value="" required></td>
				</tr>
				<tr><th>&nbsp;</th></tr>
				<tr>
					<th>휴대폰>&nbsp;&nbsp;</th>
					<td><input type="tel" class="form-control"
						placeholder="(-없이)01012345678" name="findPhone" id="findPhone"
						maxlength="11" value="" required></td>
				</tr><tr><th>&nbsp;</th></tr>
				<tr>
					<th>&nbsp;</th>
					<td style="text-align: right;">
						<input class="btn btn-outline-primary" type="button" value="찾기" onclick="findId()">
					</td>
				</tr>
				<tr>
					<th style="text-align: center;" colspan="3">
						<span id="findIdResult"></span>
					</th>
				</tr>
			</table>
		</div>
	</div>
</div>
<script>
const inputs = document.querySelectorAll(".input");

// 비밀번호 활성화
document.querySelector("#pwd-show").addEventListener('click', (e) => {
	const pwd = document.querySelector("[name=password]");
	
	if(pwd.type == 'password') {
		pwd.type = 'text';
	} else {
		pwd.type = 'password';
	}
});

function addcl() {
  let parent = this.parentNode.parentNode;
  parent.classList.add("focus");
}

function remcl() {
  let parent = this.parentNode.parentNode;
  if (this.value == "") {
    parent.classList.remove("focus");
  }
}


inputs.forEach(input => {
  input.addEventListener("focus", addcl);
  input.addEventListener("blur", remcl);
});


	function findId(){
		document.querySelector('#findIdResult').innerHTML = '';
		const name = document.querySelector('#findUserName').value;
		const phone = document.querySelector('#findPhone').value;
		//console.log(name, phone);
		
		const headers = {};
		headers['${_csrf.headerName}'] = '${_csrf.token}';
		//console.log(headers);
		
		$.ajax({
			headers,
			url : `${pageContext.request.contextPath}/user/userFindId.do`,
			async: false,
			data : {
				name, phone
			},
			method : "GET",
			success(user){
				//console.log(user.userId);

				if(user == 0){
					document.querySelector('#findIdResult').innerHTML = '잘못된 회원정보입니다.';
					return false;
				}
				else{
					document.querySelector('#findIdResult').innerHTML = '';
					document.querySelector('#findIdResult').innerHTML += user.userId;
					document.querySelector('#findIdResult').innerHTML += `&nbsp;&nbsp;&nbsp;<input class="btn btn-outline-secondary" type="button" value="확인" onclick="modalOff()">`;
				}
				
			},
			error : console.log
		});
		
	};

	const modal = document.getElementById("modal")
    function modalOn() {
        modal.style.display = "flex";
        document.querySelector('#pwd-show').style.zIndex = "0";
        $('body').css("overflow", "hidden");
    }
    function isModalOn() {
        return modal.style.display === "flex"
    }
    function modalOff() {
        modal.style.display = "none"
        document.querySelector('#pwd-show').style.zIndex = "999";
        $('body').css("overflow-y", "scroll");
    }
    const btnModal = document.getElementById("btnModal")
    btnModal.addEventListener("click", e => {
      modalOn()
      const momodal = document.getElementById("momodal")
    })
    const closeBtn = modal.querySelector(".close-area")
    closeBtn.addEventListener("click", e => {
        modalOff()
    })
    modal.addEventListener("click", e => {
        const evTarget = e.target
        if(evTarget.classList.contains("modal-overlay")) {
            modalOff()
        }
    })
    window.addEventListener("keyup", e => {
        if(isModalOn() && e.key === "Escape") {
            modalOff()
        }
    })
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>