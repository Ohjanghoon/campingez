<%@page import="java.time.Duration"%>
<%@page import="java.util.Date"%>
<%@page import="com.kh.campingez.reservation.model.dto.Reservation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	Reservation res = (Reservation) request.getAttribute("payRes");
	String payMethod = "";
	String schedule = "";
	
	if(res != null){
		payMethod = res.getResPayment();
		System.out.println(payMethod);
		
		if(payMethod != null){
			switch(res.getResPayment()){
			case "카드" : payMethod = "card"; break;
			case "무통장입금" : payMethod = "vbank"; break;
			}
		}

		String checkInOut = res.getResCheckin() + " ~ " + res.getResCheckout();
		int betDay = (int) Duration.between(res.getResCheckin().atStartOfDay(), res.getResCheckout().atStartOfDay()).toDays();
		schedule = checkInOut + " ("+ betDay + "박" + (betDay+1) + "일)";
		
		
	}
	
	
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>결제페이지</title>
</head>
<body>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <script>
	window.onload = () => {
		console.log("${payMethod}");
		console.log("${payRes.resNo}_" + new Date().getTime());
		
		var IMP = window.IMP; // 생략가능
		IMP.init('imp63276768');  // 가맹점 식별 코드
		IMP.request_pay({
			pg : 'html5_inicis', // 결제방식
			pay_method : '<%= payMethod %>',    // 결제 수단
			merchant_uid : '${payRes.resNo}_new Date().getTime()' ,
			name : '${payRes.campId}/<%= schedule %>',    // order 테이블에 들어갈 주문명 혹은 주문 번호
			amount : '1',    // 결제 금액
			buyer_name : '${payRes.resUsername}',   //주문자명(=예약자명)
			buyer_tel : '${payRes.resPhone}',
			buyer_email : ''
		}, function(rsp) {
   	     if (rsp.success) { // 성공시
   	    	
			const headers = {};
   			headers['${_csrf.headerName}'] = '${_csrf.token}';
   	    	 
   	    	 $.ajax({
   	    		url : '${pageContext.request.contextPath}/payment/paymentSuccess.do',
   	    		headers,
   	    		method : 'POST',
   	    		data : {resNo : "${payRes.resNo}"},
   	    		success(response){
   	    			console.log(response);
   	    			var msg = '-------------------------------------';
   	    			msg += '\n예약/결제가 완료되었습니다.';
   	    			msg += '\n예약자 : ${payRes.resUsername}';
   	    			msg += '\n예약내용 : ${payRes.campId} / <%= schedule %>';
					msg += '\n결제 금액 : ' + rsp.paid_amount + '원';
					msg += '\n-------------------------------------';
					alert(msg);
					history.go(-4);
   	    		},
   	    		error : console.log
   	    	 });
   	    	 
   	         
   	     } else { // 실패시
   	         var msg = '결제에 실패하였습니다.';
   	         msg += '에러내용 : ' + rsp.error_msg;
   	         alert(msg);
   	         history.go(-4);
   	     }
   	 	});
	};
    </script>
</body>
</html>