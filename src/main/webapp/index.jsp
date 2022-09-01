<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
	
	<h1>캠핑이지</h1>
	<button id="btn-weather">확인</button>
	
	<script>
		const clockString = () => {
	        const f = (n) => {
	            return n <10 ? "0" + n : n;
	        }
	        const now = new Date();
	        const yyyy = now.getFullYear();
	        const MM = f(now.getMonth()+1);
	        const dd = f(now.getDate());
	        return yyyy + MM + dd;
	    }
	
		const timeString = () => {
            const f = (n) => {
                return n <10 ? "0" + n : n;
            }
            const now = new Date();
            const hh = f(now.getHours());
            const mm = f(now.getMinutes());
            return hh + mm;
        }
		
		document.querySelector("#btn-weather").addEventListener('click', (e) => {
			const today = clockString();
			const time = "0600";
			console.log(today, time);
			
			$.ajax({
				//url : "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst?serviceKey=nkedH2GBDF%2BTCm2VLMxTXfjbK5uG7xtbtLDOXdsDlb%2F4S5NAykAK5f4zhhjMpTM7GUf1pmqRcrC7nTOPF4iAgw%3D%3D&numOfRows=10&pageNo=1&base_date=20220901&base_time=0600&nx=55&ny=127",
				url : "${pageContext.request.contextPath}/data/weather.do",
				data : {
					date : today, time
				},
				success(data){
					console.log(data);
				},
				error : console.log
			});
		});
		</script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
