<#escape x as x?html>
<@compress single_line=!cfg_develop>
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
		<@nav index=2 />
	</div>
	<div class="g-bd" id="content">
		<div class="g-sd <#if (RequestParameters.show)?? && (RequestParameters.show)=='0'>lt-24<#else>lt0</#if>">
			<#if user.external>
			<@sidenav tree=my index=4/>
			<#else>
			<@sidenav tree=all index=4/>
			</#if>
		</div>
		<div class="g-mn g-mn-1 <#if (RequestParameters.show)?? && (RequestParameters.show)=='0'>lt0<#else>lt24</#if>">
			<#if RequestParameters.clusterId?? && (RequestParameters.clusterId?number != -1)>
				<@alarmHistory class="g-cnt-3"/>
			<#else>
				<div class="g-cnt">
					<div class="m-tab">
						<h2>请在左侧的产品树上选择集合</h2>
					</div>
				</div>
			</#if>
		</div>
		<div class="g-sl">
			<@menu index=3/>
		</div>
	</div>
</div>

<@jstTemplate4/>
<#noescape>
<script type="text/javascript">
	var VIPList = ${stringify(vips!)}; // 同步数据
	var MonitorVIPList = ${stringify(monitorItemVips!)}; // 同步数据
</script>
</#noescape>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/alarm/history.js"></script>
</body>
</html>
</@compress>
</#escape>