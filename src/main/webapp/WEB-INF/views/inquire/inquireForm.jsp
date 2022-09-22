<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>

<style>
#tbl-inquire-enroll th {
	text-indent : 1.1rem;
	vertical-align : middle;
}
::placeholder {
  color: black;
  font-size: 0.8rem;
}
textarea {
	resize : none;
}
</style>
<div class="w-75 container my-5">
	<sec:authentication property="principal.username" var="loginUser"/>
	<div class="text-center">
		<strong class="fs-3"><i class="fa-regular fa-circle-question"></i> 1:1 문의</strong>
	</div>
	<hr />
	<form:form
		name="inquireFrm"
		action="${pageContext.request.contextPath}/inquire/inquireEnroll.do"
		method="post"
		>
		<table class="table" id="tbl-inquire-enroll">
			<tr>
				<th>제목</th>
				<td><input class="form-control" type="text" name="inqTitle"/></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td> ${loginUser}
					<input type="hidden" name="inqWriter" value="${loginUser}" />
				</td>
			</tr>
			<tr>
				<th>문의유형</th>
				<td>
					<div class="dropdown">
					  <button class="btn btn-outline-primary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
					  문의유형 선택
					  </button>
					  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					    <li class="dropdown-submenu">
					    	<a class="dropdown-item" href="#">Action</a>
					    </li>
					    <li><a class="dropdown-item" href="#">Another action</a></li>
					    <li><a class="dropdown-item" href="#">Something else here</a></li>
					  </ul>
					</div>
				</td>
			</tr>
			
			<tr>
				<td colspan="2">
					<div class="container-fluid">
					<a class="navbar-brand" href="#">Brand</a>
					<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main_nav"  aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="main_nav">
					  <ul class="navbar-nav">
					    <li class="nav-item active"> <a class="nav-link" href="#">Home </a> </li>
					    <li class="nav-item"><a class="nav-link" href="#"> About </a></li>
					    <li class="nav-item dropdown" id="myDropdown">
					      <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">  Treeview menu  </a>
					      <ul class="dropdown-menu">
					        <li> <a class="dropdown-item" href="#"> Dropdown item 1 </a></li>
					        <li> <a class="dropdown-item" href="#"> Dropdown item 2 &raquo; </a>
					          <ul class="submenu dropdown-menu">
					            <li><a class="dropdown-item" href="#">Submenu item 1</a></li>
					            <li><a class="dropdown-item" href="#">Submenu item 2</a></li>
					            <li><a class="dropdown-item" href="#">Submenu item 3 &raquo; </a>
					              <ul class="submenu dropdown-menu">
					                <li><a class="dropdown-item" href="#">Multi level 1</a></li>
					                <li><a class="dropdown-item" href="#">Multi level 2</a></li>
					              </ul>
					            </li>
					            <li><a class="dropdown-item" href="#">Submenu item 4</a></li>
					            <li><a class="dropdown-item" href="#">Submenu item 5</a></li>
					          </ul>
					        </li>
					        <li><a class="dropdown-item" href="#"> Dropdown item 3 </a></li>
					        <li><a class="dropdown-item" href="#"> Dropdown item 4 </a></li>
					      </ul>
					    </li>
					  </ul>
					</div>
					</div>
				</td>
			</tr>
			<tr>
				<th>문의내용</th>
				<td>
					<textarea class="form-control w-100 p-2" name="inqContent" id="inqContent" cols="30" rows="10"
					placeholder="자유롭게 글을 작성할 수 있습니다. 명예훼손이나 상대방을 비방, 불쾌감을 주는 글, 욕설, 남을 모욕하는 글은 임의로 제제가 있을 수 있습니다."></textarea>
				</td>
			</tr>
		</table>
		<div>
			<button type="submit" class="btn btn-primary" id="btn-submit"><strong>작성</strong></button>
		</div>
	</form:form>
</div>
	
<script>

document.addEventListener("DOMContentLoaded", function(){
	// make it as accordion for smaller screens
	if (window.innerWidth < 992) {

	  // close all inner dropdowns when parent is closed
	  document.querySelectorAll('.navbar .dropdown').forEach(function(everydropdown){
	    everydropdown.addEventListener('hidden.bs.dropdown', function () {
	      // after dropdown is hidden, then find all submenus
	        this.querySelectorAll('.submenu').forEach(function(everysubmenu){
	          // hide every submenu as well
	          everysubmenu.style.display = 'none';
	        });
	    })
	  });

	  document.querySelectorAll('.dropdown-menu a').forEach(function(element){
	    element.addEventListener('click', function (e) {
	        let nextEl = this.nextElementSibling;
	        if(nextEl && nextEl.classList.contains('submenu')) {	
	          // prevent opening link if link needs to open dropdown
	          e.preventDefault();
	          if(nextEl.style.display == 'block'){
	            nextEl.style.display = 'none';
	          } else {
	            nextEl.style.display = 'block';
	          }

	        }
	    });
	  })
	}
	// end if innerWidth
	}); 
	// DOMContentLoaded  end
document.querySelector("#btn-submit").addEventListener('click', (e) => {
	const frm = document.inquireFrm;
});

$('.dropdown-submenu > a').submenupicker();

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>