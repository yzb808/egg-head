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
				        <li class="z-act"><a href="javascript:void(0);">监控视图</a></li>
				        <li><a href="/sentry/product/volume?productId=${RequestParameters.productId}&pageNumber=1">产品容量</a></li>
				        <#-- <li><a href="javascript:;">问题定位</a></li> -->
				    </ul>
			     </div>
			     <form id="form">
				     <div class="fmitem">
						<div class="fmcnt">
							<span class="fmlab">时间范围：</span>
							<span class="u-seltag">
								<a href="monitorstatus?productId=${RequestParameters.productId!}&rangeType=1h" <#if RequestParameters.rangeType?? && RequestParameters.rangeType?string == '1h'>class="act"</#if>>最近1小时</a>
							</span>
							<span class="u-seltag">
								<a href="monitorstatus?productId=${RequestParameters.productId!}&rangeType=3h" <#if RequestParameters.rangeType?default('1h')?string == '3h'>class="act"</#if>>最近3小时</a>
							</span>
							<span class="u-seltag">
								<a href="monitorstatus?productId=${RequestParameters.productId!}&rangeType=6h" <#if RequestParameters.rangeType?default('1h')?string == '6h'>class="act"</#if>>最近6小时</a>
							</span>
							<span class="u-seltag">
								<a href="monitorstatus?productId=${RequestParameters.productId!}&rangeType=today" <#if RequestParameters.rangeType?default('1h')?string == 'today'>class="act"</#if>>今天</a>
							</span>
							<span class="u-seltag">
								<a href="monitorstatus?productId=${RequestParameters.productId!}&rangeType=yesterday" <#if RequestParameters.rangeType?default('1h')?string == 'yesterday'>class="act"</#if>>昨天</a>
							</span>
							<span class="u-seltag">
								<a href="monitorstatus?productId=${RequestParameters.productId!}&rangeType=3d" <#if RequestParameters.rangeType?default('1h')?string == '3d'>class="act"</#if>>最近3天</a>
							</span>
							<span class="u-seltag j-custom">
								<a href="javascript:void(0)" <#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>class="act"</#if>>自定义</a>
							</span>
							<span class="custom <#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>act-1</#if>">
								<#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>
									<input type="text" value="<#if RequestParameters.startTime??>${RequestParameters.startTime}</#if>" name="startTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
									~
									<input type="text" value="<#if RequestParameters.endTime??>${RequestParameters.endTime}</#if>" name="endTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
									<span class="u-btn u-btn-s7 j-interval">提交</span>
								<#else>
									<input type="text" value="" name="startTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
									~
									<input type="text" value="" name="endTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
									<span class="u-btn u-btn-s7 j-interval">提交</span>
								</#if>
							</span>
						</div>
					</div>
				    <div class="box">
					    <div class="title">VIP监控异常：<input type="button" class="u-btn u-btn-1" value="问题定位" id="vip"/></div>
					    <div id="table-list-1">
							<table class="m-table">
								<thead>
									<tr>
										<th class="checkbox"></th>
										<th>VIP</th>
										<th>集群</th>
										<th>监控域</th>
										<th>监控项</th>
										<th>数据项</th>
										<th>状态</th>
										<th>持续时间</th>
										<th>报警内容</th>
									</tr>
								</thead>
								<tbody>
									<#if vipStatus??>
										<#list vipStatus.items as x>
										<tr>
											<td><input type="radio" class="j-check" name="vipId" data-id="${x.id}" value="${x.id}"></td>
											<td>${x.vipName!}</td>
											<td>${x.clusterName!}</td>
											<td>${x.domainName!}</td>
											<td>${x.monitorItemName!}</td>
											<td>${x.dataModelName!}</td>
											<td>${x.alarmStatus!}</td>
											<td>${x.duration}</td>
											<td>${x.alarmContent!}</td>
										</tr>
										</#list>
									</#if> 
								</tbody>
							</table>
						</div>
						<div class="win-pagination j-page" id="pagination"></div>
					</div>
					<div class="box">
						<div class="title">集群业务监控异常：<input type="button" class="u-btn u-btn-1" value="问题定位" id="cluster"/></div>
						<div id="table-list-2">
							<table class="m-table">
								<thead>
									<tr>
										<th class="checkbox"></th>
										<th>集群</th>
										<th>监控项</th>
										<th>数据项</th>
										<th>状态</th>
										<th>持续时间</th>
										<th>报警内容</th>
									</tr>
								</thead>
								<tbody>
									<#if clusterStatus??>
										<#list clusterStatus.items as x>
										<tr>
											<td><input type="radio" class="j-check" name="clusterId" data-id="${x.id!}" value="${x.id}"></td>
											<td>${x.clusterName!}</td>
											<td>${x.monitorItemName!}</td>
											<td>${x.dataModelName!}</td>
											<td>${x.alarmStatus!}</td>
											<td>${x.duration}</td>
											<td>${x.alarmContent!}</td>
										</tr>
										</#list>
									</#if>
								</tbody>
							</table>
						</div>
						<div class="win-pagination j-page" id="pagination-1"></div>
					</div>
					<div class="box">
						<div class="title">单机业务/应用异常：</div>
						<div id="table-list-3">
							<table class="m-table m-table-1">
								<thead>
									<tr>
										<th>主机名</th>
										<th>实例名</th>
										<th>集群</th>
										<th>监控项</th>
										<th>数据项</th>
										<th>状态</th>
										<th>持续时间</th>
										<th>报警内容</th>
									</tr>
								</thead>
								<tbody>
									<#if hostStatus??>
										<#list hostStatus.items as x>
										<tr>
											<td>${x.serverName!}</td>
											<td>${x.instanceName}</td>
											<td>${x.clusterName!}</td>
											<td>${x.monitorItemName!}</td>
											<td>${x.dataModelName!}</td>
											<td>${x.alarmStatus!}</td>
											<td>${x.duration}</td>
											<td>${x.alarmContent!}</td>
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

