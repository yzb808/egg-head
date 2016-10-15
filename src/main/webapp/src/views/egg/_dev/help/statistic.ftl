<#escape x as x?html>
<!DOCTYPE html>
<html>
<head>
	<@head>
	<!-- @STYLE -->
	<link rel="stylesheet" type="text/css" href="${cssPath}/reset.css">
	<link rel="stylesheet" type="text/css" href="${cssPath}/function.css">
	<link rel="stylesheet" type="text/css" href="${cssPath}/animation.css">
	<link rel="stylesheet" type="text/css" href="${cssPath}/sentry.css">
	<link rel="stylesheet" type="text/css" href="${cssPath}/sentry/view.css">
	</@head>
	<script src="${jsCommon}/module/My97DatePicker/WdatePicker.js"></script>
</head>
<body id="sentry-system" class="m-id-a0">
<div class="g-doc">
	<div class="g-hd">
		<@nav index=3 />
	</div>
	<div class="g-bd">
		<div class="g-mn">
			<div class="g-bar">
				<div id="crumbnav"></div>
			</div>
			<div class="g-cnt g-cnt-s1" id="chartscnt">
				<div class="j-custom" style="padding-left:10px;" id="time-box">
					<input type="text" value="" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1 startTime" />
					~
					<input type="text" value="" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1 endTime"/>
					<a class="u-btn u-btn-c1" id='btn-confirm' style="margin-left:10px;">确定</a>
				</div>
				<div class="m-charts">
					<ul class="f-cb">
						<li class="w1 graph js-blog">
							<div class="cnt">
								<div class="hd f-cb">
									<div class="tit js-tit">哨兵使用uv统计</div>
								</div>
								<div class='bd js-chartbd'></div>
							</div>
						</li>
						<li class="w1 graph js-blog">
							<div class="cnt">
								<div class="hd f-cb">
									<div class="tit js-tit">哨兵使用pv统计</div>
								</div>
								<div class='bd js-chartbd'></div>
							</div>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<#noescape>
</#noescape>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/help/statistic.js"></script>
</body>
</html>
</#escape>