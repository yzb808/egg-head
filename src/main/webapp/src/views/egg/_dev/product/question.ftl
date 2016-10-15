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
	</@head>
	<script src="${jsCommon}/module/My97DatePicker/WdatePicker.js"></script>
</head>
<body id="sentry-system">
<@load/>
<div class="g-doc">
	<div class="g-hd">
		<@nav index=1 />
	</div>
	<div class="g-bd" id="content">
		<div class="g-sd <#if (RequestParameters.show)??>lt-24<#else>lt0</#if>">
			<#if user.external>
			<#if my??>
			<@sidenav tree=my />
			</#if>
			<#else>
			<#if all??>
			<@sidenav tree=all />
			</#if>
			</#if>
		</div>
		<div class="g-mn g-mn-1 <#if (RequestParameters.show)??>lt0<#else>lt24</#if>">
			<#if (RequestParameters.productId)?? && (RequestParameters.productId)!="-1">
			<div class="g-cnt g-cnt-2 product">
				<div class="m-tab">
				    <ul id="tab">
				        <li><a href="/sentry/product/business?productId=${RequestParameters.productId}&rangeType=1h">业务视图</a></li>
				        <li><a href="/sentry/product/monitorstatus?productId=${RequestParameters.productId}">监控视图</a></li>
				        <li class="z-act"><a href="javascript:;">问题定位</a></li>
				    </ul>
			    </div>
			    <form id="form">
				    <div class="box">
					    <div class="title">分析来源：（下方列表的数据来源于产品监控视图中的单选内容，需要展示报警内容）</div>
					    <div id="table-list-1">
							<table class="m-table">
								<thead>
									<tr>
										<th>集群</th>
										<th>监控项</th>
										<th>数据项</th>
										<th>状态</th>
									</tr>
								</thead>
								<tbody>
									<#if originData??>
										<tr>
											<td>${originData.clusterName!}</td>
											<td>${originData.monitorItemName!}</td>
											<td>${originData.dataModelName!}</td>
											<td>${originData.states!}</td>
										</tr>
									</#if> 
								</tbody>
							</table>
						</div>
						<div class="win-pagination j-page" id="pagination"></div>
					</div>
					<div class="box">
						<div class="title">分析结果：（分析时间段：${questionTimeStart!}~~${questionTimeEnd!}  故障前后半小时）</div>
						<div id="table-list-2">
							<table class="m-table">
								<thead>
									<tr>
										<th>依赖产品</th>
										<th>报警类型</th>
										<th>Critical</th>
										<th>Warning</th>
									</tr>
								</thead>
								<tbody>
								<#if dependProducts??>
									<#list dependProducts as x>
										<tr>
											<td rowspan="3">${x.productName!}</td> 
											<td>单机</td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=0&alarmStatus=critical&pProductId=${x.productId}">${x.ctricalNumS!}</a></td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=0&alarmStatus=warning&pProductId=${x.productId}">${x.warnNumS!}</a></td>
										</tr>
										<tr>
											<td>集群</td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=1&alarmStatus=critical&pProductId=${x.productId}">${x.ctricalNumC!}</a></td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=1&alarmStatus=warning&pProductId=${x.productId}">${x.warnNumC!}</a></td>
										</tr>
										<tr>
											<td>VIP</td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=3&alarmStatus=critical&pProductId=${x.productId}">${x.ctricalNumV!}</a></td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=3&alarmStatus=warning&pProductId=${x.productId}">${x.warnNumV!}</a></td>
										</tr>
									</#list>
								</#if>
								</tbody>
							</table>
						</div>
						<div class="win-pagination j-page" id="pagination-1"></div>
					</div>
					<div class="box">
						<div class="title">产品内部报警统计：</div>
						<div id="table-list-3">
							<table class="m-table m-table-3">
								<thead>
									<tr>
										<th>应用名称</th>
										<th>报警类型</th>
										<th>Critical</th>
										<th>Warning</th>
									</tr>
								</thead>
								<tbody>
								<#if dependApps??>
									<#list dependApps as x>
										<tr>
											<td rowspan="3">${x.appName!}</td>
											<td>单机</td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=0&alarmStatus=critical&applicationId=${x.appId}&pProductId=${RequestParameters.productId}">${x.ctricalNumS!}</a></td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=0&alarmStatus=warning&applicationId=${x.appId}&pProductId=${RequestParameters.productId}">${x.warnNumS!}</a></td>
										</tr>
										<tr>
											<td>集群</td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=1&alarmStatus=critical&applicationId=${x.appId}&pProductId=${RequestParameters.productId}">${x.ctricalNumC!}</a></td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=1&alarmStatus=warning&applicationId=${x.appId}&pProductId=${RequestParameters.productId}">${x.warnNumC!}</a></td>
										</tr>
										<tr>
											<td>VIP</td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=3&alarmStatus=critical&applicationId=${x.appId}&pProductId=${RequestParameters.productId}">${x.ctricalNumV!}</a></td>
											<td><a href="/sentry/product/question/history?productId=${RequestParameters.productId}&questionTime=${questionTime}&alarmType=3&alarmStatus=warning&applicationId=${x.appId}&pProductId=${RequestParameters.productId}">${x.warnNumV!}</a></td>
										</tr>
									</#list>
								</#if>
								</tbody>
							</table>
						</div>
						<div class="win-pagination j-page" id="pagination-2"></div>
					</div>
				</form>
			</div>
			<#else>
			<div class="g-cnt">
				<div class="m-tab">
					<h2>请在左侧的产品树上选择集合</h2>
				</div>
			</div>
			</#if>
		</div>
		<div class="g-sl">
			<@menu index=0/>
		</div>
	</div>
</div>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/product/question.js"></script>
</body>
</html>
</#escape>