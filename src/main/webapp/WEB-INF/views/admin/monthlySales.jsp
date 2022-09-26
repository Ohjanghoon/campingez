<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8"/>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/admin/admin.jsp">
	<jsp:param name="title" value="캠핑이지" />
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.0.0"></script>
			<div class="content-wrap">
				<h2 class="text-center fw-bold pt-5 pb-5">월별 매출 통계</h2>
				<div id="search-bar">
					<select class="form-select selectType" aria-label="Default select example" name="year" id="year">
						<option value="2022">2022</option>
						<option value="2023">2023</option>
						<option value="2024">2024</option>
						<option value="2025">2025</option>
					</select>
				</div>
				<div class="count-wrap">
					<div id="totalCount-wrap">
						총 매출 총액 : <span id="totalPrice" class="strong"></span>
					</div>
					<div id="totalCountByDate-wrap">
						<span id="selectYear"></span>년도 매출 총액 : <span id="yearTotalPrice" class="strong"></span>
					</div>
				</div>
				<canvas id="myChart" width="1024" height="500"></canvas>
				<div id="sale-chart-wrap"></div>
			</div>
		</div>
	</section>
</main>
<script>
// 차트 랜더링
window.addEventListener('load', (e) => {
	getGraph();
});
const getGraph = () => {
	const year = new Date().getFullYear();
	monthlyGraph(year);
};

// 년도 변경에 따른 차트 랜더링
document.querySelectorAll("#year").forEach((opt) => {
	opt.addEventListener('change', (e) => {
		const year = e.target.value;		
		const wrap = document.querySelector("#sale-chart-wrap");
		wrap.innerHTML = '';		
		
		if(!year) return;
		
		monthlyGraph(year);
	})
});

const monthlyGraph = (year) => {
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/monthlySalesList.do",
		data : {year},
		content : "application/json",
		success(response) {
			const {year, saleList, totalPrice, yearTotalPrice} = response;
			document.querySelector("#selectYear").innerHTML = year;
			document.querySelector("#totalPrice").innerHTML = totalPrice.toLocaleString() + '원';
			document.querySelector("#yearTotalPrice").innerHTML = yearTotalPrice.toLocaleString() + '원';
			
			const monthList = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
			
			// selected 처리
			document.querySelectorAll("option").forEach((opt) => {
				if(opt.value == year) {
					opt.selected = true;
				}
			});
			
			// DB데이터와 비교하여 값 처리
			let arrayIndex = 0;
			let result = [];
			for(let i = 0; i < monthList.length; i++) {
				if(saleList[arrayIndex] != null && monthList[i] == saleList[arrayIndex].month.trim()) {
					result.push(saleList[arrayIndex].totalPrice);
					arrayIndex++;
				} else {
					result.push(0);
				}
			};
			
			// 기존 차트가 존재한다면 destroy 처리
			const chartStatus = Chart.getChart("myChart");
			if(chartStatus != undefined) {
				chartStatus.destroy();
			}
			
			// 차트 생성
			const ctx = document.getElementById('myChart').getContext('2d');
			var myLineChart = new Chart(ctx, {
			    type: 'bar',
			    plugins:[ChartDataLabels],
			    data: {
			    	labels: monthList,
			    	  datasets: [
			    	    {
			    	      label: '매출액',
			    	      data: result,
			    	      borderColor: '#A8A4CE',
			    	      backgroundColor: '#c8b6e25c'
			    	    }
			    	  ]
			    },
			    options: {
			    	responsive: false,
			    	scales: {
			    		y: {
			    			suggestedMin: 0,
			    			suggestedMax: 1000000
			    		}
			    	},
			    	plugins: {
		    	      legend: {
		    	        position: 'top',
		    	      },
		    	      title: {
		    	        display: true,
		    	        text: '월별 매출 통계',
		    	        fontSize: 20
		    	      },
		    	      tooltip: {
		    	    	  enabled: false
		    	      }, 
		    	      datalabels: {
		        	        formatter: function(value, context) {
		        	        	return value != 0 ? value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원" : '';
		        	        },
		        	        padding: 1,
		                    color: 'black',
		                    anchor: 'end',
		                    clamp: true,
		                    align: 'top'
		    	      	}
		    	    },
		    	    onClick(point, event) {
		    	    	const {chart} = point;
		    	    	if(event.length > 0) {
		    	    		const _searchMon = chart.data.labels[event[0].index];
		    	    		const searchMon = _searchMon.substring(_searchMon.lenght-1, _searchMon.indexOf('월'));
		    	    		const year = document.querySelector("#year option:checked").value;
		    	    		
		    	    		const wrapper = document.querySelector("#sale-chart-wrap");
		    	    		$.ajax({
		    	    			url : "${pageContext.request.contextPath}/admin/saleListByMonth.do",
		    	    			data : {year, searchMon},
		    	    			content : "application/json",
		    	    			success(response) {
		    	    				dailyGraph(response);
		    	    			},
		    	    			error : console.log
		    	    		});
		    	    		
		    	    	}
		    	    }
			    }
			});
		},
		error : console.log
	});
};

// 월별 일 매출 차트 생성
const dailyGraph = (response) => {
	const {year, month:mon, saleList} = response;
	const month = mon < 10 ? '0' + mon : mon;

	const getMonth = new Date().getMonth() + 1;
	let searchDate;
	if(getMonth == mon) {
		searchDate = new Date().getDate(); 
	} else {
		searchDate = new Date(year,month,0).getDate();
	}
	
	// 달의 모든 일자 구하기
	const allDate = Array.apply(null, Array(searchDate)).map((_, i) => {
		const day = i+1 < 10 ? '0' + (i+1) : (i+1);
		return [year,month,day].join('-');
	});
	
	// DB상 존재하는 일자들
	let queryDate = new Array();
	saleList.forEach((sale) => {
		const {resDate:[year,_month,_day]} = sale;
		const month = _month < 10 ? '0'+_month : _month;
		const day = _day < 10 ? '0'+_day : _day;
		
		queryDate.push([year,month,day].join('-'));
	});
	
	let arrayIndex = 0;
	let result = [];
	for(let i = 0; i < allDate.length; i++) {
		if(queryDate[arrayIndex] != null && allDate[i] == queryDate[arrayIndex]) {
			result.push(saleList[arrayIndex].totalPrice);
			arrayIndex++;
		} else {
			result.push(0);
		}
	};

	const wrap = document.querySelector("#sale-chart-wrap");
	wrap.innerHTML = '';
	
	const canvas = document.createElement("canvas");
	canvas.id = 'dailyChart';
	canvas.width = '1024';
	canvas.height = '500';
	wrap.append(canvas);
	
	const ctx = document.getElementById('dailyChart').getContext('2d');
	var myLineChart = new Chart(ctx, {
	    type: 'line',
	    plugins:[ChartDataLabels],
	    data: {
	    	labels: allDate,
	    	  datasets: [
	    	    {
	    	      label: '일일 통계',
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
	                suggestedMax: 1000000
	            }
			},
			plugins: {
    	      legend: {
    	        position: 'top',
    	      },
    	      title: {
    	        display: true,
    	        text: '일일 매출 통계'
    	      },
    	      tooltip: {
    	    	  enabled: false
    	      }, 
    	      datalabels: {
        	        formatter: function(value, context) {
        	        	return value != 0 ? value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "원" : '';
        	        },
        	        padding: 1,
                    color: 'black',
                    anchor: 'end',
                    clamp: true,
                    align: 'top'
    	      	}
    	    }
		}
	});
};
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>