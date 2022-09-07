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
	height: 266px;
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
</style>
<h1>로그인페이지</h1>
<form:form action="" method="post">
	<div class="modal-body">
		<input type="text" name="userId" placeholder="아이디" required id="userId"> <br />
		<input type="password" name="password" placeholder="비밀번호" required>
	</div>
	<div>
		<div>
			<button type="submit">로그인</button>
		</div>
		<div>
			<input type="checkbox" name="remember-me" id="remember-me"/>
			<label for="remember-me">로그인유지</label>
		</div>
		<div>
			<%--<button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userFindId.do';">아이디찾기</button> --%>
			<button type="button" id="btnModal">아이디찾기</button>
			<button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userFindPassword.do';">비밀번호찾기</button>
		</div>
	</div>
</form:form>
<div id="modal" class="modal-overlay">
	<div class="modal-window">
		<div class="title">
			<h4>아이디 찾기</h4>
		</div>
		<div class="close-area">X</div>
		<div class="content">
			<table class="mx-auto">
				<tr>
					<th>이름</th>
					<td><input type="text" class="form-control" name="findUserName"
						id="findUserName" value="신사임당" required></td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td><input type="tel" class="form-control"
						placeholder="(-없이)01012345678" name="findPhone" id="findPhone"
						maxlength="11" value="01098989898" required></td>
				</tr>
			</table>
			<input type="button" value="찾기" onclick="findId()">
		</div>
		<div>
			<span id="findIdResult"></span>
		</div>
	</div>
</div>
<script>
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
					document.querySelector('.content').innerHTML = '';
					document.querySelector('.content').innerHTML += user.userId;
					document.querySelector('.content').innerHTML += `<input type="button" value="확인" onclick="modalOff()">`;
					document.querySelector('#findIdResult').innerHTML = '';
					findId = user.userId;
				}
				
			},
			error : console.log
		});
		
	};

	const modal = document.getElementById("modal")
    function modalOn() {
        modal.style.display = "flex";
        $('body').css("overflow", "hidden");
    }
    function isModalOn() {
        return modal.style.display === "flex"
    }
    function modalOff() {
        modal.style.display = "none"
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