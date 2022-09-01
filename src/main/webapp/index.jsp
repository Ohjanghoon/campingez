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
	<div id="weather"></div>
	
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
            now.setMinutes(now.getMinutes() - 30);
            const hh = f(now.getHours());
            const mm = f(now.getMinutes());
            return hh + mm;
        }
		
		document.querySelector("#btn-weather").addEventListener('click', (e) => {
			const today = clockString();
			const time = timeString();
			console.log(today, time);
			document.querySelector('#weather').innerHTML = "";
			
			$.ajax({
				url : "${pageContext.request.contextPath}/data/weather.do",
				data : {
					date : today, time
				},
				success(data){
					//console.log(data);
					data.forEach((data) => {
						const wrapper = document.querySelector('#weather');
						
						const baseTime = "0" + (Number(data.baseTime) + 70);
						if(data.fcstTime == baseTime){
							//console.log(data, data.category, data.fcstValue);
							if(data.category == 'T1H'){
								console.log(data.fcstValue);
								wrapper.innerHTML += `<p>현재 온도 : \${data.fcstValue}</p>`
							}
							if(data.category == 'SKY'){
								if(Number(data.fcstValue) >= 4){
									console.log("흐림");
									wrapper.innerHTML += "<p>흐림</p>";
								}
								else{
									wrapper.innerHTML += "<p>안흐림</p>";
								}
							}
						}
					});					
				},
				error : console.log
			});
		});
		</script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
