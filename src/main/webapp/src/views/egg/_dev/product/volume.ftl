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
<#-- <@load/> -->
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
			<div class="g-cnt g-cnt-2">
				<div class="m-tab">
				    <ul id="tab">
				        <li><a href="/sentry/product/business?productId=${RequestParameters.productId}&rangeType=1h">业务视图</a></li>
				        <li><a href="/sentry/product/monitorstatus?productId=${RequestParameters.productId}">监控视图</a></li>
				        <li class="z-act"><a href="javascript:void(0);">产品容量</a></li>
				        <#-- <li><a href="javascript:;">问题定位</a></li> -->
				    </ul>
			     </div>
			     <h2 class="volume">产品当前容量：
			     	<#if currentVolumePro?? && (currentVolumePro?number>70)>
					<span style="color:#f00;">${currentVolumePro!}<#if currentVolumePro?? && (currentVolumePro?number!=0)>%</#if></span>
					<#elseif currentVolumePro?? && (currentVolumePro?number<50)>
					<span style="color:#71b350;">${currentVolumePro!}
						<#if currentVolumePro??  && (currentVolumePro?number!=0)>%</#if></span>
					<#else> 
					<span style="color:#EE9A49;">${currentVolumePro!}
						<#if currentVolumePro??  && (currentVolumePro?number!=0)>%</#if></span>
			     	</#if>
					<span style="padding-left: 10px;">容量瓶颈：<#if maxClusterName??>${maxClusterName!}</#if></span></h2>
			     <div class="m-charts m-chart-2" id="chartcnt">
					  <ul class="charts f-cb">
						<li class="w1 graph js-blog">
							<div class="cnt" style="width:90%">
								<div class="hd f-cb">
									<div class="tit js-tit">产品容量趋势</div>
										<div class="opt f-cb">
											<div class="zoom f-icon js-zoom" title="放大"></div>
										</div>
									</div>
									<div class='bd js-chartbd'></div>
								</div>
							</li>
						</ul>
				</div>
			     <form id="form">
				    <div class="box">
				    	<div class="title volume">产品容量详情（最近一小时的最近一笔）</div>
					    <div id="table-list-1">
					    	<#if volumeDetail??>
							<table class="m-table" >
								<thead>
									<tr>
										<th>应用名称（权重）</th>
										<th>集群</th>
										<th>容量指标</th>
										<th>单机容量上限</th>
										<th>当前容量</th>
										<th>CPU</th>
										<th>内存</th>
									</tr>
								</thead>
								<tbody>
										<#list volumeDetail as x>
										<tr>
											<td>${x.appName!}</td>
											<td>${x.clusterName!}</td>
											<td>${x.clusterExpress!}</td>
											<td>${x.volumeLimit!}</td>
											<td>
											<a href="javascript:;" data-action="cluster" data-id="${x.clusterId!}">${x.volume!}<#if x.volume?? && (x.volume!= 0)>%</#if></a></td>
											<td <#if x.cpuUsage?? && (x.cpuUsage>70)>class="r-red"<#elseif x.cpuUsage?? && (x.cpuUsage<50)>class="r-green"<#else>class="r-yellow"</#if> >${x.cpuUsage!}
												<#if x.cpuUsage?? && (x.cpuUsage != 0)>%</#if></td>
											<td  <#if x.memUsage?? && (x.memUsage>70)>class="r-red"<#elseif x.memUsage?? && (x.memUsage<50)>class="r-green"<#else>class="r-yellow"</#if>>${x.memUsage!}
												<#if x.memUsage?? && (x.memUsage != 0)>%</#if>
											</td>
										</tr>
										</#list>
								</tbody>
							</table>
							</#if>
							<div class="bd js-chartbd"></div>
						</div>
						</div>
						<div class="win-pagination j-page" id="pagination"></div>
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
<textarea name="jst" id="jst-win-form-volume">
	<table class="m-table" >
		<thead>
		    <tr>
				<th>应用名称（权重）</th>
				<th>集群</th>
				<th>容量指标</th>
				<th>单机容量上限</th>
				<th>当前容量</th>
				<th>CPU</th>
				<th>内存</th>
			</tr>
		</thead>
		<tbody>
			{if volumeDetail}
				{list volumeDetail as x}
			<tr>
					<td>${x.appName}</td>
					<td>${x.clusterName}</td>
					<td>${x.clusterExpress}</td>
					<td>${x.volumeLimit}</td>
					<td>
					<a href="javascript:;"  {if x.volume>70}style="color:#f00;text-decoration:underline;"{elseif x.volume <50}style="color:#71b350;text-decoration:underline;"{else}style="color:#EE9A49;text-decoration:underline;"{/if}  data-action="cluster" data-id="${x.clusterId}">
					${x.volume}{if x.volume && x.volume !=0}%{/if}</a></td>
					<td {if x.cpuUsage && (x.cpuUsage>70)}class="r-red"{elseif x.cpuUsage && (x.cpuUsage<50)}class="r-green"{else}class="r-yellow"{/if}>${x.cpuUsage}
					{if x.cpuUsage && (x.cpuUsage != 0)}%{/if} 
					</td>
					<td {if x.memUsage && (x.memUsage>70)}class="r-red"{elseif x.memUsage && (x.memUsage<50)}class="r-green"{else}class="r-yellow"{/if}>${x.memUsage}
					{if x.memUsage && (x.memUsage != 0)}%{/if} 
					</td>
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
var condition ={};
</script>
</#noescape>	
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/product/volume.js"></script>
</body>
</html>
</#escape>