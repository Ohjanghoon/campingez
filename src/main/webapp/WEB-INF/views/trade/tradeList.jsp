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
<style>
.selected {
	background-color : #212529;
	color: white;
	border:none;
}
</style>
<h2 class="text-center fw-bold pt-5">중고거래</h2>
        <hr />
		<div class="panel">
			<div class="form-inline" style="display:flex; justify-content : center; margin:50px;">
			<br />
				<input class="btn btn-outline-dark mt-auto category" type="button" value="텐트/타프" style="margin-right:30px;"/>
				<input class="btn btn-outline-dark mt-auto category" type="button" value="캠핑 테이블 가구" style="margin-right:30px;"/>
				<input class="btn btn-outline-dark mt-auto category" type="button" value="캠핑용 조리도구" style="margin-right:30px;"/>
				<input class="btn btn-outline-dark mt-auto category" type="button" value="기타 캠핑용품" style="margin-right:30px;"/>
				<input class="btn btn-outline-dark mt-auto category" type="button" value="전체 상품 보기" >
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
              	<sec:authorize access="isAuthenticated()">
              	<div class="enrollBtn" style="width:auto; display:flex; justify-content: flex-end;">
					<input class="btn btn-outline-dark mt-auto" type="button" value="글쓰기" onclick="location.href='${pageContext.request.contextPath}/trade/tradeEnroll.do?'" />
				</div>
				</sec:authorize>
              	</div>
        </section>
        <div id="pagebar" style="text-align:center;"></div>
<script>
const headers = {};
headers['${_csrf.headerName}'] = '${_csrf.token}';
$(document).ready(function(){
	function selectTrade(value, cPage){
		$.ajax({
	        url : "${pageContext.request.contextPath}/trade/align.do",
	        type : "GET",
	        headers,
	        data : {
	           categoryId : value,
	           cPage
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
					html += '<p class="fw-bolder">' + price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + '원</p>'
					html += '<p>' + item.userId + '</p>'
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
				
				// 페이지 이동
				document.querySelectorAll(".paging").forEach((span) => {
					span.addEventListener('click', (e) => {
						const pageNo = e.target.id.substring(4);
						selectTrade(value, pageNo);
						
						const buttons = document.querySelectorAll(".category");
						for(let i = 0; i < buttons.length; i++) {
							if(buttons[i].classList.contains('selected')) {
								selectCategory(buttons[i].value);
							}
						}
					});
				});
	        },
	        error : console.log
	    });
	} 
	
	selectTrade('all', 1);
	
	// 카테고리 선택 처리
	const selectCategory = (value) => {		
		const buttons = document.querySelectorAll(".category");
		for(let i = 0; i < buttons.length; i++) {
			if(buttons[i].value == value) {
				buttons[i].classList.add('selected');
			} else {
				buttons[i].classList.remove('selected');
			}
		}
	};
	
	document.querySelectorAll(".category").forEach((btn) => {
		btn.addEventListener('click', (e) => {
			const value = btn.value == "텐트/타프" ? "tra1" : (btn.value == "캠핑 테이블 가구" ? "tra2" : (btn.value == "캠핑용 조리도구") ? "tra3" : (btn.value == "기타 캠핑용품") ? "tra4" : "all") ;

			selectTrade(value);
		    selectCategory(btn.value);
		})
	});
});
</script>
                        

<jsp:include page="/WEB-INF/views/common/footer.jsp" />