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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/tradeView.css" />

<sec:authorize access="isAuthenticated()" >
	<sec:authentication property="principal" var="loginMember" scope="page" />
</sec:authorize>
	
	<header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder" onclick="location.href='${pageContext.request.contextPath}/community/communityList.do';" style="cursor:pointer;">자유게시판</h1>
                    <p class="lead fw-normal text-white-50 mb-0">당신의 글을 작성하세요!</p>
                </div>
            </div>
        </header>
	
   <section id="trade-container" class="container" style="margin-top:30px;">
         
      <!-- Post header-->
                        <header class="mb-4">
                            <!-- Post title-->
                            <h1 class="fw-bolder mb-1">${community.commTitle}</h1>
                            <!-- Post meta content-->
                            <div class="text-muted fst-italic mb-2">
                                작성자 : ${community.userId} / 작성일 : <fmt:parseDate value="${community.commDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="commDate"/>
                                <fmt:formatDate value="${commDate}" pattern="yy-MM-dd HH:mm"/></div>
                            <!-- Post categories-->
                            
                            <p class="badge bg-secondary text-decoration-none link-light">자유게시판</p> 
                            <p style="text-align:right;">조회수 : ${community.readCount} 신고수 : ${community.reportCount} 좋아요 : ${community.likeCount} </p> 
                            <c:if test="${not empty user.userId}">
                                <form action="${pageContext.request.contextPath}/community/like.do" name="commLikeFrm" style="text-align:right;">
                                <input type="hidden" name="no" value="${community.commNo}" />
                                   <a class="heart">
                                      <img id="heart" src="${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png" style="width:30px; height:30px; cursor:pointer" >
                                   </a>
                                   </form>
                                </c:if>
                            <hr>
                        </header>
                        <!-- Preview image figure-->
                        <figure class="mb-4"><c:if test="${not empty community.photos}">
                            <c:forEach items="${community.photos}" var="photo">   
                               <img src ="${pageContext.request.contextPath}/resources/upload/community/${photo.renamedFilename}" id="upload-img">
                            </c:forEach>
                         </c:if></figure>
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
      
      <hr style="margin-bottom:50px;"/>
      
      <div>
      <c:if test="${empty user.userId}">
      	<textarea cols="60" rows="2" placeholder="로그인 후 댓글을 작성할 수 있습니다." readonly style="resize:none;"></textarea>
        <button id="btn" class="btn btn-outline-dark flex-shrink-0">등록</button>
      </c:if>
      
       <c:if test="${not empty user.userId}">
      <div class="comment-container">
               <!-- 댓글 작성부 -->
               <div class="comment-editor">
                  <form name="communityCommentFrm"
                     action="${pageContext.request.contextPath}/community/commentEnroll.do"
                     method="post" style="border-bottom:0px;">
                     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <input type="hidden" id="commNo" name="commNo" value="${community.commNo}" /> 
                        <input type="hidden" id="writer" name="writer" value="${loginMember.userId}" />
                     <input type="hidden" name="commentLevel" value="1" /> 
                     <input type="hidden" name="commentRef" value="" />
                     <textarea name="cContent" cols="60" rows="2" placeholder="댓글을 입력하세요." style="resize:none;"></textarea>
                     <button type="submit" id="btn-comment-enroll1" class="btn btn-outline-dark flex-shrink-0">등록</button>
                     <br>
                  </form>
               </div>
               </div>
      			</c:if>
               
               <c:if test="${not empty commentlist}">
               	<c:forEach items="${commentlist}" var="comment">
               <table id="tbl-comment">
					
                     <tr class="${comment.commentLevel eq 1 ? 'level1' : 'level2'}">
                        <td>
	                        ${comment.commentContent}
	                        <sub class="comment-writer">${comment.userId}</sub>
	                        <sub class="comment-date">
		                         <fmt:parseDate value="${comment.commentDate}" pattern="yyyy-MM-dd'T'HH:mm" var="commentDate"/>
		                         <fmt:formatDate value="${commentDate}" pattern="yy-MM-dd HH:mm"/>
	                        </sub>
	                       
	                    </td>
	                    <td>
	                        <sec:authorize access="isAuthenticated()"> 
		                        <div>
		                         <c:if test="${comment.commentLevel eq 1}">
		                         	<button class="btn-reply btn btn-outline-dark flex-shrink-0" value="${comment.commentNo}">답글</button>
		                         </c:if>
		                         
		                         <c:if test="${loginMember.userId eq comment.userId}">
			                         <form action="${pageContext.request.contextPath}/community/commentDelete.do">
			                  			<input type="hidden" name="cc" value="${comment}" />
			                         	<button class="btn-delete btn btn-outline-danger flex-shrink-0" type="submit">삭제</button>
			                         </form>
		                         </c:if>
		                        </div>
	                        </sec:authorize>
                        </td>
                     </tr>

                  </table>
                  </c:forEach>
      			</c:if>
      			</div>
   </section>
      		
      

<script>
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
					<textarea name="cContent" cols="60" rows="1" style="resize:none;"></textarea>
		            <button type="submit" class="btn-comment-enroll2">등록</button>
		        </form>
			</td>
		</tr>`;
		
        const target = e.target.parentElement.parentElement; // tr
        target.insertAdjacentHTML('afterend', tr);
        
	}, {once: true});
});


</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp" />