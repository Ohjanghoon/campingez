const ws = new SockJS(`http://${location.host}/campingez/stomp`);
const stompClient = Stomp.over(ws);

stompClient.connect({}, (frame) => {
	console.log("connect : ", frame);
	
	stompClient.subscribe("/app/notice", (message) => {
		console.log("app/notice : ", message);
	});
	
	stompClient.subscribe(`/app/notice/${userId}`, (message) => {
		console.log(`app/notice/${userId} : `, message);
		const ul = document.querySelector("#alarm-list");
		const {body} = message;
		const {alarm, notReadCount} = JSON.parse(body);
		const {alrId, alrMessage, alrType, alrUrl, alrDatetime, alrReadDatetime} = alarm;
		const [yy, MM, dd, HH, mm, ss] = alrDatetime;
		const targetUrl = alrUrl == null ? '#' : `http://${location.host}/campingez${alrUrl}`;
	
		let html;
		const notReadCountSpan = document.querySelector("#notReadCount");
		notReadCountSpan.innerHTML = notReadCount;
		
		const date = `${yy}/${MM}/${dd} ${HH}:${mm}:${ss}`;
		console.log(date);
		const alrDate = beforeTime(date);
		
		document.querySelectorAll("#alarm").forEach((li) => {
			if(li.className.includes('no-alarm')) {
				ul.innerHTML = '';
			}
		});
		
		if(!alrReadDatetime) {
			html = `
			<li data-alr-id=${alrId} id="alarm" class="list-group-item d-flex justify-content-between align-items-center list-group-item-action alarmList" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="${alrMessage}">
				<span id="badge-wrap">
					<span class="badge bg-danger rounded-pill" id="newBadge">N</span>
				</span>
				<div id="alarm-content-wrap">
					<div id="alr-msg">${alrMessage}</div>
					<span id="alarm-date-wrap">
						<span id="alarm-date">${alrDate}</span>
					</span>
				</div>
			</li>
			`;							
		} else {
			html = `
			<li data-alr-id=${alrId} id="alarm" class="list-group-item d-flex justify-content-between align-items-center list-group-item-secondary alarmList" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="${alrMessage}">
				<span id="badge-wrap"></span>
				<div id="alarm-content-wrap">
					<div id="alr-msg">${alrMessage}</div>
					<span id="alarm-date-wrap">
						<span id="alarm-date">${alrDate}</span>
					</span>
				</div>
			</li>
			`;														
		}
		ul.insertAdjacentHTML('afterbegin', html);

		const newAlarm = document.querySelector("#new-alarm");
		newAlarm.classList.remove('visually-hidden');
		
		document.querySelectorAll("#alarm").forEach((li) => {
			li.addEventListener('click', (e) => {
				const alrId = e.target.offsetParent.dataset.alrId;
				console.log(alrId);
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
						$('.alarmList').tooltip('hide');
						location.href = `${targetUrl}`;
						getAlarmList(userId);
					},
					error : console.log
				});
			});
		});
	});
});