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
            <div class="container px-4 px-lg-5 my-5">
                <div class="row gx-4 gx-lg-5 align-items-center">
                    <div class="col-md-6">			
                        <c:forEach items="${trade.photos}" var="photo">			
							<img class="card-img-top mb-5 mb-md-0" src ="${pageContext.request.contextPath}/resources/upload/trade/${photo.renamedFilename}" id="upload-img">	
						</c:forEach>			
                    </div>
                    <div class="col-md-6">
                   		 
                        <div class="small mb-1">${trade.categoryId eq 'tra1' ? '텐트/타프' : trade.categoryId eq 'tra2' ? '캠핑 테이블 가구' : trade.categoryId eq 'tra3' ? '캠핑용 조리도구' : '기타 캠핑용품'}
                        (${trade.tradeQuality}급 : ${trade.tradeQuality eq 'S' ? '상태 좋음' : trade.tradeQuality eq 'A' ? '상태 양호' : '아쉬운 상태'}) </div>
                        <h1 class="display-5 fw-bolder">${trade.tradeTitle}</h1>
                        <div class="fs-5 mb-5">
                            <span><fmt:formatNumber type="number" value="${trade.tradePrice}" />원</span>
                        </div>
                        <p class="lead">
                        <h5 style="font-weight:bold;">상품정보</h5>
                        ${trade.tradeContent}
                        </p>
                        <div class="d-flex">
                            <button id="chatBtn" class="btn btn-outline-dark flex-shrink-0" onclick="location.href='${pageContext.request.contextPath}/chat/chat.do';" type="button">
                                <i class="bi-cart-fill me-1"></i>
                                판매자와 대화하기
                            </button>
                        </div>
                       	<sec:authorize access="isAuthenticated()"> 
                        <div class="d-flex" style="margin-top:10px; height:38px;">
                            <c:if test="${not empty user.userId}">
                            <c:if test="${trade.tradeSuccess eq '거래 대기중'}">
                            <button class="btn btn-outline-success flex-shrink-0" type="button" onclick="updateSuccess();" style="margin-right:10px;">
                                <i class="bi-cart-fill me-1"></i>
                                상품 판매 완료
                            </button>
                            </c:if>
                            <button class="btn btn-outline-danger flex-shrink-0" type="button" onclick="deleteTrade();"">
                                <i class="bi-cart-fill me-1"></i>
                                상품 삭제
                            </button>
                            <button class="btn btn-outline-primary flex-shrink-0" type="button" onclick="location.href='${pageContext.request.contextPath}/trade/tradeUpdate.do?no=${trade.tradeNo}';" style="margin-left:10px;">
                                <i class="bi-cart-fill me-1"></i>
                                상품 수정
                            </button>
                            </c:if>
						</div>
						</sec:authorize>
                        <div class="jobgutdeul" style="text-align:right;">
                            <p>조회수 : ${trade.readCount}</p>
                            <p>좋아요 : ${trade.likeCount} <c:if test="${not empty user.userId}">
							<form action="${pageContext.request.contextPath}/trade/like.do" name="tradeLikeFrm" >
							<input type="hidden" name="no" value="${trade.tradeNo}" />
								<a class="heart">
									<img id="heart" src="${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png" style="width:30px; heigh:30px; cursor:pointer" >
								</a>
							</form>
							<button type="button" id="report-btn" data-report-user-id="${reportUserId}" data-bs-toggle="modal" data-bs-target="#reportModal">신고하기 <i class="fa-solid fa-land-mine-on"></i></button>
						</c:if>
                        </div>
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

// 신고
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

        var that = $(".heart");

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
		localStorage.setItem("tradeNo", ${tradeNo});
	});
});

</script>





<jsp:include page="/WEB-INF/views/common/footer.jsp" />