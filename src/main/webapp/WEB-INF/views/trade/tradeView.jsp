<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래 상세보기" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/trade/view.css" />
<sec:authentication property="principal" var="loginMember" scope="page" />
<style>
.content-wrap {
	background-size: contain;
    background-repeat: no-repeat;
    padding-left:15px;
}
.content {
     background-color: #ffffff;
     background-color: rgba( 255, 255, 255, 0.8 );	
}
.trade-footer-wrap {
    height: 75px;
    background-color: #d3d3d352;
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
	
}
.likeAndview-wrap {
	height: 40px;
}
.content {
  --bs-gutter-x: 1.5rem;
  --bs-gutter-y: 0;
  display: flex;
  flex-wrap: wrap;
  margin-top: calc(-1 * var(--bs-gutter-y));
  margin-right: calc(-0.5 * var(--bs-gutter-x));
  margin-left: calc(-0.5 * var(--bs-gutter-x));
  width:70%;
}
.content > * {
  flex-shrink: 0;
  width: 100%;
  max-width: 100%;
  padding-right: calc(var(--bs-gutter-x) * 0.5);
  padding-left: calc(var(--bs-gutter-x) * 0.5);
  margin-top: var(--bs-gutter-y);
}

.likeAndview-wrap > *{
	padding: 0 10px;
	font-size: 14px;
	color: gray;
}
.jobgutdeul {
	width: 50%;
}
.chat-wrap {
	display: flex;
    width: 50%;
    justify-content: flex-end;
    padding-right: 30px;
}
.heart {
	padding: 0 20px;
}

#report-btn {
    color: #ff0000c4;
    border: 1px solid #ff0000c4;
}

