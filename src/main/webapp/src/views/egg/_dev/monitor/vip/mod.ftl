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
</head>
<body id="sentry-system">
<div class="g-doc">
	<div class="g-hd">
		<@nav index=2 />
	</div>
	<div class="g-bd" id="content">
		<#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId)=="0">
		<div class="g-mn">
			<@monitorCollect class="g-cnt-2"/>
		</div>
		<#else>
		<div class="g-sd <#if (RequestParameters.show)?? && (RequestParameters.show)=='0'>lt-24</#if>">
			<#if user.external>
			<@sidenav tree=my index=2/>
			<#else>
			<@sidenav tree=all index=2/>
			</#if>
		</div>
		<div class="g-mn g-mn-1 <#if (RequestParameters.show)?? && (RequestParameters.show)=='0'>lt0</#if>">
			<div class="g-bar">
				<div id="crumbnav"></div>
			</div>
			<@monitorCollect class=""/>
		</div>
		<div class="g-sl">
			<@menu index=2/>
		</div>
		</#if>
	</div>
</div>

<@jstTemplate2/>
<#noescape>
<script type="text/javascript">
var predictConfig = ${stringify(monitorItem.predictConfig!)}
</script>
</#noescape>	

<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/monitor/vip/mod.js"></script>
</body>
</html>
</@compress>
</#escape>