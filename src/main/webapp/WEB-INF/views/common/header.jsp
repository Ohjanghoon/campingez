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
<sec:authorize access="isAuthenticated()">
	<script>
	const userId = "<sec:authentication property='principal.username'/>";
	</script>
	<script src="${pageContext.request.contextPath}/resources/js/ws.js"></script>
</sec:authorize>
<style>
.header-layer {
	display: none;
}
</style>
<script>
window.addEventListener('load', (e) => {
	document.querySelector("#bell").addEventListener('click', (e) => {
		const div = document.querySelector(".header-layer");
		
		if(div.style.display == 'none') {
			div.style.display = 'block';
		} else {
			div.style.display = 'none';
		}
		
	});
})
</script>
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
              	<span id="bell">알림</span>
       			<div class="header-layer">
					<p>하이</p>	
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
                    <li><a href="${pageContext.request.contextPath}/admin/admin.do" class="link-dark rounded p-2">관리자페이지</a></li>
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
                    <li><a class="dropdown-item" href="#">찜 목록</a></li>
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
          <span>자주묻는 질문</span>
        </div>
        <div id="Accordion_wrap">
          <div class="que">
            <span>This is first question.</span>
          </div>
          <div class="anw">
            <span>This is first answer.</span>
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
        </div>
      </div>
    </div>
    <script>
      document.getElementById("chatbot_toggle").onclick = function () {
        if (document.getElementById("chatbot").classList.contains("ch-collapsed")) {
          document.getElementById("chatbot").classList.remove("ch-collapsed")
          document.getElementById("chatbot_toggle").children[0].style.display = "none"
          document.getElementById("chatbot_toggle").children[1].style.display = ""
        }
        else {
          document.getElementById("chatbot").classList.add("ch-collapsed")
          document.getElementById("chatbot_toggle").children[0].style.display = ""
          document.getElementById("chatbot_toggle").children[1].style.display = "none"
        }
      }

      $(".que").click(function () {
        $(this).next(".anw").stop().slideToggle(300);
        $(this).toggleClass('on').siblings().removeClass('on');
        $(this).next(".anw").siblings(".anw").slideUp(300); // 1개씩 펼치기
      });
    </script>