<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

	<head>

		<title>软件学院实践课题管理系统</title>
		<link rel="stylesheet" href="assets/plugins/select2/select2.css">
		<link rel="stylesheet" type="text/css" href="assets/css/jquery.seat-charts.css">
		<link rel="stylesheet" type="text/css" href="assets/css/style.css">

		<script type="text/javascript">
			function reset() {
				location.reload();
			}
			
			function distr() {
				var roomID = '${roomID}';
				var teaID = '${teaID}';
				var teaName = '${teaName}';
				var seat = document.getElementById("total").innerText;
				if(seat.trim() == ''){
					return;
				}
				var length = seat.length;
				seat = seat.substring(0, length - 1);
				
				if(confirm('确认座位号:' + seat + '?')) {
					$.ajax({
						type: "post",
						url: "./${sessionScope.pathCode}/appendTeaRoom.do",
						data : "teaID=" + teaID + "&teaName=" + teaName + "&roomID=" + roomID + "&seat=" + seat,
						dataType: 'html',
						contentType: "application/x-www-form-urlencoded; charset=utf-8",
						success: function(result) {
							location.reload();
						},
						error: function(request) {
							alert("Connection error!");
						}
					});
				}
				
			}
		</script>
	</head>

	<body>
		<div class="row">
			<div class="col-sm-12">
				<ol class="breadcrumb">
					<li><i class="clip-home-3"></i>
						<a href="./${sessionScope.pathCode}/home.do"> 首页 </a>
					</li>
					<li class="active">机房分配管理</li>
					<li class="active">选择分配教师</li>
					<li class="active">为 ${teaName } 分配机房</li>
					<li class="active">${roomID } 机房信息</li>

				</ol>
				<div class="page-header">
					<h2>${roomID } 机房</h2>
					<h5><font color="red">${errormsg}</font></h5>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-md-12">
				<div class="panel-body">
					<div class="wrapper">
						<div class="container">
							<div id="seat-map" style="width: 50%; height: 150%"></div>
							<div class="booking-details">
								<h3>已选中的座位 (<span id="counter">0</span>):</h3>
								<ul id="selected-seats"></ul>
								<p>座位: <br/><span id="total"></span></p>
								<p><button class="btn btn-info btn-sm" onclick="distr()">确定</button><button class="btn btn-danger btn-sm" onclick="reset()" style="margin-left: 5%">重置</button></p>
								<div id="legend"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<script src="assets/plugins/jquery-inputlimiter/jquery.inputlimiter.1.3.1.min.js"></script>
		<script src="assets/plugins/autosize/jquery.autosize.min.js"></script>
		<script src="assets/plugins/select2/select2.min.js"></script>
		<script src="assets/js/form-elements.js"></script>
		<script src="assets/js/jquery-1.11.0.min.js"></script>
		<script src="assets/js/jquery.seat-charts.min.js"></script>
		<script>
			$(document).ready(function() {
				var roomID = '${roomID}';

				var seats = '';
				var start = '';
				var end = '';

				$.ajax({
					type: "post",
					url: "./${sessionScope.pathCode}/getUsingSeats.do",
					data: "roomID=" + roomID,
					dataType: 'html',
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
					success: function(data) {
						seats = eval("(" + data + ")")[0].seat;
						start = Number(eval("(" + data + ")")[0].start_num);
						end = Number(eval("(" + data + ")")[0].end_num);

						var seatArray = new Array();
						var arrIndex = 0;
						var str = "";
						for(var i = start; i <= end; i++) {
							str += 'e';
							if((i - start + 1) % 10 == 0) {
								seatArray[arrIndex++] = str;
								str = '';
							} 
						}
						seatArray[arrIndex] = str;
						for(var i = 0; i < seats.length; i++) {
							seats[i] = seats[i] - start;
						}
						var prefix = '';
						var suffix = '';
						var temp = '_';
						var useSeatArray = new Array();
						for(var i = 0; i < seats.length; i++) {
							prefix = parseInt(seats[i] / 10) + 1;
							suffix = seats[i] % 10 + 1;
							useSeatArray[i] = prefix + temp + suffix;
						}
						var i = 0;
						var $cart = $('#selected-seats'),
							$counter = $('#counter'),
							$total = $('#total'),
							sc = $('#seat-map').seatCharts({
								map: seatArray,
								legend: {
									node: $('#legend'),
									items: [
										['e', 'available', '未选'],
										['f', 'unavailable', '已选用']
									]
								},
								naming: {
									top: false,
									getLabel: function(character, row, column) {
										return start++;
									},
								},
								click: function() {
									var label = this.settings.label + ',';
									if(this.status() == 'available') {
										i = i + 1;
										$counter.text(sc.find('selected').length + 1);
										$total.append(label);
										if(i % 20 == 0)
											$total.append('<br/>');
										return 'selected';
									} else if(this.status() == 'unavailable') {
										return 'unavailable';
									} else {
										return this.style();
									}
								}
							});

						$('#selected-seats').on('click', '.cancel-cart-item', function() {
							sc.get($(this).parents('li:first').data('seatId')).click();
						});
						sc.get(useSeatArray).status('unavailable');
					},
					error: function(request) {
						alert("Connection error!");
					}
				});

			});
		</script>
	</body>

</html>