<div style="display:none" id ="jst-template">
<#noparse>
<textarea name="jst" id="jst-win-form-vip">
	<table class="m-table">
		<thead>
			<tr>
				<th class="checkbox"></th>
				<th>VIP</th>
				<th>集群</th>
				<th>监控域</th>
				<th>监控项</th>
				<th>数据项</th>
				<th>状态</th>
				<th>持续时间</th>
				<th>报警内容</th>
			</tr>
		</thead>
		<tbody>
			{if vipStatus}
				{list vipStatus as x}
				<tr>
					<td><input type="radio" class="j-check" name="vipId" data-id="${x.id}" value="${x.id}"></td>
					<td>${x.vipName}</td>
					<td>${x.clusterName}</td>
					<td>${x.domainName}</td>
					<td>${x.monitorItemName}</td>
					<td>${x.dataModelName}</td>
					<td>${x.alarmStatus}</td>
					<td>${x.duration}</td>
					<td>${x.alarmContent}</td>
				</tr>
				{/list}
			{/if}
		</tbody>
	</table>
</textarea>
<textarea name="jst" id="jst-win-form-cluster">
	<table class="m-table">
		<thead>
			<tr>
				<th class="checkbox"></th>
				<th>集群</th>
				<th>监控项</th>
				<th>数据项</th>
				<th>状态</th>
				<th>持续时间</th>
				<th>报警内容</th>
			</tr>
		</thead>
		<tbody>
			{if clusterStatus}
				{list clusterStatus as x}
				<tr>
					<td><input type="radio" class="j-check" name="clusterId" data-id="${x.id}" value="${x.id}"></td>
					<td>${x.clusterName}</td>
					<td>${x.monitorItemName}</td>
					<td>${x.dataModelName}</td>
					<td>${x.alarmStatus}</td>
					<td>${x.duration}</td>
					<td>${x.alarmContent}</td>
				</tr>
				{/list}
			{/if}
		</tbody>
	</table>
</textarea>
<textarea name="jst" id="jst-win-form-host">
	<table class="m-table m-table-1">
		<thead>
			<tr>
				<th>主机名</th>
				<th>实例名</th>
				<th>集群</th>
				<th>监控项</th>
				<th>数据项</th>
				<th>状态</th>
				<th>持续时间</th>
				<th>报警内容</th>
			</tr>
		</thead>
		<tbody>
			{if hostStatus}
				{list hostStatus as x}
				<tr>
					<td>${x.serverName}</td>
					<td>${x.instanceName}</td>
					<td>${x.clusterName}</td>
					<td>${x.monitorItemName}</td>
					<td>${x.dataModelName}</td>
					<td>${x.alarmStatus}</td>
					<td>${x.duration}</td>
					<td>${x.alarmContent}</td>
				</tr>
				{/list}
			{/if}
		</tbody>
	</table>
</textarea>
</#noparse>
</div>

<#noescape>
<script type="text/javascript">
	var VipTotal = ${vipStatus.total!} // 同步数据
	var ClusterTotal = ${clusterStatus.total!} // 同步数据
	var HostTotal = ${hostStatus.total!} // 同步数据
</script>
</#noescape>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/product/monitor.js"></script>
</body>
</html>
</#escape>