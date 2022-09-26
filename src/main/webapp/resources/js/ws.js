const ws = new SockJS(`http://${location.host}/campingez/stomp`);
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log("connect : ", frame);
	
	stompClient.subscribe("/app/notice", (message) => {
		console.log("app/notice : ", message);
	});
	
	stompClient.subscribe(`/app/notice/${userId}`, (message) => {
		console.log(`app/notice/${userId} : `, message);
		getAlarmList(userId);
	});
});