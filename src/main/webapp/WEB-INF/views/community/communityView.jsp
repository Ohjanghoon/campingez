<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="게시판 상세보기" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/tradeView.css" />
<sec:authentication property="principal" var="loginMember" scope="page" />

	<section id="trade-container" class="container">
		<sec:authorize access="isAuthenticated()"> 
			<c:if test="${loginMember.userId eq community.userId}">
				<input type="button" value="글수정" onclick="location.href='${pageContext.request.contextPath}/community/communityUpdate.do?no=${community.commNo}';" />
				<input type="button" value="글삭제" id="delete" onclick="deleteComm();" />	
			</c:if>
		</sec:authorize>

			
		<table id="tbl-comm">
	
					<tr>
						<th>번호</th>
							<td id="commNo">${community.commNo}</td>
						<th>작성자</th>
							<td>${community.userId}</td>
						<th>제목</th>
							<td>${community.commTitle}</td>
						<th>내용</th>
							<c:if test="${not empty community.photos}">
								<c:forEach items="${community.photos}" var="photo">	
									<td><img src ="${pageContext.request.contextPath}/resources/upload/community/${photo.renamedFilename}" id="upload-img"></td>
								</c:forEach>
							</c:if>
							<td>${community.commContent}</td>
						<th>작성일</th>
							<td>
							<fmt:parseDate value="${community.commDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="commDate"/>
					    		<fmt:formatDate value="${commDate}" pattern="yy-MM-dd HH:mm"/>
							</td>
						<th>카테고리</th>
							<td id="categoryId">${community.categoryId}</td>
							<%-- <c:if test="${trade.categoryId} == 'tra1' ? '텐트/타프' : ${trade.categoryId} == 'tra2' ? '캠핑 테이블 가구' : ${trade.categoryId} == 'tra3' ? '캠핑용 조리도구' : '기타 캠핑용품'"></c:if> --%>						
							<th>조회수</th>
							<td id="readCount">${community.readCount}</td>
						<th>신고수</th>
							<td>${community.reportCount}</td>
						<th>삭제여부</th>
						<td>
							${community.isDelete eq 'N' ? '삭제안됨' : '삭제됨' }
						</td>
						<th>좋아요수<th> 
						<td>
						<c:if test="${not empty user.userId}">
						<form action="${pageContext.request.contextPath}/community/like.do" name="commLikeFrm" >
						<input type="hidden" name="no" value="${community.commNo}" />
							<a class="heart">
								<img id="heart" src="${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png" style="width:30px; heigh:30px; cursor:pointer" >
							</a>
							</form>
						</c:if>
							${community.likeCount}
						</td>
						</tr>
	
	
		</table>
	</section>


<script>
// 게시글 삭제
function deleteComm(){
	if(confirm("삭제하실건가요?")){
		location.href="${pageContext.request.contextPath}/community/communityDelete.do?no=${trade.tradeNo}";
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




</script>





<jsp:include page="/WEB-INF/views/common/footer.jsp" />