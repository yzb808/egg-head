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
</head>
<body id="sentry-system">
<div class="g-doc">
	<div class="g-hd">
		<@nav index=0 />
	</div>
	<div class="g-bd" id="content">
		<div class="g-sd <#if (RequestParameters.show)??>lt-24<#else>lt0</#if>">
			<#if user.external>
			<#if my??>
			<@sidenav tree=my index=6/>
			</#if>
			<#else>
			<#if all??>
			<@sidenav tree=all index=6/>
			</#if>
			</#if>
		</div>
		<div class="g-mn <#if (RequestParameters.show)??>lt0<#else>lt24</#if>">
			<div class="g-cnt g-cnt-2">
				<#-- <div class="monitor-summary f-cb">
					<p>总监控项数量: <a href="/sentry/status/person?onlyShowOwner=1&status=all">${summaryInfo.totalNum!}</a>&nbsp;&nbsp;
						OK: &nbsp;&nbsp;  
						Warning: <a href="/sentry/status/person?onlyShowOwner=1&status=4">${summaryInfo.warningNum!}</a>&nbsp;&nbsp;  
						Critical: <a href="/sentry/status/person?onlyShowOwner=1&status=5">${summaryInfo.criticalNum!}</a>&nbsp;&nbsp; 
						Error: <a href="/sentry/status/person?onlyShowOwner=1&status=3">${summaryInfo.errorNum!}</a>&nbsp;&nbsp; 
						Pending: <a href="/sentry/status/person?onlyShowOwner=1&status=1">${summaryInfo.pendingNum!}</a>
					</p>
				</div> -->
				<div class="monitor-summary f-cb">
					<div class="m-tab">
						<h4>我的监控项总览：</h4>
						<div class="m-bar m-bar-1">
							<div class="dtl" id="status-total">[&nbsp;总计:
								<span class="color color-ok"></span><span class="count" data-type="2"><a href="/sentry/status/person?onlyShowOwner=1&status=2">${summaryInfo.okNum!}</a></span>
								<span class="color color-warning"></span><span class="count" data-type="4"><a href="/sentry/status/person?onlyShowOwner=1&status=4">${summaryInfo.warningNum!}</a></span>
								<span class="color color-critical"></span><span class="count" data-type="5"><a href="/sentry/status/person?onlyShowOwner=1&status=5">${summaryInfo.criticalNum!}</a></span>
								<span class="color color-error"></span><span class="count" data-type="3"><a href="/sentry/status/person?onlyShowOwner=1&status=3">${summaryInfo.errorNum!}</a></span>
								<span class="color color-pending"></span><span class="count" data-type="1"><a href="/sentry/status/person?onlyShowOwner=1&status=1">${summaryInfo.pendingNum!}</a></span>
							]</div>
						</div>
				    </div>		
				</div>		
				<table class="m-table m-table-3" id="table-list">
					<thead>
						<tr class="dtl">
							<#-- <th class="checkbox"><input type="checkbox" id="select-all"></th> -->
							<th>维度</th>
							<th class="f-cf color-ok">OK</th>
							<th class="f-cf color-error">Error</th>
							<th class="f-cf color-pending">Pending</th>
							<th class="f-cf color-warning">Warning</th>
							<th class="f-cf color-critical">Critical</th>
							<#-- <th>采集时间</th> -->
						</tr>
					</thead>
					<tbody>
					<#if summaryItem??>
						<#list summaryItem as x>
						<tr>
							<td><a href="/sentry/status/person?onlyShowOwner=1&status=all&type=${x.type!}">${x.title!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&type=${x.type!}&status=2">${x.okNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&type=${x.type!}&status=3">${x.errorNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&type=${x.type!}&status=1">${x.pendingNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&type=${x.type!}&status=4">${x.warningNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&type=${x.type!}&status=5">${x.criticalNum!}</a></td>
						</tr>
						</#list>
					</#if>
					</tbody>
				</table>
				<div class="monitor-summary f-cb">
					<div class="m-tab">
						<h4>产品维度：</h4>
				    </div>		
				</div>
				<table class="m-table m-table-3" id="table-list">
					<thead>
						<tr class="dtl">
							<th>产品名称</th>
							<th>维度</th>
							<th>总监控项</th>
							<th>OK</th>
							<th>Error</th>
							<th>Pending</th>
							<th>Warning</th>
							<th>Critical</th>
						</tr>
					</thead>
					<#if detail??>
					<#list detail as x>
					<tbody>
						<#list x.summaryItem as xx>
						<tr>
							<#if xx_index==0>
								<td rowspan="3"><a href="/sentry/status/person?onlyShowOwner=1&status=all&productId=${x.id!}">${x.title}</a></td>
							</#if>
							<td><a href="/sentry/status/person?onlyShowOwner=1&productId=${x.id!}&status=all&type=${xx.type}">${xx.title}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&productId=${x.id!}&status=all&type=${xx.type}">${xx.totalNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&productId=${x.id!}&type=${xx.type}&status=2">${xx.okNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&productId=${x.id!}&type=${xx.type}&status=3">${xx.errorNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&productId=${x.id!}&type=${xx.type}&status=1">${xx.pendingNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&productId=${x.id!}&type=${xx.type}&status=4">${xx.warningNum!}</a></td>
							<td><a href="/sentry/status/person?onlyShowOwner=1&productId=${x.id!}&type=${xx.type}&status=5">${xx.criticalNum!}</a></td>
							</#list>
						</tr>	
					</tbody>
					</#list>
					</#if>
				</table>
			</div>
		</div>
	</div>
</div>

<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/status/personSummary.js"></script>
</body>
</html>
</#escape>