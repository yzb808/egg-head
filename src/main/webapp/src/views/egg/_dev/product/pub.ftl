<#escape x as x!""?html>
<#macro questionHistory class="">	
<div class="g-cnt ${class}">
	<form class="m-form2" id="form" style="margin-bottom:10px;">
		<div class="fmitem">
			<label class="fmlab">应用：</label>
			<div class="fmcnt">
				<select class="u-ipt" name="applicationId">
				    <option value="">全部</option>
					<#if appsInProduct??>
					<#list appsInProduct as x>
					<option value="${x.id}" <#if (RequestParameters.applicationId)?? && (RequestParameters.applicationId?number == x.id?number)>selected</#if>>${x.nodeName!}</option>
					</#list>
					</#if>
				</select>
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab">集群：</label>
			<div class="fmcnt">
				<select class="u-ipt" name="pClusterId">
				    <option value="">全部</option>
					<#if clustersInApp??>
					<#list clustersInApp?keys as x>
						<#assign clusters=clustersInApp[x] />
						<#list clusters as xx>
						<option value="${xx.id}" class="j-cluster ${x}" <#if (RequestParameters.pClusterId)?? && (RequestParameters.pClusterId?number == xx.id?number)>selected</#if>>${xx.nodeName!}</option>
						</#list>
					</#list>
					</#if>
				</select>
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab">状态：</label>
			<div class="fmcnt">
				<select class="u-ipt" name="alarmStatus">
				    <option value="" <#if RequestParameters.alarmStatus??><#else>selected="selected"</#if>>全部</option>
					<option value="critical" <#if RequestParameters.alarmStatus?? && RequestParameters.alarmStatus == 'critical'>selected="selected"</#if>>Critical</option>
					<option value="warning" <#if RequestParameters.alarmStatus?? && RequestParameters.alarmStatus == 'warning'>selected="selected"</#if>>Warning</option>
				</select>
			</div>
		</div>
		<div class="u-iptsearch u-iptsearch-3" style="margin-left:10px;">
			<input type="text" class="u-ipt u-ipt-s5" value="${searchword!}" name="searchword" onKeyPress="if (event.which == 13) return false;" placeholder="搜索内容">
			<input type="button" class="u-btn u-btn-s1 j-search" value="搜索"/>
		</div>
	</form>
	<div class="m-tab">
	    <ul id="tab" data-act="${RequestParameters.type!''}">
	        <li <#if (RequestParameters.alarmType??)><#if RequestParameters.alarmType=='0'>class="z-act"</#if><#else>class="z-act"</#if>><a data-type="0">单机</a></li>
	        <li <#if (RequestParameters.alarmType??) && (RequestParameters.alarmType=='1')>class="z-act"</#if>><a data-type="1">集群</a></li>
	        <li <#if (RequestParameters.alarmType??) && (RequestParameters.alarmType=='3')>class="z-act"</#if>><a data-type="3">VIP</a></li>
	    </ul>
    </div>
	<table class="m-table m-table-1" id="table-list">
		<thead>
			<tr>
				<th>产品名称</th>
				<th>应用名称</th>
				<th>集群名称</th>
				<#if (RequestParameters.alarmType??) && (RequestParameters.alarmType=='0')>
				<th>主机名</th>
				<#elseif (RequestParameters.alarmType??) && (RequestParameters.alarmType=='3')>
				<th>VIP名称</th>
				</#if>
				<th>报警类型</th>
				<th>监控项名称</th>
				<th>数据项名称</th>
				<th>状态</th>
				<th>时间</th>
				<th class="cnt">通知内容</th>
			</tr>
		</thead>
		<tbody><script>console.log(${stringify(alarmHistoryList!)})</script>
			<#if alarmHistoryList??>
			<#list alarmHistoryList as x>
			<tr data-id="${x.id!}">
				<#assign alarmType = ['单机','集群','域','VIP'] />
				<td>${productName}</td>
				<td>${x.appName!}</td>
				<td>${x.clusterName!}</td>
				<#if (RequestParameters.alarmType??) && (RequestParameters.alarmType=='0')>
				<th>${x.serverName!}</th>
				<#elseif (RequestParameters.alarmType??) && (RequestParameters.alarmType=='3')>
				<th>${x.serverName!}</th>
				</#if>
				<td>${alarmType[x.alarmType!]}</td>
				<td>${x.monitorItemName!}</td>
				<td>${x.dataModelName!}</td>
				<td class="f-cb">
					<#if x.alarmStatus?lower_case == 'pending'>
					<span class="u-tag u-tag-pending">pending</span>
					<#elseif x.alarmStatus?lower_case == 'ok'>
					<span class="u-tag u-tag-ok" >ok</span>
					<#elseif x.alarmStatus?lower_case == 'warning'>
					<span class="u-tag u-tag-warning">warning</span>
					<#elseif x.alarmStatus?lower_case == 'critical'>
					<span class="u-tag u-tag-critical">critical</span>
					<#else>
					<span class="u-tag u-tag-error">error</span>
					</#if>
				</td>
				<td>${x.alarmTime?datetime}</td>
				<td class="f-dat"><div style="">${x.alarmContent!}</div></td>
			</tr>
			</#list>
			</#if>
		</tbody>
	</table>
	<@pagination total=total?default(0) />
</div>
</#macro>
</#escape>