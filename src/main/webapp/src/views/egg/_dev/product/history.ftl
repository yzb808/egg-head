<#escape x as x?html>
<@compress single_line=!cfg_develop>
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
			<@questionHistory class="g-cnt-2"/>
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
					<td><input type="radio" class="j-check" name="vipId" data-id="${x.id}"></td>
					<td>${x.vipName}</td>
					<td>${x.domainName}</td>
					<td>${x.monitorItemName}</td>
					<td>${x.dataModelName}</td>
					<td>${x.alarmStatus}</td>
					<td>$持续时间</td>
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
					<td><input type="radio" class="j-check" name="clusterId" data-id="${x.id}"></td>
					<td>${x.monitorItemName}</td>
					<td>${x.dataModelName}</td>
					<td>${x.alarmStatus}</td>
					<td>$持续时间</td>
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
					<td>${x.monitorItemName}</td>
					<td>${x.dataModelName}</td>
					<td>${x.alarmStatus}</td>
					<td>$持续时间</td>
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
</script>
</#noescape>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/product/history.js"></script>
</body>
</html>
</@compress>
</#escape>