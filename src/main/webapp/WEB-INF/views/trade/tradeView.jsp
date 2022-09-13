<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래 상세보기" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/trade/tradeView.css" />
<sec:authentication property="principal" var="loginMember" scope="page" />

	<section id="trade-container" class="container">
		<sec:authorize access="isAuthenticated()"> 
			<c:if test="${loginMember.userId eq trade.userId}">
				<input type="button" value="글수정" onclick="location.href='${pageContext.request.contextPath}/trade/tradeUpdate.do?no=${trade.tradeNo}';" />
				<input type="button" value="글삭제" id="delete" onclick="deleteTrade();" />	
			</c:if>
		</sec:authorize>

			
		<table id="tbl-trade">
	
	
		
	
					<tr>
						<th>번호</th>
							<td id="tradeNo">${trade.tradeNo}</td>
						<th>작성자</th>
							<td>${trade.userId}</td>
						<th>제목</th>
							<td>${trade.tradeTitle}</td>
						<th>내용</th>
							<c:if test="${not empty trade.photos}">
								<c:forEach items="${trade.photos}" var="photo">	
									<td><img src ="${pageContext.request.contextPath}/resources/upload/trade/${photo.renamedFilename}" id="upload-img"></td>
								</c:forEach>
							</c:if>
							<td>${trade.tradeContent}</td>
						<th>작성일</th>
							<td>
							<fmt:parseDate value="${trade.tradeDate}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="tradeDate"/>
					    		<fmt:formatDate value="${tradeDate}" pattern="yy-MM-dd HH:mm"/>
							</td>
						<th>조회수</th>
							<td id="readCount">${trade.readCount}</td>
						<th>가격</th>
							<td>
							<fmt:formatNumber type="number" value="${trade.tradePrice}" />원</td>
						<th>거래현황</th>
							<td>${trade.tradeSuccess}</td>
						<th>상품상태</th>
						<td>
							${trade.tradeQuality == 'S' ? '상태좋음(S급)' : trade.tradeQuality == 'A' ? '상태 양호(A급)' : '상태 아쉬움(B급)'}
						</td>
						<th>좋아요수<th> 
						<td>
						<c:if test="${not empty user.userId}">
						<form action="${pageContext.request.contextPath}/trade/like.do" name="tradeLikeFrm" >
						<input type="hidden" name="no" value="${trade.tradeNo}" />
							<a class="heart">
								<img id="heart" src="${pageContext.request.contextPath}/resources/images/trade/emptyHeart.png" style="width:30px; heigh:30px; cursor:pointer" >
							</a>
							</form>
						</c:if>
							${trade.likeCount}
						</td>
						</tr>
	
	
		</table>
	</section>


<script>
// 게시글 삭제
function deleteTrade(){
	if(confirm("삭제?")){
		location.href="${pageContext.request.contextPath}/trade/tradeDelete.do?no=${trade.tradeNo}";
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

        var sendData = {'tradeNo' : '${trade.tradeNo}','heart' : that.prop('name')};
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




</script>





<jsp:include page="/WEB-INF/views/common/footer.jsp" />