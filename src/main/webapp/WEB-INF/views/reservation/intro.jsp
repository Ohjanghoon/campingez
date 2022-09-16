<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<style>
.btn-primary{
 	background-color:  #A8A4CE !important;
 	border-color:  #A8A4CE !important;
}
.btn-outline-secondary{
	border-color: #A8A4CE !important;
	color: #A8A4CE !important;
}
.btn-outline-secondary:hover{
	background-color:  #A8A4CE !important;
	color: white !important;
}
</style>
<main>
	<div class="container">
		<h2 class="text-center fw-bold pt-5">구역별 상세 정보</h2>
		<hr />
		<!-- 데크존 -->
		<div class="container col-xxl-8 px-4 py-5">
		  <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
		    <div class="col-10 col-sm-8 col-lg-6">
		    <div id="carouselExampleDark" class="carousel carousel-dark slide" data-bs-ride="carousel">
			  <div class="carousel-indicators">
			    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="1" class="active" aria-current="true" aria-label="Slide 2"></button>
			    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="2" class="active" aria-current="true" aria-label="Slide 3"></button>
			    <button type="button" data-bs-target="#carouselExampleDark" data-bs-slide-to="4" class="active" aria-current="true" aria-label="Slide 4"></button>
			  </div>
			  <div class="carousel-inner">
			    <div class="carousel-item active" data-bs-interval="4000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/deck1.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="3000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/deck2.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="2000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/deck3.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="1000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/deck4.png" class="d-block w-100" alt="...">
			    </div>
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
		   </div>
		    <div class="col-lg-6">
		      <h3 class="display-5 fw-bold lh-1 mb-3"><i class="fa-solid fa-tents"></i>&nbsp;데크존</h3>
		      <p class="lead">데크존입니다.</p>
		      <div class="d-grid gap-2 d-md-flex justify-content-md-start">
		        <button type="button" class="btn btn-primary btn-sm px-4 me-md-2" onclick="location.href='${pageContext.request.contextPath}/reservation/list.do';">예약하기</button>
		        <button type="button" class="btn btn-outline-secondary btn-sm px-4" id="deck" data-bs-toggle="modal" data-bs-target="#exampleModal1">리뷰보기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="exampleModal1" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"><i class="fa-solid fa-pen"></i> 베스트 리뷰 (데크존)</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-dialog modal-dialog-scrollable deck"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="moveToAllReview">리뷰 전체보기</button>
					</div>
				</div>
			</div>
		</div>
	<!-- 애견존 -->
	<div class="row p-1 pb-0 pe-lg-0 pt-lg-1 align-items-center rounded-3 border shadow-lg">
	<div class="container col-xxl-8 px-4 py-5">
		  <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
		    <div class="col-lg-6">
		      <h3 class="display-5 fw-bold lh-1 mb-3"><i class="fa-solid fa-tents"></i>&nbsp;애견동반존</h3>
		      <p class="lead">애견동반존입니다.</p>
		      <div class="d-grid gap-2 d-md-flex justify-content-md-start">
		        <button type="button" class="btn btn-primary btn-sm px-4 me-md-2" onclick="location.href='${pageContext.request.contextPath}/reservation/list.do';">예약하기</button>
		        <button type="button" class="btn btn-outline-secondary btn-sm px-4" id="animal" data-bs-toggle="modal" data-bs-target="#exampleModal2">리뷰보기</button>
		      </div>
		    </div>
		    <div class="col-10 col-sm-8 col-lg-6">
		    <div id="carouselExampleDark2" class="carousel carousel-dark slide" data-bs-ride="carousel">
			  <div class="carousel-indicators">
			    <button type="button" data-bs-target="#carouselExampleDark2" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			    <button type="button" data-bs-target="#carouselExampleDark2" data-bs-slide-to="1" class="active" aria-current="true" aria-label="Slide 2"></button>
			    <button type="button" data-bs-target="#carouselExampleDark2" data-bs-slide-to="2" class="active" aria-current="true" aria-label="Slide 3"></button>
			    <button type="button" data-bs-target="#carouselExampleDark2" data-bs-slide-to="4" class="active" aria-current="true" aria-label="Slide 4"></button>
			  </div>
			  <div class="carousel-inner">
			    <div class="carousel-item active" data-bs-interval="4000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/animal1.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="3000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/animal2.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="2000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/animal3.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="1000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/animal4.png" class="d-block w-100" alt="...">
			    </div>
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark2" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark2" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
		   </div>
		  </div>
		</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="exampleModal2" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"><i class="fa-solid fa-pen"></i> 베스트 리뷰 (애견동반존)</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-dialog modal-dialog-scrollable animal"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="moveToAllReview">리뷰 전체보기</button>
					</div>
				</div>
			</div>
		</div>
	<!-- 글램핑 -->
	<div class="container col-xxl-8 px-4 py-5">
		  <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
		    <div class="col-10 col-sm-8 col-lg-6">
		    <div id="carouselExampleDark3" class="carousel carousel-dark slide" data-bs-ride="carousel">
			  <div class="carousel-indicators">
			    <button type="button" data-bs-target="#carouselExampleDark3" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			    <button type="button" data-bs-target="#carouselExampleDark3" data-bs-slide-to="1" class="active" aria-current="true" aria-label="Slide 2"></button>
			    <button type="button" data-bs-target="#carouselExampleDark3" data-bs-slide-to="2" class="active" aria-current="true" aria-label="Slide 3"></button>
			    <button type="button" data-bs-target="#carouselExampleDark3" data-bs-slide-to="4" class="active" aria-current="true" aria-label="Slide 4"></button>
			  </div>
			  <div class="carousel-inner">
			    <div class="carousel-item active" data-bs-interval="4000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/glamping1.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="3000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/glamping2.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="2000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/glamping3.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="1000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/glamping4.png" class="d-block w-100" alt="...">
			    </div>
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark3" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark3" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
		   </div>
		    <div class="col-lg-6">
		      <h3 class="display-5 fw-bold lh-1 mb-3"><i class="fa-solid fa-tents"></i>글램핑존</h3>
		      <p class="lead">글램핑존입니다.</p>
		      <div class="d-grid gap-2 d-md-flex justify-content-md-start">
		        <button type="button" class="btn btn-primary btn-sm px-4 me-md-2" onclick="location.href='${pageContext.request.contextPath}/reservation/list.do';">예약하기</button>
		        <button type="button" class="btn btn-outline-secondary btn-sm px-4" id="glamping" data-bs-toggle="modal" data-bs-target="#exampleModal3">리뷰보기</button>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="exampleModal3" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"><i class="fa-solid fa-pen"></i> 베스트 리뷰 (글램핑존)</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-dialog modal-dialog-scrollable glamping"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="moveToAllReview">리뷰 전체보기</button>
					</div>
				</div>
			</div>
		</div>
	<!-- 카라반 -->
	<div class="row p-1 pb-0 pe-lg-0 pt-lg-1 align-items-center rounded-3 border shadow-lg">
	<div class="container col-xxl-8 px-4 py-5">
		  <div class="row flex-lg-row-reverse align-items-center g-5 py-5">
		    <div class="col-lg-6">
		      <h3 class="display-5 fw-bold lh-1 mb-3"><i class="fa-solid fa-tents"></i>&nbsp;카라반존</h3>
		      <p class="lead">카라반존입니다.</p>
		      <div class="d-grid gap-2 d-md-flex justify-content-md-start">
		        <button type="button" class="btn btn-primary btn-sm px-4 me-md-2" onclick="location.href='${pageContext.request.contextPath}/reservation/list.do';">예약하기</button>
		        <button type="button" class="btn btn-outline-secondary btn-sm px-4" id="caravan" data-bs-toggle="modal" data-bs-target="#exampleModal4">리뷰보기</button>
		      </div>
		    </div>
		     <div class="col-10 col-sm-8 col-lg-6">
		    <div id="carouselExampleDark4" class="carousel carousel-dark slide" data-bs-ride="carousel">
			  <div class="carousel-indicators">
			    <button type="button" data-bs-target="#carouselExampleDark4" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			    <button type="button" data-bs-target="#carouselExampleDark4" data-bs-slide-to="1" class="active" aria-current="true" aria-label="Slide 2"></button>
			    <button type="button" data-bs-target="#carouselExampleDark4" data-bs-slide-to="2" class="active" aria-current="true" aria-label="Slide 3"></button>
			    <button type="button" data-bs-target="#carouselExampleDark4" data-bs-slide-to="4" class="active" aria-current="true" aria-label="Slide 4"></button>
			  </div>
			  <div class="carousel-inner">
			    <div class="carousel-item active" data-bs-interval="4000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/caravan1.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="3000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/caravan2.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="2000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/caravan3.png" class="d-block w-100" alt="...">
			    </div>
			    <div class="carousel-item" data-bs-interval="1000">
			      <img src="${pageContext.request.contextPath}/resources/images/reservation/caravan4.png" class="d-block w-100" alt="...">
			    </div>
			  </div>
			  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleDark4" data-bs-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Previous</span>
			  </button>
			  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleDark4" data-bs-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="visually-hidden">Next</span>
			  </button>
			</div>
		   </div>
		  </div>
		</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="exampleModal4" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel"><i class="fa-solid fa-pen"></i> 베스트 리뷰 (카라반존)</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-dialog modal-dialog-scrollable caravan"></div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" id="moveToAllReview">리뷰 전체보기</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
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
					    <p class="card-text"><small class="text-muted">\${review.revEnrollDate}</small></p>
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
					    <p class="card-text"><small class="text-muted">\${review.revEnrollDate}</small></p>
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
					    <p class="card-text"><small class="text-muted">\${review.revEnrollDate}</small></p>
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
					    <p class="card-text"><small class="text-muted">\${review.revEnrollDate}</small></p>
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