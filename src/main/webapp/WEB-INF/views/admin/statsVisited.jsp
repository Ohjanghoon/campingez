<%@page import="java.util.Map"%>
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
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.0/moment.min.js"></script>
<main>
	<section>
		<h2>날짜별 로그인 회원 통계</h2>
		<select name="year" id="year">
			<option value="2022" ${map.year eq 2022 ? 'selected' : ''}>2022</option>
			<option value="2023">2023</option>
			<option value="2024">2024</option>
			<option value="2025">2025</option>
		</select>
		<select name="month" id="month">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
		</select>
		<div id="totalCount-wrap">
			총 로그인 수 : 
			<span id="totalCount"></span>
		</div>
		<div id="totalCountByDate-wrap">
			조회한 달 로그인 수 : 
			<span id="totalCountByDate"></span>
		</div>
		<canvas id="myChart" width="1000" height="500"></canvas>
	</section>
</main>

<script>
window.addEventListener('load', (e) => {
	getGraph();
});

// 차트랜더링 코드
const graphRender = (response) => {
	const totalWrap = document.querySelector("#totalCount");
	const totalByDateWrap = document.querySelector("#totalCountByDate");
	
	const {year, month:mon, visitedList, totalCount, totalCountByDate} = response;
	const month = mon <= 10 ? '0' + mon : mon;
	totalWrap.innerHTML = totalCount;
	totalByDateWrap.innerHTML = totalCountByDate;
	
	document.querySelectorAll("option").forEach((opt) => {
		if(opt.value == year || opt.value == mon) {
			opt.selected = true;
		}
	});
	
	const searchDate = new Date(year,month,0).getDate();
	// 달의 모든 일자 구하기
	const allDate = Array.apply(null, Array(searchDate)).map((_, i) => {
		
		const day = i+1 <= 10 ? '0' + (i+1) : (i+1);
		return [year,month,day].join('-');
	});

	// DB 조회 배열 삽입
	let queryDate = new Array();
	visitedList.forEach((date) => {			
		queryDate.push(date);
	});
	
	let arrayIndex = 0;
	let result = [];
	for(let i = 0; i < allDate.length; i++) {
		if(queryDate[arrayIndex] != null && allDate[i] == queryDate[arrayIndex].visitDate) {
			result.push(queryDate[arrayIndex].visitDateCount);
			arrayIndex++;
		} else {
			result.push(0);
		}
	}
	
	// 기존에 차트가 존재한다면 destroy로 날림
	// Canvas is already in use. Chart with ID '0' must be destroyed before the canvas with ID 'myChart' can be reused. 그렇지않으면 해당 오류발생!
	const chartStatus = Chart.getChart("myChart"); // canvas id
	
	if (chartStatus != undefined) {
	  chartStatus.destroy();
	}
	
	const ctx = document.getElementById('myChart').getContext('2d');
	var myLineChart = new Chart(ctx, {
	    type: 'line',
	    data: {
	    	labels: allDate,
	    	  datasets: [
	    	    {
	    	      label: '로그인수',
	    	      data: result,
	    	      borderColor: '#A8A4CE',
	    	      backgroundColor: '#c8b6e25c',
	    	      pointStyle: 'circle',
	    	      pointRadius: 5,
	    	      pointHoverRadius: 10,
	    	      fill: false
	    	    }
	    	  ]
	    },
		options: {
			responsive: false,
			scales: {
	            y: {
	                suggestedMin: 0,
	                suggestedMax: 100
	            }
			},
		}
	});
};

const getGraph = () => {
	const year = new Date().getFullYear();
	const month = new Date().getMonth() + 1;
	
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/statsVisitedChartByDate.do",
		method : "GET",
		content : "application/json",
		data : {year, month},
		success(response) {
			graphRender(response);
		},
		error : console.log
	});
};

document.querySelectorAll("select").forEach((sel) => {
	sel.addEventListener('change', (e) => {
		const year = document.querySelector("#year option:checked").value;
		const month = document.querySelector("#month option:checked").value;
		
		if(!year || !month) return;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/statsVisitedChartByDate.do",
			data : {year, month},
			content : "application/json",
			success(response) {
				graphRender(response);
			},
			error : console.log
		});
	})
})
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>