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
		<@nav index=3 />
	</div>
	<div class="g-bd">
		<div class="g-mn">
			<div class="g-bar">
				<div id="crumbnav"></div>
			</div>
			<div class="g-cnt">
				<div class="m-bar">
					<div class="u-btns">
						<a href="javascript:;" class="u-btn" id="btn-add">添加标签</a>
						<a href="javascript:;" class="u-btn u-btn-c1" id="btn-edit">修改标签</a>
						<span class="u-btn u-btn-c1" id="btn-del">删除标签</span>
					</div>
				</div>
				<table class="m-table m-table-1" id="table-list">
					<thead>
						<tr>
							<th class="checkbox" class="checkbox"><input type="checkbox" id="select-all"></th><th>标签名称</th><th>显示次序</th><th>创建人</th><th>修改时间</th>
						</tr>
					</thead>
					<tbody>
						<#if tags??>
						<#list tags as x>
						<tr>
							<td><input type="checkbox" class="j-check" data-id="${x.id!}"></td>
							<td><a href="javascript:void(0)" data-action="show" data-id="${x.id!}" title="查看详情">${x.tagName}</a></td>
							<td>${x.tagSequence}</a></td>
							<td>${x.creatorName}</td>
							<td>${x.modifyTime?datetime}</td>
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

<div style="display:none" id ="jst-template">
<#noparse>
	<textarea name="jst" id="jst-win-form-del">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="jst" id="jst-win-form-add">
		<form id="tagadd">
			<div class="m-form">
				<div class="fmitem">
					<label class="fmlab"><i>*</i>标签名称:</label>
					<div class="fmcnt"><input type="text" name="name" class="u-ipt" value="${tagName}"></div>
				</div>
				<div class="fmitem">
					<label class="fmlab"><i>*</i>显示次序:</label>
					<div class="fmcnt"><input type="text" name="rank" class="u-ipt" value="${tagSequence}"></div>
				</div>
				<div class="fmitem">
					<label class="fmlab"></label>
					<div class="fmcnt">
						<textarea class="u-ipt u-ipt-s5" rows="40" name="descript">${content}<&#47;textarea>
					</div>
				</div>
			</div>
		</form>
	</textarea>
	<textarea name="jst" id="jst-win-form-show">
		<form id="tagadd">
			<div class="m-form">
				<div class="fmitem">
					<label class="fmlab"><i>*</i>标签名称:</label>
					<div class="fmcnt">${tagName}</div>
				</div>
				<div class="fmitem">
					<label class="fmlab"><i>*</i>显示次序:</label>
					<div class="fmcnt">${tagSequence}</div>
				</div>
				<div class="fmitem">
					<label class="fmlab"></label>
					<div class="fmcnt">
						<textarea class="u-ipt u-ipt-s5" rows="40" name="descript" readonly=true>${content}<&#47;textarea>
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
<script src="${jsPages}/sentry/tag/list.js"></script>
</body>
</html>
</@compress>
</#escape>