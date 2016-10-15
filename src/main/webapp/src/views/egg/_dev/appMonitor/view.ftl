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
	<link rel="stylesheet" type="text/css" href="${jsCommon}/module/guide/css/jquery.pagewalkthrough.css">
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
				        <li class="z-act"><a href="javascript:void(0);">单机视图</a></li>
				        <li><a href="/sentry/vipMonitor/view?clusterId=${RequestParameters.clusterId}">VIP视图</a></li>
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
<#if allInstanceList??>
<textarea name="jst" id="form-instances" style="display:none;">
	<form onsubmit="return false">
		<div class="u-iptsearch u-iptsearch-1 u-iptsearch-view">
			<input type="text" class="u-ipt" id="view-ipt-search">
		</div>
		<table class="m-table">
			<thead>
				<tr>
					<th class="checkbox"></th>
					<th class="hn">hostname</th>
					<th>ip</th>
					<th>实例名称</th>
				</tr>
			</thead>
			<tbody>
				<#list allInstanceList as item>
				<tr class="btr">
					<td><input type="radio" name="cur" value="${item.id}"/></td>
					<td>${item.name!}</td>
					<td>${item.ip!}</td>
					<td>${item.instanceName!?replace('default','')}</td>
				</tr>
				</#list>
			</tbody>
		</table>
	</form>
</textarea>
</#if>
<#if allInstanceList??>
<textarea name="jst" id="form-muti-instances" style="display:none;">
	<form onsubmit="return false" class="muti-ins" id="form-compare">
		<div class="u-iptsearch u-iptsearch-1 u-iptsearch-view">
			<input type="text" class="u-ipt" id="view-ipt-search">
		</div>
		<div class="j-radio">
			<#-- <input type="radio" class="f-vam"/>反选 -->
		</div>
		<div class="select">
            <select id="type" name="compareType">
            	<option value="0">展开</option>
            	<option value="1">合并</option>
            </select>
            <div class="j-name" id="name" style="display:none;"></div>
		</div>
		<table class="m-table" id="table-ins">
		   <thead>
		    <tr>
		     <th class="checkbox"><input type="checkbox" class="j-sel" id="j-sel"/></th>
		     <th class="hn">主机名</th>
		     <th>ip</th>
		     <th>实例名称</th>
		    </tr>
		   </thead>
		   <tbody>
		    <#list allInstanceList as item>
		    <#-- <#if item.name != 'All'> -->
		    <tr class="btr">
			    <td><input type="checkbox" class="j-check" value="${item.id}" data-id="${item.id}"/></td>
			    <td>${item.name!}</td>
			    <td>${item.ip!}</td>
			    <td>${item.instanceName!?replace('default','')}</td>
			</tr>
			<#-- </#if> -->
		    </#list>
		   </tbody>
		</table>
	</form>
</textarea>
</#if>
<#if allMultiItemList??>
<textarea name="jst" id="form-multiItem" style="display:none;">
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
				<#list allMultiItemList as item>
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

<#if allSingleItemList??>
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
				<#list allSingleItemList as item>
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

<#noescape>
<script type="text/javascript">
	var VIEWLIST = [];
	var viewCountEachRow;
	var condition = ${stringify(condition!)};
	var ViewType = 'single';
	<#if viewConfig??>
		<#list viewConfig.viewList as view>
		var obj = {
			type: '${view.type}',
			url: '${view.url}',
			id: '${view.id!}',
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
<script src="${jsPages}/sentry/appMonitor/base.js"></script>
</body>
</html>
</#escape>