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
  <input type="text" id="msg" class="form-control" placeholder="판매자에게 보내는 Message">
  <div class="input-group-append" style="padding: 0px;">
    <button id="sendBtn" class="btn btn-outline-secondary" type="button">Send</button>
  </div>
</div>
<div>
	<ul class="list-group list-group-flush" id="data"></ul>
</div>

<script>
document.querySelector("#sendBtn").addEventListener('click', () => {
	const msg = document.querySelector("#msg").value;
	if(!msg) return
	
	const payload = {
			chatroomId : '${chatroomId}',
			memberId : '<sec:authentication property="principal.username"/>',
			tradeNo : localStroage.getItem("tradeNo"),
			msg,
			time : Date.now()
	};
	
	stompClient.send(`/app/chat/${chatroomId}`, {}, JSON.stringify(payload));
	document.querySelector("#msg").value; = "";
	
	
});

setTimeout(() => {	
	stomClient.subscribe(`app/chat/${chatroomId}`, (message) => {
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