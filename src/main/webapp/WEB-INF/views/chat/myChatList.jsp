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
<style>
.targetChat {
	list-style : none;
	padding : 0;
}
.userMsg {
	background-color: #7A86B6;
	color : white;
}
.targetMsg {
	background-color: #C8B6E2;
	color : white;
}
</style>
<sec:authentication property="principal.username" var="loginUser" />
<div class="container my-5">
	<div class="row mx-auto">
		<div class="col-lg-4">
		<c:if test="${empty chatUsers}">
			<p>현재 채팅가능한 채팅방이 없습니다.</p>
		</c:if>
		<c:if test="${not empty chatUsers}">
		<table class="table text-center">
			<c:forEach items="${chatUsers}" var="chatUser">
				<tr
					data-chatTargetId="${chatUser.userId}"
					data-chatroomId="${chatUser.chatroomId}">
					<th class="p-3">${chatUser.userId}</th>
					<td class="p-3">
						<button type="button" class="btn btn-outline-dark"
						onclick="enterChatroom(event)">입장</button>
					</td>
				</tr>
			</c:forEach>
		</table>
		</c:if>
		</div>
		<div class="col-lg-8 card py-2" style="height: 80vh;">
			<div class="w-100" id="chatLog" style="height: 80vh; overflow-y: scroll;">
				
			</div>
			<div class="input-group" id="chatBtn">
			
			</div>
		</div>
	</div>
</div>
<script>
const enterChatroom = (e) => {
	const tr = e.target.parentElement.parentElement
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
				const {userId, chatMsg, time} = chat;
				const date = new Date(time).toLocaleString();
				console.log(date);
				let html = "";
				console.log("${loginUser}");
				console.log(userId, chatMsg, time);
				
				if("${loginUser}" === userId) {
					html += `
						<ul class="list-unstyled list-group d-flex align-items-end text-right">
							<li class="list-item w-50 my-1"><small>\${date}</small></li>
							<li class="list-item my-2"><span class="card userMsg p-2" title="">\${chatMsg}</span></li>
						</ul>
					`;
				}
				else {
					html += `
						<ul class="list-unstyled list-group d-flex align-items-start text-left" >
							<li class="list-item w-50 my-1"><strong>\${userId}</strong> <small>\${date}</small></li>
							<li class="list-item w-25 my-2"><span class="card targetMsg p-2">\${chatMsg}</span></li>
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
				  	onclick="sendMsg('\${chatroomId}')">Send</button>
				</div>
			`;
		},
		error : console.log
	});
	
};
const sendMsg = (chatroomId) => {
	console.log("chatroomId = ", chatroomId);
	const msg = document.querySelector("#msg").value;
	if(!msg) return;
	const payload = {
		chatroomId : chatroomId,
		userId : '<sec:authentication property="principal.username"/>',
		msg,
		time : Date.now()
	};
	
	stompClient.send(`/app/chat/\${chatroomId}`, {}, JSON.stringify(payload));
	
	document.querySelector("#msg").value = "";
	
	
};

setTimeout(() => {
	stompClient.subscribe(`/app/chat/${chatroomId}`, (message) => {
		const {"content-type" : contentType} = message.headers;
		if(!contentType) return;
		
		console.log(`/app/chat/${chatroomId} : `, message);
		const {userId, msg, time} = JSON.parse(message.body);
		const html = `
			<li class="list-group-item" title="\${new Date(time).toLocaleString()}">\${userId} : \${msg}</li>
		`;
		const wrapper = document.querySelector("#data");		
		wrapper.insertAdjacentHTML('beforeend', html);
	});	
}, 500);
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />