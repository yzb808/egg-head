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
						<a href="/sentry/alarm/template/add" class="u-btn" id="btn-add">添加报警发送模版</a>
						<a href="javascript:;" data-href="/sentry/alarm/template/add" class="u-btn u-btn-c1" id="btn-edit">修改报警发送模版</a>
						<span class="u-btn u-btn-c1" id="btn-del">删除报警发送模版</span>
					</div>
				</div>
				<table class="m-table" id="table">
					<thead>
						<tr>
							<th class="checkbox"><input type="checkbox" id="select-all"></th>
							<th>报警发送模版名称</th>
							<th>报警发送模板描述</th>
						</tr>
					</thead>
					<tbody>
						<#if alarmTemplateList??>
						<#list alarmTemplateList as x>
						<tr>
							<td><input type="checkbox" class="j-check" data-id="${x.id!}"></td>
							<td><a href="javascript:void(0)" data-action="show" data-id="${x.id!}" title="查看详情">${x.name!}</a></td>
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
	<textarea name="jst" id="jst-win-form-stategy">
		<form id="form" class="form">
			<h2 class="u-tt">基本信息</h2>
			<div class="m-form">
				<div class="fmitem">
					<label class="fmlab">&#12288;&#12288;<i>*</i>报警通知时间段：</label>
					<div class="fmcnt">
						<select name="">
							<option value="1">全天</option>
							<option value="2">上班时间</option>
							<option value="3">下班时间</option>
						</select>
					</div>
				</div>
				<div class="fmitem">
					<label class="fmlab">&#12288;&#12288;<i>*</i>状态：</label>
					<div class="fmcnt fmbox">
						<input type="checkbox"/><span>critical</span>
						<input type="checkbox"/><span>warning</span>
						<input type="checkbox"/><span>error</span>
						<input type="checkbox"/><span>ok</span>
					</div>
				</div>
				<div class="fmitem">
					<label class="fmlab">&#12288;&#12288;<i>*</i>发送方式：</label>
					<div class="fmcnt fmbox">
						<input type="checkbox"/><span>泡泡</span>
						<input type="checkbox"/><span>邮件</span>
						<input type="checkbox"/><span>易信</span>
						<input type="checkbox"/><span>短信</span>
						<input type="checkbox"/><span>电话</span>
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
<script src="${jsPages}/sentry/alarm/template/list.js"></script>
</body>
</html>
</@compress>
</#escape>