#report-btn:hover {
    background-color: #ff00008f;
    color: white;
    border: none;
}
</style>


			
<!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder" onclick="location.href='${pageContext.request.contextPath}/trade/tradeList.do';" style="cursor:pointer;">중고거래</h1>
                    <p class="lead fw-normal text-white-50 mb-0">당신의 물건을 보다 쉽게 사고, 파세요</p>
                </div>
            </div>
        </header>
        
        <!-- Product section-->  
        <section class="py-5">
            <div class="container px-4 px-lg-5 my-5 d-flex justify-content-center">
                <div class="row gx-4 gx-lg-5 align-items-center content">
                    <div class="col-md-6 photo-wrap">
                    	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
						  <ol class="carousel-indicators">
						    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
						    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						  </ol>
						  <div class="carousel-inner">
  	                       <c:forEach items="${trade.photos}" var="photo">			
						    <div class="carousel-item active">
								<img class="card-img-top mb-5 mb-md-0 d-block w-100" src ="${pageContext.request.contextPath}/resources/upload/trade/${photo.renamedFilename}" id="upload-img">	
						    </div>
						   </c:forEach>	
						  </div>
						  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="sr-only">Previous</span>
						  </a>
						  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="sr-only">Next</span>
						  </a>
						</div>	
                    </div>
                    <div class="col-md-6 content-wrapper">
						<div class="card">
							<div class="content-wrap">
								<div class="content card-body">
									<div class="small mb-1">${trade.categoryId eq 'tra1' ? '텐트/타프' : trade.categoryId eq 'tra2' ? '캠핑 테이블 가구' : trade.categoryId eq 'tra3' ? '캠핑용 조리도구' : '기타 캠핑용품'}
										(${trade.tradeQuality}급 : ${trade.tradeQuality eq 'S' ? '상태 좋음' : trade.tradeQuality eq 'A' ? '상태 양호' : '아쉬운 상태'})
									</div>
									<h1 class="display-5 fw-bolder">${trade.tradeTitle}</h1>
									<div class="fs-5 mb-5">
										<span><fmt:formatNumber type="number"
												value="${trade.tradePrice}" />원</span>
									</div>
									<h5 style="font-weight: bold;">상품정보</h5>
									<p class="lead">${trade.tradeContent}</p>
								</div>
							</div>
							<div class="likeAndview-wrap d-flex align-items-center">
								<span>조회 ${trade.readCount}</span>
								<span>관심 ${trade.likeCount}</span>
							</div>
							<div class="trade-footer-wrap">
								<div class="jobgutdeul d-flex" style="text-align: right;">
									<form action="${pageContext.request.contextPath}/trade/like.do" name="tradeLikeFrm" class="d-flex align-items-center">
										<input type="hidden" name="no" value="${trade.tradeNo}" /> 
										<a class="heart"> 
											<img id="heart" src="${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png" style="width: 30px; heigh: 30px; cursor: pointer">
										</a>
									</form>
									<button type="button" id="report-btn" class="btn btn-outline-dark flex-shrink-0" data-report-user-id="${reportUserId}" data-bs-toggle="modal" data-bs-target="#reportModal">
										<i class="fa-solid fa-land-mine-on"></i> 신고하기
									</button>
								</div>
								<div class="chat-wrap">
									<button id="chatBtn" class="btn btn-outline-dark flex-shrink-0" onclick="location.href='${pageContext.request.contextPath}/chat/chat.do';" type="button">
										<i class="fa-regular fa-comment-dots"></i> 판매자와 대화하기
									</button>
								</div>
							</div>
						</div>
						<sec:authorize access="isAuthenticated()"> 
	                        <div class="d-flex" style="margin-top:20px; height:38px;">
                            <c:if test="${not empty user.userId}">
                            <c:if test="${trade.tradeSuccess eq '거래 대기중'}">
                            <button class="btn btn-outline-success flex-shrink-0" type="button" onclick="updateSuccess();" style="margin-right:10px;">
                                <i class="bi-cart-fill me-1"></i>
                                상품 판매 완료
                            </button>
                            </c:if>
                            <button class="btn btn-outline-danger flex-shrink-0" type="button" onclick="deleteTrade();">
                                <i class="bi-cart-fill me-1"></i>
                                상품 삭제
                            </button>
                            <button class="btn btn-outline-primary flex-shrink-0" type="button" onclick="location.href='${pageContext.request.contextPath}/trade/tradeUpdate.do?no=${trade.tradeNo}';" style="margin-left:10px;">
                                <i class="fa-regular fa-pen-to-square"></i>
                                상품 수정
                            </button>
                            </c:if>
						</div>
						</sec:authorize>
                    </div>
                </div>
            </div>
        </section>
        <!-- 신고 모달창 -->
        <form:form name="reportFrm" action="${pageContext.request.contextPath}/user/insertReport.do" method="POST">
	        <div class="modal" tabindex="-1" id="reportModal">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title">게시글 신고하기</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <div class="modal-body">
			      	<div class="form-floating">
				      	<select name="reportType" id="report-type" class="form-select" aria-label="Floating label select example" >
				      		<option value="" selected disabled>선택</option>
				      		<c:forEach items="${categoryList}" var="category">
					      		<option value="${category.categoryId}">${category.categoryName}</option>				      		
				      		</c:forEach>
				      	</select>
				      	<label for="reportType">신고유형</label>
			      	</div>
			      	<div class="form-floating">
					  <textarea class="form-control" name="reportContent" placeholder="신고사유" id="report-content" style="height: 100px"></textarea>
					  <label for="report-content">신고사유(10자 이상 작성)</label>
					</div>
					(<span id="text-count">0</span>/1000)
					<span id="text-count-info"></span>
					<input type="hidden" name="commNo" value="${trade.tradeNo}" />
					<input type="hidden" name="userId" value="${loginMember != 'anonymousUser' ? loginMember.userId : ''}" />
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary" id="report">신고<i class="fa-solid fa-land-mine-on"></i></button>
			      </div>
			    </div>
			  </div>
			</div>
        </form:form>
<script>
// 신고 content 글자수
document.querySelector("#report-content").addEventListener('input', (e) => {
	const count = document.querySelector("#text-count");
	count.innerHTML = e.target.value.length;
	
	if(e.target.value.length < 10) {
		count.style.color = 'red';
	} else {
		count.style.color = 'black';
	}
});

