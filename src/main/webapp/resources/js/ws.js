const ws = new SockJS(`http://${location.host}/spring/stomp`);
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log("connect : ", frame);
	
	stompClient.subscribe("/app/notice", (message) => {
		console.log("app/notice : ", message);
		alert('하이');
	});
	
	stompClient.subscribe("/app/notice/${userId}", (message) => {
		console.log("app/notice/${userId} : ", message);
	});
});