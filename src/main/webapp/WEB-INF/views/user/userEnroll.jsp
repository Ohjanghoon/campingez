<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>

<body>
<div id="enroll-container" class="mx-auto text-center">
	<form name="userEnrollFrm" action="" method="POST">
		<table class="mx-auto">
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
						<input type="text" class="form-control"
							placeholder="아이디(4글자이상)" name="userId"
							id="userId" required value="sinsa"> 
					</div>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" class="form-control" name="userName"
					id="userName" value="신사임당" required></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" class="form-control" name="password"
					id="password" value="1234" required></td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td><input type="password" class="form-control"
					id="passwordCheck" value="1234" required></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="email" class="form-control"
					placeholder="abc@xyz.com" name="email" id="email"
					value="honggd@gmail.com"></td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td><input type="tel" class="form-control"
					placeholder="(-없이)01012345678" name="phone" id="phone"
					maxlength="11" value="01098989898" required></td>
			</tr>
			<tr>
				<th>성별</th>
				<td>
					<div class="form-check form-check-inline">
						<input type="radio" class="form-check-input" name="gender" id="gender0" value="M" checked> 
						<label class="form-check-label" for="gender0">남</label>
						&nbsp; 
						<input type="radio" class="form-check-input" name="gender" id="gender1" value="F">
						<label class="form-check-label" for="gender1">여</label>
					</div>
				</td>
			</tr>
		</table>
		<input type="submit" value="가입"> <input type="reset"
			value="취소">
	</form>
</div>
</body>
</html>