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
		<div class="g-mn">
			<div class="g-bar">
				<div id="crumbnav"></div>
			</div>
			<div class="g-cnt">
				<div class="m-bar">
					<div class="u-btns">
						<a href="javascript:;" class="u-btn" id="btn-add">添加联系人组</a>
					</div>
					<form class="f-fr">
						<div class="u-iptsearch u-iptsearch-3">
							<input type="text" name="searchWord" class="u-ipt u-ipt-s2" id="search-product" value="${searchword!}">
							<input type="submit" class="u-btn u-btn-s1" value="搜索"/>
						</div>
					</form>
				</div>
				<table class="m-table" id="table">
					<thead>
						<tr>
							<th>联系人组名称</th>
							<th>描述</th>
							<th>联系人列表</th>
							<th>创建人</th>
							<th>更新时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<#if groups??>
						<#list groups as x>
						<tr>
							<td>${x.groupName!}</td>
							<td title="${x.descp!}">${x.descp!}</td>
							<td>${x.receivers!}</td>
							<td>${x.creatorName!}</td>
							<td>${x.modifyTime!}</td>
							<td><span class="u-icons">
								<i class="u-icon u-icon-edit" data-action="edit" data-id="${x.id!}" title="修改"></i>
								<i class="u-icon u-icon-del2" data-action="del" data-id="${x.id!}" title="删除"></i>
							</span></td>
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
</div>

<div style="display:none" id ="jst-template">
<#noparse>
	<textarea name="jst" id="jst-win-form-del">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="txt" id="txt-add-item">
	    <li class="j-cd">
	    	<input type="text" class="j-flag u-ipt person" value="" placeholder="请输入邮箱前缀"/>
	    	<i class="u-icon u-icon-del" data-action="del"></i>
	    </li>
	</textarea>
	<textarea name="jst" id="form-add">
		<form id="form" class="form">
			<div class="m-form">
				<div class="fmitem">
					<label class="fmlab"><i>*</i>报警组名称:</label>
					<div class="fmcnt"><input type="text" name="name" class="u-ipt" value="${name}" data-required="true" data-message="不能为空"></div>
				</div>
				<div class="fmitem">
					<label class="fmlab"><i>*</i>描述:</label>
					<div class="fmcnt"><input type="text" name="descp" class="u-ipt" value="${descp}" data-required="true" data-message="不能为空"></div>
				</div>
				<div class="fmitem m-alarm-person">
					<label class="fmlab"><i>*</i>成员列表：</label>
					<div class="fmcnt">
						<ul class="itms" id="person-list">
							{if receivers}
							{list receivers as person}
							<li class="j-cd">
								<input type="text" class="j-flag u-ipt person" value="${person.account}" data-id="${person.id}" placeholder="请输入邮箱前缀"/>
								<i class="u-icon u-icon-del remove-person" data-action="del"></i>
							</li>
							{/list}
							{else}
							<li class="j-cd">
								<input type="text" class="j-flag u-ipt person" value="" placeholder="请输入邮箱前缀"/>
								<i class="u-icon u-icon-del remove-person" data-action="del"></i>
							</li>
							{/if}
							<a class="u-btn add" id="add-person" data-action="add">+</a>
						</ul>
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
<#noescape>
<script type="text/javascript">
	// var alarmRuleList = ${stringify(alarmRuleList!)}; // 同步数据
</script>
</#noescape>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/receiver/list.js"></script>
</body>
</html>
</@compress>
</#escape>