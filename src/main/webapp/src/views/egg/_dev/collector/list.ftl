<#escape x as x?html>
<@compress single_line=!cfg_develop>
<#assign collectorType = {"system":"系统采集","app":"应用采集器","vip":"VIP采集"}>
<#assign collectorScope= {"pub":"公有采集器","personal":"私有采集器"}>
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
						<a href="/sentry/collector/add" class="u-btn">添加采集器</a>
					</div>
					<form class="f-fr">
						<div class="u-iptsearch u-iptsearch-3">
							<#-- <label><input type="checkbox" name="creator" style="vertical-align: middle;" value="1" <#if creator=='1'>checked="checked"</#if>/>我是创建人</label> -->
							<input type="text" name="searchWord" class="u-ipt u-ipt-s2" id="search-product" value="${searchword!}">
							<input type="submit" class="u-btn u-btn-s1" value="搜索"/>
						</div>
					</form>
				</div>
				<table class="m-table" id="table-list">
					<thead>
						<tr>
							<th>采集器名称</th>
							<th>采集器描述</th>
							<th>创建人（被授权人）</th>
							<th>类型</th>
							<th>执行账号</th>
							<th>级别</th>
							<th>超时时间</th>
							<th>修改时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<#if collectors??>
						<#list collectors as x>
						<tr>
							<td><a href="javascript:void(0)" data-action="show" data-id="${x.id!}" title="查看详情">${x.collectorName!}</a></td>
							<td title="${x.descp!}">${x.descp!}</td>
							<td>${x.creatorName!}</td>
							<td>${collectorType[x.type!]!}</td>
							<td>${x.defaultExecAccount!}</td>
							<td>${collectorScope[x.scope!]!}</td>
							<td>${x.timeout!}</td>
							<td>${x.modifyTime!}</td>
							<td><span class="u-icons">
								<a href="/sentry/collector/modify?id=${x.id!}" class="u-icon u-icon-edit" title="修改"></a>
								<i class="u-icon u-icon-del2" data-action="del" data-id="${x.id!}" title="删除"></i>
								<i class="u-icon u-icon-view" data-action="view" data-id="${x.id!}" title="图表配置"></i>
								<i class="u-icon u-icon-alarm" data-action="alarm" data-id="${x.id!}" title="报警规则配置"></i>
								<a href="/sentry/collector/copy?id=${x.id!}&action=copy" class="u-icon u-icon-copy" title="复制"></a>
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

<div style="display:none" id="jst-template">
	<#noparse>
	<textarea name="jst" id="jst-win-form-del">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="jst" id="jst-win-form-show">
		<div class="m-form">
			<div class="fmitem">
				<label class="fmlab">采集器名称：</label>
				<div class="fmcnt">${collectorName}</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集器类型：</label>
				<div class="fmcnt">
					{if type=="system"}
						脚本采集
					{elseif type=="app"}
						java应用数据采集
					{elseif type=="vip"}
						vip采集
					{/if}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集器级别：</label>
				<div class="fmcnt">
					{if scope=="pub"}
						公有
					{elseif scope=="personal"}
						私有
					{/if}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集器描述：</label>
				<pre class="fmcnt">${descp}</pre>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集方式：</label>
				<div class="fmcnt">
					{if collectMethod=="superagent"}
						外部执行
					{elseif collectMethod=="local"}
						本机采集
					{/if}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">操作系统：</label>
				<div class="fmcnt">
					${os}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">是否agent内置：</label>
				<div class="fmcnt">
					{if isInner==1}
					是
					{elseif isInner==0}
					否
					{/if}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">是否支持多实例：</label>
				<div class="fmcnt">
					{if multiInstance==true}
					是
					{elseif multiInstance==false}
					否
					{/if}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">默认执行账号：</label>
				<div class="fmcnt">${defaultExecAccount}</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">默认采集时间段：</label>
				<div class="fmcnt">
					全天
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集间隔时间：</label>
				<div class="fmcnt">
					${defaultInterval} 秒
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">默认超时时间：</label>
				<div class="fmcnt">
					${defaultTimeout} s
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">脚本名称：</label>
				<div class="fmcnt">${scriptName}</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">脚本参数：</label>
				<div class="fmcnt">${arguments}</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">脚本类型：</label>
				<div class="fmcnt">
					${scriptType}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集器输出格式：</label>
				<div class="fmcnt">
					{if outputType=="txt"}
					文本
					{elseif outputType=="json"}
					JSON
					{/if}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">脚本内容：</label>
				<div class="fmcnt">
					<textarea class="u-ipt u-ipt-s5" rows="40" name="scriptText" readonly=true>${scriptText}<&#47;textarea>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">输出数据项：</label>
				<div class="fmcnt">
					<table class="m-table">
						<thead>
							<tr>
								<th>数据项名称</th>
								<th>指标项名称</th>
								<th>指标项描述</th>
								<th>指标项数据类型</th>
								<th>指标项表达式</th>
								<th>指标项默认值</th>
								<th>聚合方式</th>
							</tr>
						</thead>
						<tbody>
							{list dataModel as x}
								{if x.dataModelField.length>0}
								<tr>
									<td rowspan="${x.dataModelField.length}">${x.name}</td>
									<td>${x.dataModelField[0].fieldName}</td>
									<td>${x.dataModelField[0].descp}</td>
									<td>${x.dataModelField[0].dataType}</td>
									<td>${x.dataModelField[0].expression}</td>
									<td>${x.dataModelField[0].defaultValue}</td>
									<td>${x.dataModelField[0].defaultAggrFun}</td>
								</tr>
								{list x.dataModelField as y}
									{if y_index>0}
									<tr>
										<td>${y.fieldName}</td>
										<td>${y.descp}</td>
										<td>${y.dataType}</td>
										<td>${y.expression}</td>
										<td>${y.defaultValue}</td>
										<td>${y.defaultAggrFun}</td>
									</tr>
									{/if}
								{/list}
								{/if}
							{/list}
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</textarea>
	<textarea name="jst" id="jst-win-form-viewset">
		<form id="viewset-form">
			<textarea name="viewset" class="u-ipt u-ipt-block u-ipt-block-1" rows="10">${xmldata}<&#47;textarea>
		</form>
	</textarea>
	<textarea name="jst" id="jst-win-alarm-list">
		<div class="m-bar">
			<ul class="u-btns">
				<li class="j-add u-btn" id="btn-add">创建报警</li>
				<li class="j-mod u-btn u-btn-c1" id="btn-edit">修改报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-del">删除报警</li>
			</ul>
		</div>
		<div id="win-alarm-table">
			<table class="m-table m-table-2" id="table">
				<thead>
					<tr>
						<th class="checkbox"><input type="checkbox" class="j-sel"></th>
						<th>报警项名称</th>
						<th>数据项</th>
						<th>Critical表达式</th>
						<th>Warning表达式</th>
						<th>报警内容</th>
						<th>连续触发次数</th>
						<th>发送间隔</th>
					</tr>
				</thead>
				<tbody>
					{list alarmRules as x}
					{if x.name == ""}
						{var collectorName = "[同添加时监控项名称]"}
					{else}
						{var collectorName = x.name}
					{/if}
					<tr>
						<td><input type="checkbox" class="j-check" data-id="${x.id}"></td>
						<td>${collectorName}</td>
						<td>${x.dataModelName}</td>
						<td>${x.criticalExpression}</td>
						<td>${x.warnExpression}</td>
						<td title="${x.outputTemplate}">${x.outputTemplate}</td>
						<td>${x.threshold}</td>
						<td>${x.suppressInterval}</td>
					</tr>
					{/list}
				</tbody>
			</table>
		</div>
		<div class="win-pagination j-page" id="win-pagination"></div>
	</textarea>
	<textarea name="jst" id="jst-win-alarm-table">
		<table class="m-table m-table-2" id="table">
			<thead>
				<tr>
					<th class="checkbox"><input type="checkbox" class="j-sel"></th>
					<th>报警项名称</th>
					<th>数据项</th>
					<th>Critical表达式</th>
					<th>Warning表达式</th>
					<th>报警内容</th>
					<th>连续触发次数</th>
					<th>发送间隔</th>
				</tr>
			</thead>
			<tbody>
				{list alarmRules as x}
				{if x.name == ""}
					{var collectorName = "[同添加时监控项名称]"}
				{else}
					{var collectorName = x.name}
				{/if}
				<tr>
					<td><input type="checkbox" class="j-check" data-id="${x.id}"></td>
					<td>${collectorName}</td>
					<td>${x.dataModelName}</td>
					<td>${x.criticalExpression}</td>
					<td>${x.warnExpression}</td>
					<td title="${x.outputTemplate}">${x.outputTemplate}</td>
					<td>${x.threshold}</td>
					<td>${x.suppressInterval}</td>
				</tr>
				{/list}
			</tbody>
		</table>
	</textarea>
	<textarea name="jst" id="jst-win-collector">
		<form id="form-add" class="m-form form">
			<div class="fmitem">
				<label class="fmlab">数据项：</label>
				<div class="fmcnt">
					<select name="dataModelId" data-action="dataModel">
						{list dataItems as x}
						<option value="${x.id}" {if dataModelId==x.id}selected="selected"{/if}>${x.name}</option>
						{/list}
					</select>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">报警项名称：</label>
				<div class="fmcnt">
					<div><label><input type="radio" name="name" class="u-radio" {if name==""}checked=checked{/if} id="win-radio-default">同添加时监控项名称</label></div>
					<div><label><input type="radio" name="name" class="u-radio" {if name!=""}checked=checked{/if} id="win-radio-custom">自定义</label>&nbsp;&nbsp;
					<input type="text" class="u-ipt alarmName" name="name" value="${name}" style="width:210px;" id="win-input-alarmName"></div>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">Critical表达式：</label>
				<div class="fmcnt">
					<textarea class="u-ipt" name="criticalExpression" data-action="critical">${criticalExpression}<&#47;textarea>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">Warning表达式：</label>
				<div class="fmcnt">
					<textarea class="u-ipt" name="warnExpression" data-action="warning">${warnExpression}<&#47;textarea>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab"><i>*</i>报警内容：</label>
				<div class="fmcnt">
					<textarea class="u-ipt" name="outputTemplate" data-required="true" data-message="不能为空">${outputTemplate}<&#47;textarea>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab"><i>*</i>连续触发次数：</label>
				<div class="fmcnt">
					<div class="u-iptw">
						<i class="unit">次</i>
						<input type="text" class="u-ipt" name="threshold" value="${threshold|default:3}" data-required="true" data-tip="超过阀值，发送报警 eg：配置3即连续" data-message="不能为空"/>
					</div>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab"><i>*</i>发送间隔：</label>
				<div class="fmcnt">
					<input type="text" class="u-ipt" name="suppressInterval" value="${suppressInterval|default:3600}" data-required="true" data-tip=">=60s，连续两次发送通知的最小时间间隔" data-message="不能为空"/>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">报警通知策略模板：</label>
				<div class="fmcnt">
					<select name="alarmTemplateId">
						{if alarmTemplateList}
						{list alarmTemplateList as x}
							<option value="${x.id}" {if alarmTemplateId==x.id}selected="selected"{/if}>${x.name}</option>
						{/list}
						{/if}
					</select>
				</div>
			</div>
		</form>
		<div id="alarm-table" class="f-fl table m-alarm-table">
			<div class="alarm-rule">
				<p>报警规则表达式举例：(详细用法请点击<a href="http://doc.hz.netease.com/pages/viewpage.action?pageId=43573142" class="alarm-color" target="_blank">这里</a>)</p> 
				<p class="rule-content">负载超过1: <span class="alarm-color">load1 &gt; 1</span><br>  
				利用率超过90%：<span class="alarm-color">(total-free)*100/total >= 90</span><br>  
				字符串不包含error：<span class="alarm-color">! string.contains(msg,"epay")</span><br> 
				值为空或不为空：<span class="alarm-color">var == nil，var != nil</span><br>   
				</p>
				<p>报警发送内容举例：（变量前记得加$）</p>
				<p class="rule-content">系统当前负载为$load1</p>
			</div>
			<div id="alarm-items" class="alarm-items"></div>
		</div>
	</textarea>
	<textarea name="jst" id="jst-win-table">
		<table class="m-table">
			<thead> 
				<tr>
					<th>指标项名称</th><th>描述</th><th>数据类型</th>
				</tr>
			</thead>
			<tbody>
				{list tableList as x}
					<tr>
						<td>${x.fieldName}</td><td>${x.descp}</td><td>${x.dataType}</td>	
					</tr>
				{/list}
			</tbody>
		</table>
	</textarea>
	<textarea name="jst" id="form-del">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>您确定要删除该报警项?</div>
	</textarea>
	</#noparse>
</div>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}"></script>
<script src="${jsPages}/sentry/collector/list.js"></script>
</body>
</html>
</@compress>
</#escape>