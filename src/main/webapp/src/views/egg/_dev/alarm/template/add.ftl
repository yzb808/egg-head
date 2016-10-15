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
<div class="g-doc g-doc-1">
	<div class="g-hd">
		<@nav index=2/>
	</div>
	<div class="g-bd">
		<div class="g-mn">
			<div class="g-bar">
				<div id="crumbnav"></div>
			</div>
			<div class="g-cnt">
				<@formTemplate/>
			</div>
		</div>
	</div>
</div>
<@jstTemplate/>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/alarm/template/add.js"></script>
</body>
</html>
</@compress>
</#escape>