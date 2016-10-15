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
	<link rel="stylesheet" type="text/css" href="${cssPath}/sentry/view.css">
	</@head>
	<script src="${jsCommon}/module/My97DatePicker/WdatePicker.js"></script>
</head>
<body id="sentry-system" class="m-id-a0">
<div class="g-doc">
	<div class="g-hd">
		<@nav index=1 />
	</div>
	<div class="g-bd" id="content">
		<div class="g-sd <#if (RequestParameters.show)?? && (RequestParameters.show)=='0'>lt-24<#else>lt0</#if>">
			<#if user.external>
			<@sidenav tree=my />
			<#else>
			<@sidenav tree=all />
			</#if>
		</div>
		<div class="g-mn g-mn-1 <#if (RequestParameters.show)?? && (RequestParameters.show)=='0'>lt0<#else>lt24</#if>">
			<#if RequestParameters.clusterId?? && (RequestParameters.clusterId)!="-1">
				<div class="m-tab" style="margin-top:10px;margin-left:10px;">
				    <ul id="tab">
				        <li><a href="/sentry/appMonitor/view?clusterId=${RequestParameters.clusterId}">单机视图</a></li>
				        <li class="z-act"><a href="javascript:void(0);">VIP视图</a></li>
				    </ul>
				</div>
				<@multiQuery />
				<div class="g-cnt g-cnt-1" id="chartscnt">
					<@view viewConfig=viewConfig!'false'/>
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

<#if RequestParameters.clusterId??>
<#if vipList??>
<textarea name="jst" id="form-vips" style="display:none;">
	<form onsubmit="return false">
		<div class="u-iptsearch u-iptsearch-1 u-iptsearch-view">
			<input type="text" class="u-ipt" id="view-ipt-search">
		</div>
		<table class="m-table">
			<thead>
				<tr>
					<th class="checkbox"></th>
					<th class="hn">域</th>
					<th>ip</th>
					<th>端口</th>
				</tr>
			</thead>
			<tbody>
				<#list vipList as item>
				<tr class="btr">
					<td><input type="radio" name="cur" value="${item.id}"/></td>
					<td>${item.dnsName!}</td>
					<td>${item.ip!}</td>
					<td>${item.port!}</td>
				</tr>
				</#list>
			</tbody>
		</table>
	</form>
</textarea>
</#if>

<#if allItemList??>
<textarea name="jst" id="form-singleItem" style="display:none;">
	<form onsubmit="return false">
		<div class="u-iptsearch u-iptsearch-1 u-iptsearch-view">
			<input type="text" class="u-ipt" id="view-ipt-search">
		</div>
		<table class="m-table">
			<thead>
				<tr>
					<th class="checkbox"></th>
					<th class="hn">name</th>
				</tr>
			</thead>
			<tbody>
				<#list allItemList as item>
				<tr class="btr">
					<td><input type="radio" name="cur" value="${item.id}"/></td>
					<td>${item.name!}</td>
				</tr>
				</#list>
			</tbody>
		</table>
	</form>
</textarea>
</#if>
<#if allDomainList??>
<textarea name="jst" id="form-domain" style="display:none;">
	<form onsubmit="return false">
		<div class="u-iptsearch u-iptsearch-1 u-iptsearch-view">
			<input type="text" class="u-ipt" id="view-ipt-search">
		</div>
		<table class="m-table">
			<thead>
				<tr>
					<th class="checkbox"></th>
					<th class="hn">name</th>
				</tr>
			</thead>
			<tbody>
				<#list allDomainList as item>
				<tr class="btr">
					<td><input type="radio" name="cur" value="${item.id}"/></td>
					<td>${item.domainName!}</td>
				</tr>
				</#list>
			</tbody>
		</table>
	</form>
</textarea>
</#if>

<#noescape>
<script type="text/javascript">
	var VIEWLIST = [];
	var viewCountEachRow;
	var condition = ${stringify(condition!)};
	var ViewType = 'vip';
	<#if viewConfig??>
		<#list viewConfig.viewList as view>
		var obj = {
			type: '${view.type}',
			url: '${view.url}',
			params: JSON.parse('${view.params}')
		};
		VIEWLIST.push(obj);
		viewCountEachRow = VIEWLIST.length / ${viewConfig.viewCountEachRow}
		</#list>
	</#if>
</script>
</#noescape>	
</#if>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/appMonitor/vip.js"></script>
</body>
</html>
</#escape>