document.querySelector("#report-btn").addEventListener('click', (e) => {
	const userId = "${user.userId}";
	if(!userId) {
		alert("로그인 후 이용 가능합니다.");
		location.href = "${pageContext.request.contextPath}/user/userLogin.do";
		$('#reportModal').modal('hide');
		return;
	}
});

// 최종 신고
document.querySelector("#report").addEventListener('click', (e) => {
	const count = document.querySelector("#text-count");
	const countInfo = document.querySelector("#text-count-info");
	const reportType = document.querySelector("#report-type");
	
	// 글자수 체크
	if(count.innerHTML < 10 || !reportType.value) {
		countInfo.innerHTML = '신고유형을 반드시 선택하거나 신고사유를 10자 이상으로 작성해주세요';
		return;
	} else {
		countInfo.innerHTML = '';
		if(confirm('해당 게시글을 정말로 신고하시겠습니까?')) {
			document.reportFrm.submit();
		}
	}
});

// 이미 신고한 게시글이라면 모달창 안 열림
document.querySelector("#reportModal").addEventListener('show.bs.modal', (e) => {
	const reportUserId = document.querySelector("#report-btn").dataset.reportUserId;
	
	if(reportUserId) {
		alert('이미 신고 접수가 된 게시글입니다.');
		e.preventDefault();
	}
});

// 게시글 삭제
function deleteTrade(){
	if(confirm("삭제하실건가요?")){
		location.href="${pageContext.request.contextPath}/trade/tradeDelete.do?no=${trade.tradeNo}";
	}else return;
}

// 상품 판매 완료 버튼(완전 야매버전)
function updateSuccess(){
	if(confirm("상품 판매가 완료되었나요?")){
		location.href="${pageContext.request.contextPath}/trade/tradeSuccess.do?no=${trade.tradeNo}";
		location.replace("${pageContext.request.contextPath}/trade/tradeView.do?no=${trade.tradeNo}");
	}else return;
}


// 조회수 새로고침
window.onload = function() {
    if(!window.location.hash) {
        window.location = window.location + '#1';
        setTimeout(function(){
        window.location.reload();
        }, 50)
    }
}

//좋아요
const headers = {};
headers['${_csrf.headerName}'] = '${_csrf.token}';

$(document).ready(function () {
	// 판매완료여부 확인/
	const success = '${trade.tradeSuccess}';
	if(success == '거래완료') {
		document.querySelector(".content-wrap").style.backgroundImage= 	"url('${pageContext.request.contextPath}/resources/images/trade/salecomplete.png')";
	}

    var heartval = ${heart};

    if(heartval > 0) {
        console.log(heartval);
        $("#heart").prop("src", "${pageContext.request.contextPath}/resources/images/trade/colorHeart.png");
        $(".heart").prop('name',heartval)
    }
    else {
        console.log(heartval);
        $("#heart").prop("src", "${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png");
        $(".heart").prop('name',heartval)
    }

    $(".heart").on("click", function () {
    	const userId = "${user.userId}";
        var that = $(".heart");
        
		if(!userId) {
			alert("로그인 후 이용 가능합니다.");
			location.href = "${pageContext.request.contextPath}/user/userLogin.do";
			return;
		} 
        var sendData = {'tradeNo' : '${trade.tradeNo}', 'heart' : that.prop('name')};
        $.ajax({
            url :'${pageContext.request.contextPath}/trade/heart',
            headers,
            type :'POST',
            data : sendData,
            success : function(data){
                that.prop('name',data);
                if(data==1) {
                    $('#heart').prop("src","${pageContext.request.contextPath}/resources/images/trade/colorHeart.png");
                    alert("좋아요 등록!");
                    
                }
                else{
                    $('#heart').prop("src","${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png");
                    alert("좋아요 취소!");
                }
                    window.location.reload();


            }
        });
    });
});


$(document).ready(function () {
	$("#chatBtn").on('click', (e) => {
		const userId = "${user.userId}";
		if(!userId) {
			alert("로그인 후 이용 가능합니다.");
			location.href = "${pageContext.request.contextPath}/user/userLogin.do";
			return;
		}
		localStorage.setItem("tradeNo", ${tradeNo});
	});
});

</script>





<jsp:include page="/WEB-INF/views/common/footer.jsp" />