<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="채팅방" name="title" />
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js">moment.locale('ko');</script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/chat/myChatList.css" />
<style>
</style>
<sec:authentication property="principal.username" var="loginUser" />
<div class="container my-5" id="myChat-container">
	<div class="row mx-auto">
		<div class="col-lg-4" style="height: 80vh; overflow-y: scroll;">
			<table class="table" id="chatList">
				<thead>
					<tr class="text-center">
						<th colspan="3" class="py-2">채팅목록</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty chatUsers}">
						<tr>
							<td class="text-center p-3" id="nothingChat">현재 채팅가능한 채팅방이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty chatUsers}">
						<c:forEach items="${chatUsers}" var="chatUser">
							<tr data-chatroomid="${chatUser.chatroomId}">
								<td class="text-center align-middle chatUserProfile"
									onclick="enterChatroom('${chatUser.chatroomId}', '${chatUser.userId}')">
									<i class="fa-solid fa-circle-user"></i>
									<br />
									<span> <c:choose>
											<c:when test="${chatUser.chatTradeNo eq null}">
												<small class="badge bg-primary">1:1</small>
											</c:when>
											<c:when test="${chatUser.chatTradeNo ne null}">
												<small class="badge bg-warning">중고거래</small>
											</c:when>
										</c:choose>
								</span></td>
								<td class="px-3 chatUserId"
									onclick="enterChatroom('${chatUser.chatroomId}', '${chatUser.userId}')"><strong>${chatUser.userId}</strong>
									<br /> <small id="recentChatMsg">${chatUser.chatLog.chatMsg}</small>
								</td>
								<td class="text-end align-middle"
									onclick="deleteChatroom('${chatUser.chatroomId}')">
									<button type="button" class="btn p-auto" style="border: none;"
										data-chatroomId="${chatUser.chatroomId}">
										<i class="fa-solid fa-xmark"></i>
									</button>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="col-lg-8 card py-2" style="height: 80vh;">
			<div class="w-100 p-2" id="chatLog"
				style="height: 80vh; overflow-y: scroll;"></div>
			<div class="input-group" id="chatBtn"></div>
			<div id="goTradeBtnArea"></div>
		</div>
	</div>
</div>
<script>
//화면 로드시 스크롤 이동
$(document).ready(function () {
	$('html, body, .container').animate({scrollTop: $('#myCarousel').outerHeight(true) - $('.blog-header').outerHeight(true) }, 'fast');
});


setTimeout(() => {
	stompClient.subscribe('/app/${loginUser}/myChatList', (message) => {
		console.log('/app/${loginUser}/myChatList : ', message);
		subMyChatList(message);
	});
	
	/* stompClient.subscribe(`/app/chat/\${chatroomId}`, (message) => {
		
	}); */
	//document.querySelectorAll(tr[data-chatroomid
	
}, 500);


