<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
   <jsp:param value="게시판 상세보기" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityView.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<style>
.media{
	border-top:3px dotted #D3D3D3;
	padding-top:15px;
}
</style>


<sec:authorize access="isAuthenticated()" >
	<sec:authentication property="principal" var="loginMember" scope="page" />
</sec:authorize>
	
<h2 class="text-center fw-bold pt-5">${community.categoryId eq 'com1' ? '자유게시판' : '꿀팁게시판'}</h2>
<hr />
	
<section id="trade-container" class="container" style="margin-top:30px;">
         
      <!-- Post header-->
      <header class="mb-4">
	      <!-- Post title-->
	      <h1 class="fw-bolder mb-1">${community.commTitle}</h1>
              <!-- Post meta content-->
              <div class="text-muted fst-italic mb-2">
	              작성자 : ${community.userId} / 작성일 : <fmt:parseDate value="${community.commDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="commDate"/>
	              <fmt:formatDate value="${commDate}" pattern="yy-MM-dd HH:mm"/>
              </div>
          <!-- Post categories-->
          <p class="badge bg-secondary text-decoration-none link-light">${community.categoryId eq 'com1' ? '자유게시판' : '꿀팁게시판'}</p> 
          <p style="text-align:right;">조회수 : ${community.readCount} 신고수 : ${community.reportCount} 좋아요 : ${community.likeCount} </p> 
          <form action="${pageContext.request.contextPath}/community/like.do" name="commLikeFrm" style="text-align:right;">
              <input type="hidden" name="no" value="${community.commNo}" />
              <a class="heart">
                  <img id="heart" src="${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png" style="width:30px; height:30px; cursor:pointer" ></a>
          </form>
          <button type="button" id="report-btn" class="btn btn-outline-dark flex-shrink-0" data-report-user-id="${reportUserId}" data-bs-toggle="modal" data-bs-target="#reportModal">
			<i class="fa-solid fa-land-mine-on"></i> 신고하기
		  </button>
		  
          <hr>
          
      </header>
      
      <!-- Preview image figure-->
      <figure class="mb-4">
      	<c:if test="${not empty community.photos}">
	        <c:forEach items="${community.photos}" var="photo">   
	           <img src ="${pageContext.request.contextPath}/resources/upload/community/${photo.renamedFilename}" id="upload-img">
	        </c:forEach>
        </c:if>
      </figure>
      
      <!-- Post content-->
      <section class="mb-5">
      	<p class="fs-5 mb-4">${community.commContent}</p>
      </section>
      
      		
      <sec:authorize access="isAuthenticated()"> 
         <c:if test="${loginMember.userId eq community.userId}">
         <div>
            <input class="btn btn-outline-dark flex-shrink-0" type="button" value="글수정" onclick="location.href='${pageContext.request.contextPath}/community/communityUpdate.do?no=${community.commNo}';" />
            <input class="btn btn-outline-dark flex-shrink-0" type="button" value="글삭제" id="delete" onclick="deleteComm();" />   
         </div>
         </c:if>
      </sec:authorize>
      
      
      <!-- 댓글 작성부 -->
      <hr style="margin-bottom:50px;"/>
      
      <div class="col-sm-20">   
      <c:if test="${empty user.userId}">
      	<textarea cols="60" rows="2" placeholder="로그인 후 댓글을 작성할 수 있습니다." readonly style="resize:none;"></textarea>
        <button id="btn" class="btn btn-outline-dark flex-shrink-0">등록</button>
      </c:if>
      
      <form name="communityCommentFrm" action="${pageContext.request.contextPath}/community/commentEnroll.do" method="post">
      	<h3 class="pull-left">New Comment</h3>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <input type="hidden" id="commNo" name="commNo" value="${community.commNo}" /> 
        <input type="hidden" id="writer" name="writer" value="${loginMember.userId}" />
        <input type="hidden" name="commentLevel" value="1" /> 
        <input type="hidden" name="commentRef" value="" />

        <div class="form-group col-xs-20 col-sm-13 col-lg-20">
	        <textarea class="form-control" id="cContent" name="cContent" placeholder="댓글을 입력하세요."  style="resize:none;"></textarea>
	        <button type="submit" class="btn btn-normal pull-right" id="enroll-btn">댓글 등록</button>
        </div>   	
      </form>
                    
      <hr style="margin-top:50px;margin-bottom:50px;"/>
                    
      <h3>댓글목록</h3>

	  <c:if test="${not empty commentlist}">
     	 <c:forEach items="${commentlist}" var="comment">
    	  <div class="media">
          	<c:if test="${comment.commentLevel eq 2}">
            	<img id="heart" src="${pageContext.request.contextPath}/resources/images/reply.png" style="width:30px; height:30px;">
            </c:if>
                      
          	<div class="media-body">
            	<h4 class="media-heading">${comment.userId}</h4>
                <p>${comment.commentContent } </p>
                <ul class="list-unstyled list-inline media-detail pull-left">
                	<li><i class="fa fa-calendar"></i>
                    <fmt:parseDate value="${comment.commentDate}" pattern="yyyy-MM-dd'T'HH:mm" var="commentDate"/>
                    <fmt:formatDate value="${commentDate}" pattern="yy-MM-dd"/></li>
                </ul>
                          
                <ul class="list-unstyled list-inline media-detail pull-right">
                	<sec:authorize access="isAuthenticated()"> 
                    <c:if test="${comment.commentLevel eq 1}">
                    	<button class="btn-reply btn btn-outline-dark flex-shrink-0" value="${comment.commentNo}">답글</button>
                    </c:if>
                              
                    <c:if test="${loginMember.userId eq comment.userId}">
                    	<form action="${pageContext.request.contextPath}/community/commentDelete.do">
                        	<input type="hidden" name="commentCommNo" id="commentCommNo" value="${comment.commentCommNo}" />
                            <input type="hidden" name="commentNo" id="commentNo" value="${comment.commentNo}" />
                            <button class="btn-delete btn btn-outline-danger flex-shrink-0" type="submit" style="margin-top:10px;">삭제</button>
                        </form>
		            </c:if>
                    </sec:authorize>
                 </ul>
             </div>
            </div>
           </c:forEach>
         </c:if>
                
                </div>
   			</section>
		    <form:form name="reportFrm" action="${pageContext.request.contextPath}/user/insertReport.do" method="POST">
		        <div class="modal" tabindex="-1" id="reportModal">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title">게시글 신고하기</h5>
				        <button type="button" class="btn-close" data-report-user-id="${reportUserId}" data-bs-dismiss="modal" aria-label="Close"></button>
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
						<input type="hidden" name="commNo" value="${community.commNo}" />
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
//신고 content 글자수
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
function deleteComm(){
   if(confirm("삭제하실건가요?")){
      location.href="${pageContext.request.contextPath}/community/communityDelete.do?no=${community.commNo}";
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
    	
    	const userId = "${user.userId}";
    	if(!userId) {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${pageContext.request.contextPath}/user/userLogin.do";
    		return;
    	}

        var that = $(".heart");

        var sendData = {'commNo' : '${community.commNo}', 'heart' : that.prop('name')};
        $.ajax({
            url :'${pageContext.request.contextPath}/community/heart',
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

function deleteComment(){
	if(confirm("삭제하실건가요?")){
	  location.href="${pageContext.request.contextPath}/community/commentDelete.do?no=${comment.commentCommNo}";
	}else return;
}

document.querySelectorAll(".btn-reply").forEach((btn) => {
	btn.addEventListener('click', (e) => {

		const {value} = e.target;
		console.log(value);
		
		const tr = `
		<tr>
			<td colspan="2" style="text-align:left;">
				<form
		        	name="communityCommentFrm"
					action="${pageContext.request.contextPath}/community/commentEnroll.do" 
					method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						 <input type="hidden" name="commNo" value="${community.commNo}" /> 
				         <input type="hidden" name="writer" value="${loginMember.userId}" />
		            <input type="hidden" name="commentLevel" value="2" />
		            <input type="hidden" name="commentRef" value="\${value}" />    
		            	<div class="form-group col-xs-20 col-sm-13 col-lg-20">
		    	        <textarea class="form-control" id="cContent" name="cContent" placeholder="댓글을 입력하세요." style="resize:none;"></textarea>
		    	        <button type="submit" class="btn btn-normal pull-right" id="enroll-btn">댓글 등록</button>
		            </div>   	   
		        </form>
			</td>
		</tr>`;
		
        const target = e.target.parentElement.parentElement; // tr
        target.insertAdjacentHTML('afterend', tr);
        
	}, {once: true});
});


document.querySelector("#enroll-btn").addEventListener('click', (e) => {
	const content = document.querySelector("#cContent");

	if(!content.value) {
		alert("빈 댓글을 등록할 수 없습니다.");
		content.focus();
		return;
	}

	document.communityCommentEnrollFrm.submit();
});

</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />