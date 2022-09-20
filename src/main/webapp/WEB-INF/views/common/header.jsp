<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>안녕하세요. 캠핑이지입니다.</title>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://kit.fontawesome.com/e8e5c6b69c.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatbot.css" />
<link rel="icon" type="image/png" sizes="192x192" href="${pageContext.request.contextPath}/resources/images/android-chrome-192x192.png">
<c:if test="${not empty msg}">
	<script>
		alert("${msg}");
	</script>
</c:if>
<style>
* {
	list-style: none;
	padding:0;
	margin:0;
}
a {
	text-decoration: none;
	color: black;
}
.header-layer {
	display: none;
	border: 1px solid black;
	width: 400px;
    overflow: auto;
    position: absolute;
    text-align: left;
    font-size: 13px;
    max-height: 300px;
    z-index:999;
}
.header-layer > * {
	background-color: white;
}
#alarm-list {
	padding: 0;
}
#alarm {
	padding: 5px 5px;
    height: 50px;
}
#alarm-content-wrap {
	width:92%;
	display:flex;
}
#alr-msg {
	width:83%;
  	white-space: nowrap;
  	overflow: hidden;
  	text-overflow: ellipsis;
  	padding-right: 5px;  
}
#badge-wrap {
	width:8%;
	display: flex;
	justify-content: center;
}
#alarm-date-wrap {
	width: 17%;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    padding-right: 2px;
}
#alarm-date {
	font-size:12px;
}
#notReadCount-wrap {
    height: 50px;
    display: flex;
    align-items: center;
    padding: 10px;
}
.tooltip-inner {
	font-size:13px;
	max-width:400px;
	height:30px;
}
</style>
<script>
const beforeTime = (alarmDate) => {
	  const millis = new Date().getTime() - new Date(alarmDate).getTime();
	  const seconds = Math.floor(millis / 1000);
	  
	  if (seconds < 60) {
		  return "방금 전";
	  }
	  const minutes = Math.floor(seconds / 60);
	  if (minutes < 60) {
		  return `\${minutes}분 전`;
	  }
	  const hours = Math.floor(minutes / 60);
	  if (hours < 24) {
		  return `\${hours}시간 전`;
	  }
	  const days = Math.floor(hours / 24);
	  if (days < 7) {
		  return `\${days}일 전`;
	  }
	  const weeks = Math.floor(days / 7);
	  if (weeks < 5) {
		  return `\${weeks}주 전`;
	  }
	  const months = Math.floor(days / 30);
	  if (months < 12) {
		  return `\${month}개월 전`;
	  }
	  const years = Math.floor(days / 365);
	  return `\${years}년 전`;
};
</script>

<sec:authorize access="isAuthenticated()">
	<script>
	const userId = "<sec:authentication property='principal.username'/>";
	
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/ws.js"></script>
	
<script>

// 알림
window.addEventListener('load', (e) => {
	
	$.ajax({
		url : "${pageContext.request.contextPath}/user/getNotReadAlarm.do",
		data : {userId},
		POST : "GET",
		success(notReadCount) {
			if(notReadCount > 0) {
				const newAlarm = document.querySelector("#new-alarm");
				newAlarm.classList.remove("visually-hidden");
			}
		},
		error : console.log
	});
	
	const div = document.querySelector(".header-layer");
	
	$.ajax({
		url : "${pageContext.request.contextPath}/user/alarmList.do",
		data : {userId},
		content : "application/json",
		success(response) {
			const {notReadCount, alarmList} = response;
			
			div.innerHTML = '';
			
			let html = `
			<span id="notReadCount-wrap">
				새소식 &nbsp;<div id="notReadCount">\${notReadCount}</div>
			</span>
			<ul id="alarm-list" class="list-group">
			`;
			
			let targetUrl;
			if(alarmList.length < 1) {
				html += `
					<li id="alarm" class="list-group-item d-flex justify-content-between align-items-center no-alarm">알림이 없습니다.</li>
				`;
			} else {
				alarmList.forEach((alarm) => {
					const {alrId, alrMessage, alrType, alrUrl, alrDatetime, alrReadDatetime} = alarm;
					targetUrl = alrUrl;
					const [yy, MM, dd, HH, mm, ss] = alrDatetime;

					if(!alrReadDatetime) {
						html += `
						<a href="${pageContext.request.contextPath}\${targetUrl}" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="\${alrMessage}">
							<li data-alr-id=\${alrId} id="alarm" class="list-group-item d-flex justify-content-between align-items-center list-group-item-action">
								<span id="badge-wrap">
									<span class="badge bg-danger rounded-pill" id="newBadge">N</span>
								</span>
								<div id="alarm-content-wrap">
									<div id="alr-msg">\${alrMessage}</div>
									<span id="alarm-date-wrap">
										<span id="alarm-date">\${yy}/\${MM}/\${dd} \${HH}:\${mm}:\${ss}</span>
									</span>
								</div>
							</li>
						</a>
						`;							
					} else {
						html += `
						<a href="${pageContext.request.contextPath}\${targetUrl}" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="\${alrMessage}" >
							<li data-alr-id=\${alrId} id="alarm" class="list-group-item d-flex justify-content-between align-items-center list-group-item-secondary">
								<span id="badge-wrap"></span>
								<div id="alarm-content-wrap">
									<div id="alr-msg">\${alrMessage}</div>
									<span id="alarm-date-wrap">
										<span id="alarm-date">\${yy}/\${MM}/\${dd} \${HH}:\${mm}:\${ss}</span>
									</span>
								</div>
							</li>
						</a>
						`;														
					}
				});
			};
			html += `
			</ul>
			`;
			div.insertAdjacentHTML('beforeend', html);
			
			document.querySelectorAll("#alarm-date").forEach((span) => {
				const alarmDate = span.innerHTML;
				span.innerHTML = beforeTime(alarmDate);
			});
			
			document.querySelectorAll("#alarm").forEach((li) => {
				li.addEventListener('click', (e) => {
					const alrId = e.target.offsetParent.dataset.alrId;
					if(alrId == undefined) return;
					
					const headers = {};
					headers['${_csrf.headerName}'] = '${_csrf.token}';
					
					$.ajax({
						url : "${pageContext.request.contextPath}/user/updateAlarm.do",
						headers,
						data : {alrId},
						method : "POST",
						success(response) {
							
						},
						error : console.log
					});
				});
			});
		},
		error : console.log
	});
	
	document.querySelector("#bell").addEventListener('click', (e) => {
		const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
		const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
		
		if(div.style.display == 'none' || !div.style.display) {
			div.style.display = 'block';
		} else {
			div.style.display = 'none';
		}	
	});
});
</script>
</sec:authorize>
</head>
<body>
	<nav class="navbar navbar-light bg-light p-1">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="d-flex align-items-center col-md-3 mb-2 mb-md-0 text-dark text-decoration-none">
              <img src="${pageContext.request.contextPath}/resources/images/campingEasyLogo2.png" alt="" width="200">
            </a>
            <ul class="nav col-12 col-md-auto mb-2 justify-content-center mb-md-0">
              <li><a href="${pageContext.request.contextPath}/" class="nav-link px-2 link-secondary">Home</a></li>
              <li><a href="#" class="nav-link px-2 link-dark">보류</a></li>
              <li><a href="#" class="nav-link px-2 link-dark">보류</a></li>
              <li><a href="#" class="nav-link px-2 link-dark">보류</a></li>
              <li><a href="#" class="nav-link px-2 link-dark">보류</a></li>
            </ul>
            <div class="col-md-2 text-end">
              <sec:authorize access="isAnonymous()">
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userLogin.do';" class="btn btn-outline-primary me-2">Login</button>
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userEnroll.do';" class="btn btn-primary">Sign-up</button>
              </sec:authorize>
              <sec:authorize access="isAuthenticated()">
					<button type="button"
						class="btn btn-light position-relative" id="bell">
						<i class="fa-regular fa-bell fa-lg"></i>
							<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger visually-hidden" id="new-alarm">N 
							<span class="visually-hidden">New alerts</span>
						</span>
					</button>
					<div class="header-layer shadow mb-5 bg-body rounded">
						 
					</div>
                <form:form action="${pageContext.request.contextPath}/user/userLogout.do" method="POST">
                  <button type="submit">로그아웃</button>
                </form:form>
              </sec:authorize>
            </div>
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar">
              <span class="navbar-toggler-icon"></span>
            </button>
          <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
            <div class="offcanvas-header">
              <div>
                <img src="${pageContext.request.contextPath}/resources/images/campingEasyLogo2.png" alt="" width="120">
                <span class="fs-5 fw-semibold">Camping Easy</span>
              </div>
              <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            <div class="offcanvas-body">
              <ul class="list-unstyled ps-0">
                <li class="mb-3">
                  <span><i class="fa-solid fa-bullhorn"></i></span>
                  <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="false">
                    공지사항
                  </button>
                  <div class="collapse" id="home-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                      <li><a href="${pageContext.request.contextPath}/notice/list" class="link-dark rounded p-2">공지사항</a></li>
                    </ul>
                  </div>
                </li>
                <li class="border-top my-3"></li>
                <li class="mb-3">
                  <span><i class="fa-solid fa-tent"></i></span>
                  <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
                    예약 & 양도
                  </button>
                  <div class="collapse" id="dashboard-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                      <li><a href="${pageContext.request.contextPath}/reservation/intro.do" class="link-dark rounded p-2">예약</a></li>
                      <li><a href="${pageContext.request.contextPath}/assignment/assignmentList.do" class="link-dark rounded p-2">양도</a></li>
                    </ul>
                  </div>
                </li>
                <li class="border-top my-3"></li>
                <li class="mb-3">
                  <span><i class="fa-solid fa-pen"></i></span>
                  <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#orders-collapse" aria-expanded="false">
                    커뮤니티
                  </button>
                  <div class="collapse" id="orders-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                      <li><a href="${pageContext.request.contextPath}/trade/tradeList.do" class="link-dark rounded p-2">중고거래</a></li>
                    </ul>
                  </div>
                </li>
                <li class="border-top my-3"></li>
                <li class="mb-3">
                  <span><i class="fa-solid fa-comment-dots"></i></span>
                  <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#market-collapse" aria-expanded="false">
                    1:1 문의
                  </button>
                  <div class="collapse" id="market-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                      <li><a href="${pageContext.request.contextPath}/inquire/inquireList.do" class="link-dark rounded p-2">1:1 문의</a></li>
                    </ul>
                  </div>
                </li>
                <li class="border-top my-3"></li>
                <li class="mb-3">
                <span><i class="fa-solid fa-star-half-stroke"></i></span>
                <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#pass-collapse" aria-expanded="false">
                  리뷰
                </button>
                <div class="collapse" id="pass-collapse">
                  <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                    <li><a href="${pageContext.request.contextPath}/review/reviewList.do" class="link-dark rounded p-2">리뷰</a></li>
                  </ul>
                </div>
              </li>
              <li class="border-top my-3"></li>
              <li class="mb-5">
                <span><i class="fa-solid fa-house-lock"></i></span>
                <button class="btn btn-toggle align-items-center rounded collapsed" data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
                  관리자
                </button>
                <div class="collapse" id="account-collapse">
                  <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                    <li><a href="${pageContext.request.contextPath}/admin/reservationList.do" class="link-dark rounded p-2">관리자페이지</a></li>
                  </ul>
                </div>
                </li>
              </ul>
              <sec:authorize access="isAnonymous()">
                <button type="button" onclick="location.href='${pageContext.request.contextPath}/user/userLogin.do';" class="btn btn-outline-primary me-2">Login</button>
              </sec:authorize>
              <sec:authorize access="isAuthenticated()">
                <div class="dropdown">
                  <a href="#" class="d-flex align-items-center link-dark text-decoration-none dropdown-toggle" id="dropdownUser2" data-bs-toggle="dropdown" aria-expanded="false">
                    <img src="${pageContext.request.contextPath}/resources/images/user.jpeg" alt="" width="32" height="32" class="rounded-circle me-2">
                    <strong><sec:authentication property="principal.username"/><sec:authentication property="authorities" />님, 안녕하세요!</strong>
                  </a>
                  <ul class="dropdown-menu text-small shadow" aria-labelledby="dropdownUser2">
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/userInfo/myPage.do">내정보</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/userInfo/myReservation.do">예약 & 리뷰</a></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/userInfo/myLikeList.do">찜 목록</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/user/userEnroll.do">로그아웃</a></li>
                  </ul>
                </div>
              </sec:authorize>
            </div>
          </div>
        </div>
      </nav>
      <div class="title">
    <div>
        <div id="chatbot" class="main-card ch-collapsed">
    <button id="chatbot_toggle">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
        <path d="M0 0h24v24H0V0z" fill="none" />
        <path
        d="M15 4v7H5.17l-.59.59-.58.58V4h11m1-2H3c-.55 0-1 .45-1 1v14l4-4h10c.55 0 1-.45 1-1V3c0-.55-.45-1-1-1zm5 4h-2v9H6v2c0 .55.45 1 1 1h11l4 4V7c0-.55-.45-1-1-1z" />
      </svg>
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" style="display:none">
        <path d="M0 0h24v24H0V0z" fill="none" />
        <path
        d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12 19 6.41z" />
      </svg>
    </svg>
  </button>
  <div class="main-title">
    <div>
      <svg viewBox="0 0 640 512" title="robot">
        <path fill="currentColor"
        d="M32,224H64V416H32A31.96166,31.96166,0,0,1,0,384V256A31.96166,31.96166,0,0,1,32,224Zm512-48V448a64.06328,64.06328,0,0,1-64,64H160a64.06328,64.06328,0,0,1-64-64V176a79.974,79.974,0,0,1,80-80H288V32a32,32,0,0,1,64,0V96H464A79.974,79.974,0,0,1,544,176ZM264,256a40,40,0,1,0-40,40A39.997,39.997,0,0,0,264,256Zm-8,128H192v32h64Zm96,0H288v32h64ZM456,256a40,40,0,1,0-40,40A39.997,39.997,0,0,0,456,256Zm-8,128H384v32h64ZM640,256V384a31.96166,31.96166,0,0,1-32,32H576V224h32A31.96166,31.96166,0,0,1,640,256Z" />
      </svg>
    </div>
    <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <button class="input-send" style="width: 40px;" type="button" onclick="location.href='${pageContext.request.contextPath}/inquire/inquireList.do';">
      <svg style="width:24px;height:24px">
        <path d="M2,21L23,12L2,3V10L17,12L2,14V21Z" />
      </svg>
    </button>
    <div style="width: 80px; align-items: center;">
      <a href="${pageContext.request.contextPath}/inquire/inquireList.do" style="text-decoration: none; color: white;">문의하기</a>
    </div>
    </div>
    <div id="Accordion_wrap">
      <div class="que">
        <span>자동차 출입이 가능한가요??</span>
      </div>
      <div class="anw">
        <span>
        <ul>
        	<li>21시부터 08시 사이에는 오토캠핑장 자동차 출입을 삼가시기 바랍니다.</li>
        	<li>오토캠핑장 내 차량은 5km 이내로 서행하여야 하며, 잔디밭 출입이나 세차행위는 금합니다.</li>
        	<li><img src="${pageContext.request.contextPath}/resources/images/chatbot/NoCar.png" alt="" /></li>
        </ul>
        </span><br />
      </div>
      <div class="que">
        <span>This is second question.</span>
      </div>
      <div class="anw">
        <span>This is second answer.</span>
      </div>
      <div class="que">
        <span>This is third question.</span>
      </div>
      <div class="anw">
        <span>This is third answer.</span>
      </div>
      <div class="que">
        <span>This is first question.</span>
      </div>
      <div class="que">
        <span>This is first question.</span>
      </div>
    </div>
  </div>
</div>
    </div>
   <script>
  document.getElementById("chatbot_toggle").onclick = function () {
    if (document.getElementById("chatbot").classList.contains("ch-collapsed")) {
      document.getElementById("chatbot").classList.remove("ch-collapsed")
      document.getElementById("chatbot_toggle").children[0].style.display = "none"
      document.getElementById("chatbot_toggle").children[1].style.display = ""
      document.getElementById("chatbot").style.overflowY = "scroll";
      
    }
    else {
      document.getElementById("chatbot").classList.add("ch-collapsed")
      document.getElementById("chatbot_toggle").children[0].style.display = ""
      document.getElementById("chatbot_toggle").children[1].style.display = "none"
      document.getElementById("chatbot").style.overflow = "hidden";
    }
  }

  $(".que").click(function () {
    $(this).next(".anw").stop().slideToggle(300);
    $(this).toggleClass('on').siblings().removeClass('on');
    $(this).next(".anw").siblings(".anw").slideUp(300); // 1개씩 펼치기
  });
</script>