//채팅방 입장시
const enterChatroom = (chatroomId, chatTargetId) => {
	//const tr = e.target.parentElement;
	//const chatroomId = tr.dataset.chatroomid;
	console.log("채팅방 입장시 chatroomId = ", chatroomId);
	console.log("채팅방 입장시 chatTargetId = ", chatTargetId);
	const chatLog = document.querySelector("#chatLog");
	chatLog.innerHTML = "";

	$.ajax({
		url : '${pageContext.request.contextPath}/chat/enterChatroom.do',
		data : {chatroomId},
		success(response){
			console.log(response);
			
			const {chatLogs, chatTradeNo} = response;
			chatLogs.forEach((chat) => {
				
				const {userId, chatMsg, chatTime} = chat;
				tradeNo = chatTradeNo;
				//console.log(chatTradeNo);
				//console.log(chat);
				//const date = new Date(chatTime).toLocaleTimeString();
				const date = moment(chatTime).format("YY.MM.D HH:mm");
				//console.log(date);
				let html = "";
				//console.log("${loginUser}");
				//console.log(userId, chatMsg, chatTime);
				
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
							<li class="list-item w-50" focus();><small>\${date}</small></li>
						</ul>
					`;
				}
				
				chatLog.insertAdjacentHTML('beforeend', html);
			});
			
			// 전송 버튼 영역 추가
			const btnArea = document.querySelector("#chatBtn");
			
			btnArea.innerHTML = ``;
			btnArea.innerHTML += `
				<input type="text" id="msg" class="form-control" placeholder="Message">

				<div class="input-group-append" style="padding: 0px;">
				  <button id="sendBtn" class="btn btn-outline-secondary" type="button"
				  	onclick="sendMsg('\${chatroomId}', '\${chatTargetId}')"><i class="fa-solid fa-paper-plane"></i> Send</button>
				</div>
			`;
			
			// 중고거래글 이동버튼 영역 추가
			const btnTradeArea = document.querySelector("#goTradeBtnArea");
			if(chatTradeNo != null){
				btnTradeArea.innerHTML = `
					<button class="btn btn-borderless badge bg-warning" id="goTradeBtn"
						onclick="goTrade('\${chatTradeNo}')">중고거래 글로 이동</button>
				`;
			}
			else {
				btnTradeArea.innerHTML = "";
			}
			
			chatLog.scrollTop = chatLog.scrollHeight;
			
			document.querySelector("#msg").addEventListener('keyup', (e) => {
				
				if(e.key === 'Enter') sendMsg(`\${chatroomId}`, `\${chatTargetId}`);
			});
			
			stompClient.subscribe(`/app/chat/\${chatroomId}`, (message) => {
				subChatLog(message);
			});
		},
		error : console.log
		
	});
	
};

const subMyChatList = (message) => {
	const {chatroomId, userId, chatMsg, chatTradeNo} = JSON.parse(message.body);
	const tbody = document.querySelector("#chatList tbody");
	let tr = document.querySelector(`tr[data-chatroomid = "\${chatroomId}"]`);
	if(tr) {
		tr.querySelector("#recentChatMsg").innerHTML = chatMsg;
	} //if
	else {
		//신규채팅방인 경우
		tr = document.createElement("tr");
		tr.dataset.chatroomid = chatroomId;
		
		let html = `
			<td class="text-center align-middle chatUserProfile" onclick="enterChatroom('\${chatroomId}', '\${userId}')">
				<i class="fa-solid fa-circle-user"></i>
				<br />
				<span>
		`;

		if(chatTradeNo == null){
			html += `<small class="badge bg-primary">1:1</small>`;
		} // if
		else {
			html += `<small class="badge bg-warning">중고거래</small>`;
		} //else
		
		html += `
				</span>
			</td>
			<td class="px-3 chatUserId"
				onclick="enterChatroom('\${chatroomId}', '\${userId}')">
				<strong>\${userId}</strong>
				<br />
				<small id="recentChatMsg">\${chatMsg}</small>
			</td>
			<td class="text-end align-middle" onclick="deleteChatroom('\${chatroomId}')" >
				<button type="button" class="btn p-auto" style="border: none;"
					data-chatroomId="\${chatroomId}">
					<i class="fa-solid fa-xmark"></i>
				</button>
			</td>
		`;
		
		if(document.querySelector("#nothingChat")){
			tbody.innerHTML = "";
		}
		
		tr.insertAdjacentHTML("afterbegin", html);
		
		
	} //else
	
	//끌어올리기
	tbody.insertAdjacentElement('afterbegin', tr);
	
};


const subChatLog = (message) => {
	
	const {"content-type" : contentType} = message.headers;
	if(!contentType) return;
	
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
	
	chatLog.scrollTop = chatLog.scrollHeight;
	subMyChatList(message);
};


// 메세지 전송 버튼 클릭시
const sendMsg = (chatroomId, chatTargetId) => {
	console.log("전송버튼 클릭시 chatroomId = ", chatroomId);
	console.log("전송버튼 클릭시 chatTargetId = ", chatTargetId);
	const chatMsg = document.querySelector("#msg").value;
	console.log("chatMsg = ", chatMsg);
	
	if(!chatMsg) return;
	const payload = {
		chatroomId,
		userId : '${loginUser}',
		chatMsg,
		chatTime : Date.now()
	};
	
	stompClient.send(`/app/chat/\${chatroomId}`, {}, JSON.stringify(payload));
	stompClient.send(`/app/\${chatTargetId}/myChatList`, {}, JSON.stringify(payload));
	
	document.querySelector("#msg").value = "";
	
};

//중고거래 글 이동 버튼 클릭시
const goTrade = (tradeNo) => {
	
	$.ajax({
		url : '${pageContext.request.contextPath}/chat/goTrade.do',
		data : {tradeNo},
		success(response){
			console.log(response);
			
			if(response == null){
				alert("해당 중고거래 글은 열람이 불가합니다.");
				return;
			}
			else {
				location.href="${pageContext.request.contextPath}/trade/tradeView.do?no=" + tradeNo;
			}
		},
		error : console.log
			
	});
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
				
				location.reload();
			},
			error : console.log
			
		});
	}
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />