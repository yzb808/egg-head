<#escape x as x!""?html>
<#macro monitorList class="" type="">
<div class="g-cnt ${class}">
    <div class="m-tab">
	    <ul id="tab">
	        <#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
	        <li><a href="/sentry/monitor/list?clusterId=${RequestParameters.clusterId}">监控项</a></li>
	        <li><a href="/sentry/alarm?clusterId=${RequestParameters.clusterId}">单机报警</a></li>
	        <li><a href="/sentry/alarm/cluster?clusterId=${RequestParameters.clusterId}">集群报警</a></li>
	        <li class="z-act"><a href="javascript:void(0);">VIP监控项</a></li>
	        <li><a href="/sentry/alarm/vip?clusterId=${RequestParameters.clusterId}">VIP报警</a></li>
	        <#else>
	        <li><a href="/sentry/monitor/list?clusterId=0">监控项</a></li>
	        <li><a href="/sentry/alarm">单机报警</a></li>
	        <li class="z-act"><a href="javascript:void(0);">VIP监控项</a></li>
	        <li><a href="/sentry/alarm/vip">VIP报警</a></li>
	        </#if>
	    </ul>
    </div>
    <#if type=="1">
	<div class="m-bar">
		<div class="u-btns">
			<a href="/sentry/monitor/vip/add" class="u-btn">添加VIP监控</a>
			<a href="javascript:;" data-href="/sentry/monitor/vip/mod" class="u-btn u-btn-c1" id="btn-edit">修改VIP监控</a>
			<span class="u-btn u-btn-c1" id="btn-del">删除VIP监控</span>
			<#-- <span class="u-btn u-btn-c1" id="btn-view">个性化视图</span> -->
		</div>
	</div>
	</#if>
	<table class="m-table m-table-1" id="table" data-id="<#if (RequestParameters.clusterId)??>${RequestParameters.clusterId}</#if>">
		<thead>
			<tr>
				<th class="checkbox"><input type="checkbox" id="select-all"></th>
				<th>监控项名称</th>
				<th>采集间隔(秒)</th>
				<th>协议类型</th>
				<th>采集参数</th>
				<th>创建人</th>
				<th>最后操作时间</th>
			</tr>
		</thead>
		<tbody>
			<#if monitorVipItemList??>
			<#list monitorVipItemList as x>
			<tr>
				<td><input type="checkbox" class="j-check" data-id="${x.id!}" data-type="${x.type?number}"></td>
				<td><a href="javascript:void(0)" data-action="show" data-id="${x.id!}" title="查看详情">${x.name!}</a></td>
				<td>${x.interval!}</td>
				<td>${x.protocol!}</td>
				<td>${x.arguments!}</td>
				<td>${x.creator!}</td>
				<td>${x.lastOpTime?datetime}</td>
			</tr>
			</#list>
			</#if>
		</tbody>
	</table>
	<@pagination total=total?default(0) />
</div>
</#macro>

<#macro jstTemplate>
<div style="display:none" id ="jst-template">
	<#noparse>
	<textarea name="jst" id="jst-win-form-del">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="jst" id="jst-win-form-show">
		<div class="m-form">
			<div class="fmitem">
				<label class="fmlab">监控项名称：</label>
				<div class="fmcnt">${name}</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集时间段：</label>
				<div class="fmcnt">
					{if collectorRange == "[* * * * * ?]"}
					全天
					{else}
					${collectorRange}
					{/if}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集间隔时间：</label>
				<div class="fmcnt">
					${collectorInterval}秒
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">超时时间：</label>
				<div class="fmcnt">${timeout}</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">采集指令：</label>
				<div class="fmcnt">
					${collectorName}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">脚本名称：</label>
				<div class="fmcnt">
					${scriptName}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">脚本参数：</label>
				<div class="fmcnt">
					<div>${arguments}</div>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">执行账号：</label>
				<div class="fmcnt">
					${execAccount}
				</div>
			</div>
		</div>
	</textarea>
	<textarea name="jst" id="jst-win-form-viewset">
		<form id="viewset-form">
			<textarea name="viewset" class="u-ipt u-ipt-block u-ipt-block-1" rows="10">${xmldata}<&#47;textarea>
		</form>
	</textarea>
	</#noparse>
</div>
</#macro>
<#macro monitorCollect class="">
<#if monitorItem??>
<#assign collectorId=monitorItem.collectorId>
<#assign collectorName=monitorItem.collectorName>
<#assign name=monitorItem.name>
<#assign descp=monitorItem.descp>
<#assign scriptName=monitorItem.scriptName>
<#assign arguments=monitorItem.arguments>
<#assign collectorInterval=monitorItem.interval>
<#assign collectorRange=monitorItem.collectorRange>
<#assign timeout=monitorItem.timeout>
<#assign execAccount=monitorItem.execAccount>
<#assign protocol=monitorItem.protocol>
</#if>
<div class="g-cnt ${class}">
	<#if collectorType??>
		<input type="hidden" value="${collectorType}" id="collectorType"/>
	</#if>
	<form id="form" class="form monitor-form">
		<div class="m-form m-form-1">
			<div class="fmitem">
				<label class="fmlab">&#12288;&#12288;&#12288;<i>*</i>采集器：</label>
				<div class="fmcnt">
					<div class="u-iptbtn" id="collector-id">
						<input type="text" class="u-ipt u-ipt-s2" data-id="${collectorId!}" name="collectorId" readonly="readonly" value="${collectorName!}">
						<#if RequestParameters.monitorItemId??>
						<#else>
						<span class="btn">选择</span>
						</#if>
					</div>
				</div>
			</div>
		</div>
		<div class="m-form">
			<div class="fmitem">
				<label class="fmlab">&#12288;<i>*</i>监控项名称：</label>
				<div class="fmcnt">
					<input type="text" name="name" class="u-ipt" data-required="true" data-message="不能为空" value="${name!}" id="input-monitorName">
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab"><i>*</i>协议类型：</label>
				<div class="fmcnt protocol-type">
					<input type="checkbox" class="f-vam" name="protocol" value="TCP" <#if protocol?? && protocol?contains('TCP')>checked="checked"</#if>/><span>TCP</span>
					<input type="checkbox" class="f-vam" name="protocol" value="HTTP" <#if protocol?? && protocol?contains('HTTP')>checked="checked"</#if>/><span>HTTP</span>
					<input type="checkbox" class="f-vam" name="protocol" value="UDP" <#if protocol?? && protocol?contains('UDP')>checked="checked"</#if>/><span>UDP</span>
					<input type="checkbox" class="f-vam" name="protocol" value="HTTPS" <#if protocol?? && protocol?contains('HTTPS')>checked="checked"</#if>/><span>HTTPS</span>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">说明和处理：</label>
				<div class="fmcnt"><textarea class="u-ipt u-txtarea-1" name="descp">${descp!}</textarea></div>
			</div>
		</div>
		<div class="m-form">
			<div class="fmitem j-collectoritem">
				<label class="fmlab">脚本名称：</label>
				<div class="fmcnt scriptName">${scriptName!}</div>
			</div>
			<div class="fmitem j-collectoritem">
				<label class="fmlab">脚本参数：</label>
				<div class="fmcnt">
					<textarea class="u-ipt" name="arguments">${arguments!}</textarea>
				</div>
			</div>
			<div class="fmitem j-collectoritem">
				<label class="fmlab">采集时间段：</label>
				<div class="fmcnt f-cb">
					<select name="collectorRange">
						<option value="[* * * * * ?]" <#if collectorRange??><#if collectorRange == '[* * * * * ?]'>selected="selected"</#if><#else>selected="selected"</#if>>全天</option>
						<option value="self" <#if collectorRange?? && collectorRange != '[* * * * * ?]' && collectorRange!= ''>selected="selected"</#if>>自定义</option>
					</select>
					<span class="selfTime hide" id="self-box">
						<input type="text" class="u-ipt u-ipt-s6" id="selfTime" name="selfTime" value="${collectorRange!}"/>
						<div>
							<p class="f-red">注意：不合理的采集时间段会影响到正常的报警，操作需谨慎！如不清楚建议采用全天或者咨询运维开发值班！</p><p>采集时间段的解释和quartz语法请点击<a href="http://doc.hz.netease.com/pages/viewpage.action?pageId=48877622" target="_blank" style="color:#0095d9;font-weight:bold;">这里</a></p></div>
					</span>
				</div>
			</div>
			<div class="fmitem j-collectoritem">
				<label class="fmlab"><i>*</i>采集间隔时间：</label>
				<div class="fmcnt">
					<div class="u-iptw">
						<i class="unit">s</i>
						<input type="text" name="collectorInterval" class="u-ipt" value="${collectorInterval!}" data-required="true" data-message="不能为空">
					</div>
				</div>
			</div>
			<div class="fmitem j-collectoritem">
				<label class="fmlab"><i>*</i>超时时间：</label>
				<div class="fmcnt">
					<div class="u-iptw">
						<i class="unit">s</i>
						<input type="text" name="timeout" class="u-ipt" value="${timeout!}" data-required="true" data-message="不能为空">
					</div>
				</div>
			</div>
			<div class="fmitem j-collectoritem">
				<label class="fmlab"><i>*</i>执行账号：</label>
				<div class="fmcnt">
					<input type="text" name="execAccount" class="u-ipt" value="${execAccount!}" data-required="true" data-message="不能为空">
				</div>
			</div>
		</div>
		<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
		<#else>
		<div class="u-btnfm">
			<span class="u-btn u-btn-s3" id="submit">提 交</span>
			<a class="u-btn u-btn-s4" href="javascript:history.go(-1)">取 消</a>
		</div>
		</#if>
	</form>
</div>
</#macro>

<#macro jstTemplate2>
<div style="display:none" id="jst-template">
	<#noparse>
	<textarea name="jst" id="jst-win-collector">
		<form id="collector-id-form" onsubmit="return false">
			<div class="u-iptsearch u-iptsearch-3">
				<input type="text" class="u-ipt u-ipt-s2" value="${searchword}" name="searchword" placeholder="搜索内容" id="search-ipt1">
				<span class="u-btn u-btn-s1 j-search" id="search-btn1" data-action="search">搜索</span>
			</div>
			<table class="m-table" id="collector-list">
				<thead>
					<tr>
						<th></th><th>采集器名称</th><th>采集器描述</th><th>创建人</th><th>类型</th><th>执行账号</th><th>级别</th><th>超时时间</th><th>修改时间</th>
					</tr>
				</thead>
				<tbody>
					{list collectorList as x}
					<tr>
						<td><input type="radio" name="collectorIdSel" value="${x.id}" data-id="${x.id}"></td>
						<td>${x.collectorName}</td>
						<td>${x.descp}</td>
						<td>${x.creator}</td>
						<td>{if x.type == 'vip'}VIP采集器{/if}</td>
						<td>{if x.execAccount != 'unknow'}${x.execAccount}{/if}</td>
						{if x.scope == 'pub'}
						<td>公有</td>
						{else}
						<td>私有</td>
						{/if}
						<td>${x.timeout} s</td>
						<td>${x.modifyTime}</td>
					</tr>
					{/list}
				</tbody>
			</table>
			<div class="win-pagination j-page" id="win-pagination"></div>
		</form>
	</textarea>
	<textarea name="jst" id="jst-win-collector2">
		<table class="m-table" id="collector-list">
			<thead>
				<tr>
					<th></th><th>采集器名称</th><th>采集器描述</th><th>创建人</th><th>类型</th><th>执行账号</th><th>级别</th><th>超时时间</th><th>修改时间</th>
				</tr>
			</thead>
			<tbody>
				{list collectorList as x}
				<tr>
					<td><input type="radio" name="collectorIdSel" value="${x.id}" data-id="${x.id}"></td>
					<td>${x.collectorName}</td>
					<td>${x.descp}</td>
					<td>${x.creator}</td>
					{if x.type == 'system'}
					<td>系统采集器</td>
					{else}
					<td>应用采集器</td>
					{/if}
					<td>{if x.execAccount != 'unknow'}${x.execAccount}{/if}</td>
					{if x.scope == 'pub'}
					<td>公有</td>
					{else}
					<td>私有</td>
					{/if}
					<td>${x.timeout} s</td>
					<td>${x.modifyTime}</td>
				</tr>
				{/list}
			</tbody>
		</table>
	</textarea>
	<textarea name="jst" id="jst-win-list-tip">
		<div class="m-bar">
			该采集器上存在下列默认报警规则，是否添加报警
		</div>
		<div id="win-alarm-table">
			<table class="m-table m-table-2" id="defaultAlarm-table">
				<thead>
					<tr>
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
					{if x.name==""}
						{var collectorName = monitorName}
					{else}
						{var collectorName = x.name}
					{/if}
					<tr>
						<td><input type="text" value="${collectorName}" name="" class="txt" data-id="${x.id}"/></td>
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
	</textarea>
	</#noparse>
</div>
</#macro>
</#escape>