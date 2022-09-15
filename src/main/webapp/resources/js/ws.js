const ws = new SockJS(`http://${location.host}/campingez/stomp`);
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log("connect : ", frame);
	
	stompClient.subscribe("/app/notice", (message) => {
		console.log("app/notice : ", message);
	});
	
	stompClient.subscribe(`/app/notice/${userId}`, (message) => {
		console.log(`app/notice/${userId} : `, message);
		const div = document.querySelector(".header-layer");
		const {body} = message;
		const {alrId, alrMessage, alrType, alrUrl, alrDatetime, alrReadDatetime} = JSON.parse(body);
		const [yy, MM, dd] = alrDatetime;
		const html = `
<li data-alr-id=${alrId} id="alarm">
	<span>${alrMessage}</span>
	<span>${yy}/${MM}/${dd}</span>
</li>		
		`;
		div.insertAdjacentHTML('afterbegin', html);
		
		const newAlarm = document.querySelector("#new-alarm");
		newAlarm.classList.remove('visually-hidden');
		
		document.querySelectorAll("#alarm").forEach((li) => {
			li.addEventListener('click', (e) => {
				const alrId = e.target.parentElement.dataset.alrId;
				if(alrId == undefined) return;
					const token = $("meta[name='_csrf']").attr("content");
					const header = $("meta[name='_csrf_header']").attr("content");

					$.ajax({
					url : `http://${location.host}/campingez/user/updateAlarm.do`,
					beforeSend: function(xhr) {
						xhr.setRequestHeader(header, token);
					},
					data : {alrId:alrId},
					method : "POST",
					success(response) {
						location.href= `http://${location.host}/campingez` + alrUrl;
					},
					error : console.log
				});
			});
		});
	});
});