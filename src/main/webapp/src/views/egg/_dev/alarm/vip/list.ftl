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
		<#if (RequestParameters.clusterId)??>
		<div class="g-sd <#if (RequestParameters.show)?? && (RequestParameters.show)=='0'>lt-24<#else>lt0</#if>">
			<#if user.external>
			<@sidenav tree=my index=3/>
			<#else>
			<@sidenav tree=all index=3/>
			</#if>
		</div>
		<div class="g-mn g-mn-1 <#if (RequestParameters.show)?? && (RequestParameters.show)=='0'>lt0<#else>lt24</#if>">
			<div class="g-bar">
				<div id="crumbnav"></div>
			</div>
			<@monitorAlert class=""/>
		</div>
		<div class="g-sl">
			<@menu index=2/>
		</div>
		<#else>
		<div class="g-mn">
			<@monitorAlert class="g-cnt-2"/>
		</div>
		</#if>
	</div>
</div>

<@jstTemplate3/>
<#noescape>
<script type="text/javascript">
	var alarmRuleList = ${stringify(alarmRuleList!)}; // 同步数据
</script>
</#noescape>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/alarm/vip/list.js"></script>
</body>
</html>
</@compress>
</#escape>