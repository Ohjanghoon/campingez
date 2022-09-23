<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="채팅화면" name="title"/>
</jsp:include>

<div class="input-group mb-3">
  <input type="text" id="msg" class="form-control" placeholder="판매자(${tradeId})에게 보내는 Message">
  <div class="input-group-append" style="padding: 0px;">
    <button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
  </div>
</div>
<div>
	<ul class="list-group list-group-flush" id="data"></ul>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script type="text/javascript">
//const ws = new SockJS(`http://${location.host}${pageContext.request.contextPath}/echo`);

console.log("Zz")
const ws = new SockJS(`http://localhost:9090${pageContext.request.contextPath}/echo`);
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log("connect : ", frame);
});
/* 
ws.addEventListener('open', (e) => console.log("open : ", e));
ws.addEventListener('error', (e) => console.log("error : ", e));
ws.addEventListener('close', (e) => console.log("close : ", e));
ws.addEventListener('message', (e) => {
	console.log("message : ", e);
	const container = dpcument.querySelector("#data");
	data.insertAdjacentHTML('beforeend', `<li class="list-group-iten">\${e.data}</li>)
});
 */
 document.querySelector("#sendBtn").addEventListener('click', () => {
	const msg = document.querySelector("#msg").value;
	if(!msg) return
	
	const payload = {
			chatroomId : '${chatroomId}', /* (from) */
			userId : '<sec:authentication property="principal.username"/>', /* (to) */
			tradeNo : '${tradeId}',
			msg,
			time : Date.now()
	};

	//stompClient.send(`/app/chat/${chatroomId}`, {}, JSON.stringify(payload));

	stompClient.send(JSON.stringify(payload));
	document.querySelector("#msg").value = "";
	
	
});

setTimeout(() => {	
	stompClient.subscribe(`app/chat/${chatroomId}`, (message) => {
		console.log(`/app/chat/${chatroomId} : `, message);
		const {userId, msg, time} = JSON.parse(message.body);
		const html = `
			<li class="list-group-item" title="\${time}">\${userId} : \${msg}</li>
		`;
		const wrapper = document.querySelector("#data");
		wrapper.insertAdjacentHTML('beforeend', html);
	});
}, 500); 
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>