<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래게시판" name="title" />
</jsp:include>
<sec:authentication property="principal" var="loginMember" scope="page" />

<!-- Header-->
        <header class="bg-dark py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <h1 class="display-4 fw-bolder">중고거래</h1>
                    <p class="lead fw-normal text-white-50 mb-0">여러분의 물건을 자유롭게 거래하세요!</p>
                    
                </div>
            </div>
        </header>

		
		
		
		<div class="panel">
			<div class="form-inline" style="display:flex; justify-content : center; margin:50px;">
			<br />
				<input class="btn btn-outline-dark mt-auto" type="button" value="텐트/타프" style="margin-right:30px;"/>
				<input class="btn btn-outline-dark mt-auto" type="button" value="캠핑 테이블 가구" style="margin-right:30px;"/>
				<input class="btn btn-outline-dark mt-auto" type="button" value="캠핑용 조리도구" style="margin-right:30px;"/>
				<input class="btn btn-outline-dark mt-auto" type="button" value="기타 캠핑용품" style="margin-right:30px;"/>
				<input class="btn btn-outline-dark mt-auto" type="button" value="전체 상품 보기" >
			</div>
		</div>	

        <!-- Section-->
        <section class="py-5">
        	<div class="container px-4 px-lg-5 mt-5">
            	<div id="list" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
					
        			
          			
                            <div class="col mb-5">
                                <div class="card h-100">
                               
                                </div>
                            </div>
                           
                    </div>
              	</div>
              	<sec:authorize access="isAuthenticated()">
              	<div class="enrollBtn">
              		<input type="hidden" name="cc" />
					<input class="btn btn-outline-dark mt-auto" type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/trade/tradeEnroll.do?'" />
				</div>
				</sec:authorize>
        </section>
        <div id="pagebar" style="text-align:center;"></div>
<script>
const headers = {};
headers['${_csrf.headerName}'] = '${_csrf.token}';
$(document).ready(function(){
	function selectTrade(value){
		$.ajax({
	        url : "${pageContext.request.contextPath}/trade/align.do",
	        type : "GET",
	        headers,
	        data : {
	           categoryId : value
	        },
	        success(data){
				
				$('#list').html('');
				if(data.list == null){
					$('#list').html('<p>등록된 게시물이 없습니다</p>');
				}
				for(var item of data.list){
					var price = item.tradePrice;
					
					var html = '<div class="col mb-5">';
					html += '<div class="card h-100">';
					if(item.tradeSuccess == "거래 대기중"){
					html +=  '<div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>';
					}
					else {
					html += '<div class="badge bg-success text-white position-absolute" style="top: 0.5rem; right: 0.5rem">complete</div>';
					}
					
					for(var photo of item.photos){
						html += '<img src = "${pageContext.request.contextPath}/resources/upload/trade/'
						html += photo.renamedFilename
						html += '"style="width:100%; height:100%;"/>'
						break;
					}
						
					
					html += '<div class="card-body p-4">';
					html += '<div class="text-center">';
					html += '<h5 class="fw-bolder">'
					html += item.tradeTitle
					html += '&nbsp;<img src = "${pageContext.request.contextPath}/resources/images/trade/colorHeart.png" style="width:15px;height:15px;" />' + item.likeCount
					html += '</h5>';
					html += '<p>' + price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원</p>'
					html += '</div>';
					html += '</div>';
					html += '<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">';
					html += '<div class="text-center"><a class="btn btn-outline-dark mt-auto" href="${pageContext.request.contextPath}/trade/tradeView.do?no='
					html += item.tradeNo
					html += ' ">상품 자세히 보기</a></div>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
					
					
					$('#list').append(html);
				}
				
				$('#pagebar').html(data.pagebar)
	 			//const url = "${pageContext.request.contextPath}/trade/tradeList.do?category=" + value;
				//location.replace(url); 
	        },
	        error : console.log
	    });
	} 
	
	selectTrade('all');
	 
	$(".panel").on('click', (e) => {
	    var value = e.target.value == "텐트/타프" ? "tra1" : (e.target.value == "캠핑 테이블 가구" ? "tra2" : (e.target.value == "캠핑용 조리도구") ? "tra3" : (e.target.value == "기타 캠핑용품") ? "tra4" : "all") ;
	    selectTrade(value);
	});
});



</script>
                        

<jsp:include page="/WEB-INF/views/common/footer.jsp" />