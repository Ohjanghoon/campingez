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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<main>
	<section>
		<h2>날짜별 로그인 회원 통계</h2>
		<canvas id="bar-chart" width="500" height="400"></canvas>
		
	</section>
</main>

<script>
window.addEventListener('load', (e) => {
	getGraph();
});

const getGraph = () => {
	let monthList = [];
	let visitList = [];
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/statsVisitedChart.do",
		method : "GET",
		content : "application/json",
		success(response) {
			response.forEach((date) => {
				const {visitDate, visitDateCount} = date;
				monthList.push(visitDate);
				visitList.push(visitDateCount);
			});
			console.log(monthList);
			console.log(visitList);
			
			 new Chart(document.getElementById("bar-chart"), {
				    type: 'bar',
				    data: {
				      labels: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aut", "Sep", "Oct", "Nov", "Dec"],
				      datasets: [
				        {
				          label: "Population (millions)",
				          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
				          data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
				        }
				      ]
				    },
				    options: {
				      responsive: false,
				      legend: { display: false },
				      title: {
				        display: true,
				        text: 'Predicted world population (millions) in 2050'
				      }
				    }
				}); 
		},
		error : console.log
	});
};

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>