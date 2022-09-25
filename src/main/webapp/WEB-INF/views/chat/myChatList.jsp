<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="채팅방" name="title"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js">moment.locale('ko');</script>
<style>
.targetChat {
	list-style : none;
	padding : 0;
}
.chatUserId {
	cursor : pointer;
}
.userMsg {
	background-color: #7A86B6;
	color : white;
}
.targetMsg {
	background-color: #C8B6E2;
	color : white;
}
#chatList>thead {
	background-color : #7A86B6 !important;
	color : white;
}
</style>
<sec:authentication property="principal.username" var="loginUser" />
<div class="container my-5">
	<div class="row mx-auto">
		<div class="col-lg-4" style="height: 80vh; overflow-y: scroll;">
		<table class="table" id="chatList">
			<thead>
				<tr class="text-center">
					<th colspan="2">채팅목록</th>
				</tr>
			</thead>
			<c:if test="${empty chatUsers}">
				<tr>
					<td class="text-center p-3">현재 채팅가능한 채팅방이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty chatUsers}">
			<c:forEach items="${chatUsers}" var="chatUser">
				<tr
					data-chatTargetId="${chatUser.userId}"
					data-chatroomId="${chatUser.chatroomId}">
					<th class="px-3 w-100 chatUserId" onclick="enterChatroom(event)">
						${chatUser.userId}
					</th>
					<td class="text-end align-center">
						<button type="button" class="btn" style="border: none;"
							onclick="deleteChatroom('${chatUser.chatroomId}')" data-chatroomId="${chatUser.chatroomId}">
							<i class="fa-solid fa-xmark"></i>
						</button>
					</td>
				</tr>
			</c:forEach>
			</c:if>
		</table>
		</div>
		<div class="col-lg-8 card py-2" style="height: 80vh;">
			<div class="w-100 p-2" id="chatLog" style="height: 80vh; overflow-y: scroll;">
				
			</div>
			<div class="input-group" id="chatBtn">
			
			</div>
		</div>
	</div>
</div>
<script>
//화면 로드시 스크롤 이동
$(document).ready(function () {
	$('html, body, .container').animate({scrollTop: $('#myCarousel').outerHeight(true) - $('.blog-header').outerHeight(true) }, 'fast');
});



//채팅방 입장시
const enterChatroom = (e) => {
	const tr = e.target.parentElement;
	console.log(tr);
	const chatroomId = tr.dataset.chatroomid;
	console.log(chatroomId);
	const chatLog = document.querySelector("#chatLog");
	
	chatLog.innerHTML = "";
	$.ajax({
		url : '${pageContext.request.contextPath}/chat/enterChatroom.do',
		data : {chatroomId},
		success(response){
			console.log(response);
			
			response.forEach((chat) => {
				const {userId, chatMsg, chatTime} = chat;
				console.log(chatTime);
				//const date = new Date(chatTime).toLocaleTimeString();
				const date = moment(chatTime).format("YY.MM.D HH:mm");
				console.log(date);
				let html = "";
				console.log("${loginUser}");
				console.log(userId, chatMsg, chatTime);
				
				if("${loginUser}" === userId) {
					html += `
						<ul class="list-unstyled list-group d-flex align-items-end">
							<li class="list-item mt-2"><span class="card userMsg p-2" title="">\${chatMsg}</span></li>
							<li class="list-item w-50 text-end"><small>\${date}</small></li>
						</ul>
					`;
				}
				else {
					html += `
						<ul class="list-unstyled list-group d-flex align-items-start" >
							<li class="list-item w-50 mt-2 mb-1"><strong>\${userId}</strong></li>
							<li class="list-item"><span class="card targetMsg p-2">\${chatMsg}</span></li>
							<li class="list-item w-50"><small>\${date}</small></li>
						</ul>
					`;
				}
				
				chatLog.insertAdjacentHTML('beforeend', html);
				
			});
			const btnArea = document.querySelector("#chatBtn");
			
			btnArea.innerHTML = "";
			btnArea.innerHTML += `
				<input type="text" id="msg" class="form-control" placeholder="Message">

			<div class="input-group-append" style="padding: 0px;">
				  <button id="sendBtn" class="btn btn-outline-secondary" type="button"
				  	onclick="sendMsg('\${chatroomId}')"><i class="fa-solid fa-paper-plane"></i> Send</button>
				</div>
			`;
		},
		error : console.log,
		complete() {
			
			stompClient.subscribe(`/app/chat/\${chatroomId}`, (message) => {
				const {"content-type" : contentType} = message.headers;
				if(!contentType) return;
				
				console.log(`/app/chat/\${chatroomId} : `, message);

				const chatLog = document.querySelector("#chatLog");	
				
				const {userId, chatMsg, chatTime} = JSON.parse(message.body);
				//const date = new Date(chatTime).toLocaleTimeString();
				const date = moment(chatTime).format("YY.MM.D HH:mm");
				console.log(date);
				let html = "";
				if("${loginUser}" === userId) {
					html += `
						<ul class="list-unstyled list-group d-flex align-items-end">
							<li class="list-item mt-2"><span class="card userMsg p-2" title="">\${chatMsg}</span></li>
							<li class="list-item w-50 text-end"><small>\${date}</small></li>
						</ul>
					`;
				}
				else {
					html += `
						<ul class="list-unstyled list-group d-flex align-items-start" >
							<li class="list-item w-50 mt-2 mb-1"><strong>\${userId}</strong></li>
							<li class="list-item"><span class="card targetMsg p-2">\${chatMsg}</span></li>
							<li class="list-item w-50"><small>\${date}</small></li>
						</ul>
					`;
				}
				
				chatLog.insertAdjacentHTML('beforeend', html);
			});	
		}
	});
	
};

// 메세지 전송 버튼 클릭시
const sendMsg = (chatroomId) => {
	console.log("chatroomId = ", chatroomId);
	const chatMsg = document.querySelector("#msg").value;
	if(!chatMsg) return;
	const payload = {
		chatroomId : chatroomId,
		userId : '<sec:authentication property="principal.username"/>',
		chatMsg,
		chatTime : Date.now()
	};
	
	stompClient.send(`/app/chat/\${chatroomId}`, {}, JSON.stringify(payload));
	
	document.querySelector("#msg").value = "";
	
	
};

//채팅방 나가기 버튼 클릭시
const deleteChatroom = (chatroomId) => {
	console.log(chatroomId);
	const userId = '${loginUser}';
	
	if(confirm("채팅방을 나가시겠습니까?\n해당 사용자와의 채팅내역은 다시 확인 불가합니다.")){
		const headers = {};
		headers['${_csrf.headerName}'] = '${_csrf.token}';
		
		$.ajax({
			url : '${pageContext.request.contextPath}/chat/chatroomDelete.do',
			headers,
			method : 'POST',
			data : {chatroomId, userId},
			success(response){
				console.log(response);
				
				const payload = {
						chatroomId : chatroomId,
						userId : '<sec:authentication property="principal.username"/>',
						chatMsg : `-------- \${userId} 님이 채팅방을 나갔습니다. --------`,
						chatTime : Date.now()
					};
					
					stompClient.send(`/app/chat/\${chatroomId}`, {}, JSON.stringify(payload));
			},
			error : console.log
			
		});
	}
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />