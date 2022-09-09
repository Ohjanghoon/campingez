<%@page import="java.util.Date"%>
<%@page import="com.kh.campingez.reservation.model.dto.Reservation"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	Reservation res = (Reservation) request.getAttribute("payRes");
	System.out.println("res = " + res + "입니다.");
	//System.out.println(res.getResPayment());
	/* String payMethod = null;
	
	switch(res.getResPayment()){
	case "카드" : payMethod = "card"; return;
	case "무통장입금" : payMethod = "vbank"; return;
	} */
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    
    <meta charset="UTF-8">
    <title>Sample Payment</title>
</head>
<body>
    <script>
	<%-- window.onload = () => {
		var IMP = window.IMP; // 생략가능
		IMP.init('imp63276768');  // 가맹점 식별 코드
		IMP.request_pay({
			pg : 'html5_inicis', // 결제방식
			pay_method : '<%= payMethod %>',    // 결제 수단
			merchant_uid : '\${res.resNo} + new Date().getTime()%>' ,
			name : '주문명: 결제 테스트',    // order 테이블에 들어갈 주문명 혹은 주문 번호
			amount : '100',    // 결제 금액
		}, function(rsp) {
   	     if ( rsp.success ) { // 성공시
   	         var msg = '결제가 완료되었습니다.';
   	         msg += '고유ID : ' + rsp.imp_uid;
   	         msg += '상점 거래ID : ' + rsp.merchant_uid;
   	         msg += '결제 금액 : ' + rsp.paid_amount;
   	         msg += '카드 승인번호 : ' + rsp.apply_num;
   	         alert(msg);
   	     } else { // 실패시
   	         var msg = '결제에 실패하였습니다.';
   	         msg += '에러내용 : ' + rsp.error_msg;
   	         alert(msg);
   	     }
   	 	});
	}; --%>
    </script>
</body>
</html>