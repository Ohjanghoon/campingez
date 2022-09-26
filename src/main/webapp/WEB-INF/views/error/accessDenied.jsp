<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</head>
<body style="text-align: center">
<div class="container p-5">
 	<img class="mb-4" src="${pageContext.request.contextPath}/resources/images/campingEasyLogo.png" alt="" width="150" height="150">
    <h1 class="h3 mb-3 fw-normal"><code>Error!!</code></h1>

    <div class="form-floating p-5">
		<h1>접근권한이 없는 페이지입니다.</h1>
    </div>
	<a  class="w-100 btn btn-lg btn-outline-primary" href="${pageContext.request.contextPath}/">홈으로</a>
</div>
</body>
</html>