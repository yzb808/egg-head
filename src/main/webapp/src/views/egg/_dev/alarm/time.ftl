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
		<@nav index=2 />
	</div>
	<div class="g-bd">
		<div class="g-mn">
			<div class="g-bar">
				<div id="crumbnav"></div>
			</div>
			<div class="g-cnt">
				<div class="m-bar">
					<div class="u-btns">
						<a href="javascript:;" class="u-btn" id="btn-add">添加时间段</a>
						<a href="javascript:;" class="u-btn u-btn-c1" id="btn-edit">修改时间段</a>
						<span class="u-btn u-btn-c1" id="btn-del">删除时间段</span>
					</div>
				</div>
				<table class="m-table" id="table">
					<thead>
						<tr>
							<th class="checkbox"><input type="checkbox" id="select-all"></th>
							<th>时间段名称</th>
							<th>时间表达式</th>
							<th>类型</th>
							<th>描述</th>
						</tr>
					</thead>
					<tbody>
						<#if alarmTimeList??>
						<#list alarmTimeList as x>
						<tr>
							<td><input type="checkbox" class="j-check" data-id="${x.id!}"></td>
							<td><a href="javascript:void(0)" data-action="show" data-id="${x.id!}" title="查看详情">${x.name!}</a></td>
							<td>${x.expression!}</td>
							<td>${x.scope!}</td>
							<td>${x.descp!}</td>
						</tr>
						</#list>
						</#if>
					</tbody>
				</table>
				<@pagination total=total?default(0) />
			</div>
		</div>
	</div>
</div>
<div style="display:none" id="jst-template">
	<#noparse>
	<textarea name="jst" id="jst-win-form-del">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="jst" id="jst-win-form-add">
		<form id="form-add" class="form">
			<h2 class="u-tt">基本信息</h2>
			<div class="m-form">
			<div class="fmitem">
				<label class="fmlab"><i>*</i>时间段名称:</label>
				<div class="fmcnt">
					<input type="text" class="u-ipt" name="name" value="${name}" data-required="true" data-message="不能为空"/>
				</div>
			</div>
				<div class="fmitem">
					<label class="fmlab"><i>*</i>时间表达式:</label>
					<div class="fmcnt">
						<input type="text" class="u-ipt" name="expression" value="${expression}" data-required="true" data-message="不能为空"/>
					</div>
				</div>
				<div class="fmitem">
					<label class="fmlab">时间表达式:</label>
					<div class="fmcnt fmbox">
						{if scope && scope == 'pub'}
						<input type="radio" name="scope" value="personal"/><span>私有</span>
						<input type="radio" class="right" checked="checked" name="scope" value="pub"/><span>公有</span>
						{else}
						<input type="radio" checked="checked" name="scope" value="personal"/><span>私有</span>
						<input type="radio" class="right" name="scope" value="pub"/><span>公有</span>
						{/if}
					</div>
				</div>
				<div class="fmitem">
					<label class="fmlab"><i>*</i>描述:</label>
					<div class="fmcnt ">
						<textarea class="u-ipt" name="descp"data-required="true" data-message="不能为空">${descp}</textarea>
					</div>
				</div>
			</div>
		</form>
	</textarea>
	</#noparse>
</div>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}"></script>
<script src="${jsPages}/sentry/alarm/time.js"></script>
</body>
</html>
</@compress>
</#escape>