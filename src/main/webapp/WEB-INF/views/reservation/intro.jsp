<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<div class="container">
	<h1>캠핑장 소개</h1>
	<div>
		<h3>데크존</h3>
		<img src="${pageContext.request.contextPath}/resources/images/reservation/sample.png" alt="" />
		<div class="accordion-item">
    		<h2 class="accordion-header" id="panelsStayOpen-headingOne">
	      		<button class="accordion-button collapsed" id="deck" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="false" aria-controls="panelsStayOpen-collapseOne">
	        	데크존 리뷰
	      		</button>
    		</h2>
    		<div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingOne">
      			<div class="accordion-body deck"></div>
    		</div>
  		</div>
	</div>
	<div>
		<h3>반려견존</h3>
		<img src="${pageContext.request.contextPath}/resources/images/reservation/sample.png" alt="" />
		<div class="accordion-item">
    		<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
	      		<button class="accordion-button collapsed" id="animal" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
	        	반려견존 리뷰
	      		</button>
    		</h2>
    		<div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
      			<div class="accordion-body animal"></div>
    		</div>
  		</div>
	</div>
	<div>
		<h3>글램핑존</h3>
		<img src="${pageContext.request.contextPath}/resources/images/reservation/sample.png" alt="" />
		<div class="accordion-item">
    		<h2 class="accordion-header" id="panelsStayOpen-headingThree">
	      		<button class="accordion-button collapsed" id="glamping" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
	        	글랭핑존리뷰
	      		</button>
    		</h2>
    		<div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingThree">
      			<div class="accordion-body glamping"></div>
    		</div>
  		</div>
	</div>
	<div>
		<h3>카라반존</h3>
		<img src="${pageContext.request.contextPath}/resources/images/reservation/sample.png" alt="" />
		<div class="accordion-item">
    		<h2 class="accordion-header" id="panelsStayOpen-headingFour">
	      		<button class="accordion-button collapsed" id="caravan" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false" aria-controls="panelsStayOpen-collapseFour">
	        	카라반존 리뷰
	      		</button>
    		</h2>
    		<div id="panelsStayOpen-collapseFour" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingFour">
      			<div class="accordion-body caravan"></div>
    		</div>
  		</div>
	</div>
	<h5>
		<a href="${pageContext.request.contextPath}/reservation/list.do">예약하기</a>
	</h5>
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
<script>
	
	const headers = {};
    headers['${_csrf.headerName}'] = '${_csrf.token}';
    
    // 데크존
	document.querySelector("#deck").addEventListener('click', (e) => {
		// 초기화
		document.querySelector(".deck").innerHTML = "";
		
		$.ajax({
			url : "${pageContext.request.contextPath}/reservation/bestReviewByCampzone.do",
			headers,
			data : { campZone : "ZA" },
			method : "POST",
			success(review){
				console.log(review);
				document.querySelector(".deck").innerHTML += `
					<c:if test="\${not empty review.reviewPhotos}">
						<c:forEach items="\${review.reviewPhotos}" var="photo">
							<img src="\${pageContext.request.contextPath}/resources/upload/review/${photo.revRenamedFilename}" class="card-img-top" alt="...">
						</c:forEach>
					</c:if> 
					<c:if test="\${empty review.reviewPhotos}">
						<img src="\${pageContext.request.contextPath}/resources/images/reservation/noimages.png" alt="card-img-top" />
					</c:if> 
					<div class="card-body">
					    <h5 class="card-title">\${review.reservation.userId}</h5>
					    <p class="card-text">\${review.revContent}</p>
					    <p class="card-text"><small class="text-muted">\${review.revEnrollDate}</small>
						</p>
						<button type="button" id="moveToAllReview">리뷰 더보기</button>
					</div>
				`;
				document.querySelector("#moveToAllReview").addEventListener('click', (e) => {
						const url = `${pageContext.request.contextPath}/review/reviewList.do`;
						const name = "AllReview"; // window의 이름으로 사용;
						const spec = "width=1000px, height=1000px";
						open(url,name, spec);
				});
			},
			error : console.log
		});
	});
    
    // 애견존
	document.querySelector("#animal").addEventListener('click', (e) => {
		document.querySelector(".animal").innerHTML = "";
		$.ajax({
			url : "${pageContext.request.contextPath}/reservation/bestReviewByCampzone.do",
			headers,
			data : { campZone : "ZB" },
			method : "POST",
			success(response){
				console.log(response);
				document.querySelector(".animal").innerHTML += `
					<c:if test="\${not empty review.reviewPhotos}">
						<c:forEach items="\${review.reviewPhotos}" var="photo">
							<img src="\${pageContext.request.contextPath}/resources/upload/review/${photo.revRenamedFilename}" class="card-img-top" alt="...">
						</c:forEach>
					</c:if> 
					<c:if test="\${empty review.reviewPhotos}">
						<img src="\${pageContext.request.contextPath}/resources/images/reservation/noimages.png" alt="card-img-top" />
					</c:if> 
					<div class="card-body">
					    <h5 class="card-title">\${review.reservation.userId}</h5>
					    <p class="card-text">\${review.revContent}</p>
					    <p class="card-text"><small class="text-muted">\${review.revEnrollDate}</small>
						</p>
						<button type="button" id="moveToAllReview">리뷰 더보기</button>
					</div>
				`;
				document.querySelector("#moveToAllReview").addEventListener('click', (e) => {
					const url = `${pageContext.request.contextPath}/review/reviewList.do`;
					const name = "AllReview"; // window의 이름으로 사용;
					const spec = "width=1000px, height=1000px";
					open(url,name, spec);
				});
			},
			error : console.log
		});
	});
	
    // 글램핑존
	document.querySelector("#glamping").addEventListener('click', (e) => {
		document.querySelector(".glamping").innerHTML = "";
		$.ajax({
			url : "${pageContext.request.contextPath}/reservation/bestReviewByCampzone.do",
			headers,
			data : { campZone : "ZC" },
			method : "POST",
			success(review){
				console.log(review);
				document.querySelector(".glamping").innerHTML += `
					<c:if test="\${not empty review.reviewPhotos}">
						<c:forEach items="\${review.reviewPhotos}" var="photo">
							<img src="\${pageContext.request.contextPath}/resources/upload/review/${photo.revRenamedFilename}" class="card-img-top" alt="...">
						</c:forEach>
					</c:if> 
					<c:if test="\${empty review.reviewPhotos}">
						<img src="\${pageContext.request.contextPath}/resources/images/reservation/noimages.png" alt="card-img-top" />
					</c:if> 
					<div class="card-body">
					    <h5 class="card-title">\${review.reservation.userId}</h5>
					    <p class="card-text">\${review.revContent}</p>
					    <p class="card-text"><small class="text-muted">\${review.revEnrollDate}</small>
						</p>
						<button type="button" id="moveToAllReview">리뷰 더보기</button>
					</div>
				`;
				document.querySelector("#moveToAllReview").addEventListener('click', (e) => {
					const url = `${pageContext.request.contextPath}/review/reviewList.do`;
					const name = "AllReview"; // window의 이름으로 사용;
					const spec = "width=1000px, height=1000px";
					open(url,name, spec);
				});
			},
			error : console.log
		});
	});
	
    // 카라반존
	document.querySelector("#caravan").addEventListener('click', (e) => {
		document.querySelector(".caravan").innerHTML = "";
		$.ajax({
			url : "${pageContext.request.contextPath}/reservation/bestReviewByCampzone.do",
			headers,
			data : { campZone : "ZD" },
			method : "POST",
			success(review){
				console.log(review);
				document.querySelector(".caravan").innerHTML += `
					<c:if test="\${not empty review.reviewPhotos}">
						<c:forEach items="\${review.reviewPhotos}" var="photo">
							<img src="\${pageContext.request.contextPath}/resources/upload/review/${photo.revRenamedFilename}" class="card-img-top" alt="...">
						</c:forEach>
					</c:if> 
					<c:if test="\${empty review.reviewPhotos}">
						<img src="\${pageContext.request.contextPath}/resources/images/reservation/noimages.png" alt="card-img-top" />
					</c:if> 
					<div class="card-body">
					    <h5 class="card-title">\${review.reservation.userId}</h5>
					    <p class="card-text">\${review.revContent}</p>
					    <p class="card-text"><small class="text-muted">\${review.revEnrollDate}</small>
						</p>
						<button type="button" id="moveToAllReview">리뷰 더보기</button>
					</div>
				`;
				document.querySelector("#moveToAllReview").addEventListener('click', (e) => {
					const url = `${pageContext.request.contextPath}/review/reviewList.do`;
					const name = "AllReview"; // window의 이름으로 사용;
					const spec = "width=1000px, height=1000px";
					open(url,name, spec);
				});
			},
			error : console.log
		});
	});
    
</script>
</html>