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
			<@monitorList class="g-cnt-2" type="1"/>
		<#else>
			<div class="g-sd <#if (RequestParameters.show)??>lt-24<#else>lt0</#if>">
				<#if user.external>
				<@sidenav tree=my index=2/>
				<#else>
				<@sidenav tree=all index=2/>
				</#if>
			</div>
			<div class="g-mn g-mn-1 <#if (RequestParameters.show)??>lt0<#else>lt24</#if>">
				<#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId)!="-1">
					<div class="g-bar">
						<div id="crumbnav"></div>
					</div>
					<@monitorList class="" type="2"/>
				<#else>
					<div class="g-cnt">
						<div class="m-tab">
							<h2>请在左侧的产品树上选择集合</h2>
						</div>
					</div>
				</#if>
			</div>
			<div class="g-sl">
				<@menu index=2/>
			</div>
		</#if>
	</div>
</div>

<@jstTemplate/>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/monitor/vip/list.js"></script>
</body>
</html>
</@compress>
</#escape>