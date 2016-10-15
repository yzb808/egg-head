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
	</@head>
	<script src="${jsCommon}/module/My97DatePicker/WdatePicker.js"></script>
</head>
<body id="sentry-system">
<div class="g-doc">
	<div class="g-hd">
		<@nav index=2 />
	</div>
	<div class="g-bd" id="content">
		<div class="g-sd <#if (RequestParameters.show)??>lt-24<#else>lt0</#if>">
			<#if user.external>
			<@sidenav tree=my index=1/>
			<#else>
			<@sidenav tree=all index=1/>
			</#if>
		</div>
		<div class="g-mn g-mn-1 <#if (RequestParameters.show)??>lt0<#else>lt24</#if>">
			<#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId)!="-1">
			<div class="g-cnt g-cnt-2">
				<div class="m-tab">
				    <ul id="tab">
				        <li><a href="/sentry/status?clusterId=${RequestParameters.clusterId}&status=all">单机状态</a></li>
				        <li><a href="/sentry/status/cluster?clusterId=${RequestParameters.clusterId}&status=all">集群状态</a></li>
				        <li class="z-act"><a href="javascript:void(0);">VIP状态</a></li>
				    </ul>
			     </div>
				<form id="search-form">
					<input type="hidden" value="${RequestParameters.clusterId}" name="clusterId"/>
					<div class="m-form2">
						<div class="fmitem">
							<label class="fmlab">VIP：</label>
							<div class="fmcnt">
								<select class="u-ipt" name="hostId">
								<#if vipList??>
								    <option value="" >全部</option>
									<#list vipList as vip>
										 <option value="${vip.id}" <#if RequestParameters.vipId?? && RequestParameters.vipId == '${vip.id}' >selected="selected"</#if>>${vip.vipName}</option>
							        </#list>
						        </#if>
								</select>
							</div>
						</div>
						<div class="fmitem">
							<label class="fmlab">监控项：</label>
							<div class="fmcnt">
							<select class="u-ipt" name="monitorItemId">
								<#if configlist??>
								    <option value="" >全部</option>
									<#list configlist as config>
									<option value="${config.id}" <#if RequestParameters.monitorItemId?? && RequestParameters.monitorItemId == '${config.id}' >selected="selected"</#if>>${config.name}</option>
							        </#list>
						        </#if>
							</select>
							</div>
						</div>
						<div class="fmitem">
							<label class="fmlab">状态：</label>
							<div class="fmcnt">
								<select class="u-ipt" name="status">
									<option value="all"  <#if RequestParameters.status?? && RequestParameters.status == 'all'>selected="selected"</#if>>全部</option>
									<option value="1,3,4,5" <#if RequestParameters.status??><#if RequestParameters.status == '1,3,4,5'>selected="selected"</#if><#else>selected="selected"</#if>>异常</option>
									<option value="1"    <#if RequestParameters.status?? && RequestParameters.status == '1'>selected="selected"</#if>>Pending</option>
									<option value="2"    <#if RequestParameters.status?? && RequestParameters.status == '2'>selected="selected"</#if>>OK</option>
									<option value="3"    <#if RequestParameters.status?? && RequestParameters.status == '3'>selected="selected"</#if>>Error</option>
									<option value="4"    <#if RequestParameters.status?? && RequestParameters.status == '4'>selected="selected"</#if>>Warning</option>
									<option value="5"    <#if RequestParameters.status?? && RequestParameters.status == '5'>selected="selected"</#if>>Critical</option>
								</select>
							</div>
						</div>
						<div class="fmitem">
							<label class="fmlab">通知状态：</label>
							<div class="fmcnt">
								<select class="u-ipt" name="isAlarmClosed">
									<option value="2"  <#if RequestParameters.isAlarmClosed?? && RequestParameters.isAlarmClosed==''>selected="selected"</#if>>全部</option>
									<option value="0" <#if RequestParameters.isAlarmClosed?? && RequestParameters.isAlarmClosed=='0'>selected="selected"</#if>>开启</option>
									<option value="1" <#if RequestParameters.isAlarmClosed?? && RequestParameters.isAlarmClosed=='1'>selected="selected"</#if>>关闭</option>
								</select>
							</div>
						</div>
						<div class="fmitem">
							<div class="fmcnt">
								<label><input type="checkbox" name="onlyAlarmRule" style="vertical-align: middle;margin-right:2px;" <#if RequestParameters.onlyAlarmRule?? && RequestParameters.onlyAlarmRule=='1'>checked="checked"</#if>/>只显示报警规则项</label>
							</div>
						</div>
						<div class="fmitem">
							<input type="button" class="u-btn u-btn-s1" name="search-ok" value="搜索"/>
						</div>
					</div>
				</form>
				<div class="m-bar m-bar-1">
					<div class="u-btns">
						<a href="javascript:;" class="u-btn" id="btn-quick-close">快速关闭报警2小时</a>
						<a href="javascript:;" class="u-btn u-btn-c1" id="btn-close">关闭报警通知</a>
						<span class="u-btn u-btn-c1" id="btn-open">打开报警通知</span>
						<#if currentStatusCount??>
							<span class="u-btn u-btn-c1">[实际记录数:${currentStatusCount!},目标记录数${targetStatuscount!}]</span>
						</#if>
					</div>
					<div class="dtl" id="status-total">[&nbsp;总计:
						<span class="color color-ok"></span><span class="count" data-type="2">${okNum!}</span>
						<span class="color color-warning"></span><span class="count" data-type="4">${warningNum!}</span>
						<span class="color color-critical"></span><span class="count" data-type="5">${criticalNum!}</span>
						<span class="color color-error"></span><span class="count" data-type="3">${errorNum!}</span>
						<span class="color color-pending"></span><span class="count" data-type="1">${pendingNum!}</span>
					]</div>
				</div>
				<table class="m-table m-table-1" id="table-list">
					<thead>
						<tr>
							<th class="checkbox"><input type="checkbox" id="select-all"></th>
							<th>VIP</th>
							<th>监控项</th>
							<th>数据项</th>
							<th>监控域</th>
							<th>状态</th>
							<th class="icn">通知</th>
							<th>持续时间</th>
							<th>采集时间</th>
							<#if user.root>
							<th>状态重置</th>
							</#if>
						</tr>
					</thead>
					<tbody>
						<#if statuses??>
							<#list statuses as x>
							<tr>
								<td><input type="checkbox" class="j-check" data-id="${x.id!}"></td>
								<td>${x.vipName!}</td>
								<td>
									<span>${x.monitorItemName!}</span>
									<a href="/sentry/monitor/vip/mod?clusterId=${RequestParameters.clusterId}&monitorItemId=${x.monitorItemId!}" class="u-tag-monitor"></a>
									<a href="javascript:;" class="u-tag-view" data-action="view" data-id="${x.id}"></a>
								</td>
								<td><a href="javascript:;" data-action="rule" data-id="${x.id}">${x.dataModelName!}</a></td>
								<td>${x.domainName!}</td>
								<td class="f-cb">
									<#if x.status == 1>
									<span class="u-tag u-tag-pending" data-id="${x.id}">pending</span>
									<#elseif x.status == 2>
									<span class="u-tag u-tag-ok" data-id="${x.id}">ok</span>
									<#elseif x.status == 3>
									<span class="u-tag u-tag-error">error</span>
									<span class="u-tag-detail" data-action="show" data-id="${x.id}"></span>
									<#elseif x.status == 4>
									<span class="u-tag u-tag-warning">warning</span>
									<span class="u-tag-detail" data-action="show" data-id="${x.id}"></span>
									<#else>
									<span class="u-tag u-tag-critical">critical</span>
									<span class="u-tag-detail" data-action="show" data-id="${x.id}"></span>
									</#if>
								</td>
								<td><#if x.isAlarmClosed??><#if x.isAlarmClosed==0><i class="u-icon u-icon-open-alarm"></i><#else><i class="u-icon u-icon-close-alarm"></i></#if></#if>
								</td>
								<td>${x.duration!}</td>
								<td>${x.latestDataTime!}</td>
								<#if user.root>
								<td><span style="width:50px;display:inline-block;" class="redis">${x.redisStatus!}</span><i class="u-icon u-icon-refresh" data-action="status" data-index="${x_index}"></i></td>
								</#if>
							</tr>
							</#list>
						</#if>
					</tbody>
				</table>
				<@pagination total=total?default(0) />
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
			<@menu index=1/>
		</div>
	</div>
</div>

<div style="display:none" id ="jst-template">
<#noparse>
<textarea name="jst" id="jst-win-form-close">
	<form id="form">
		<div class="m-form">
		<div class="fmitem">
			<label class="fmlab">关闭时间：</label>
			<div class="fmcnt">
				<div class="u-radios" id="close-hours">
					<label><input type="radio" value="1" name="hours" class="u-radio" checked="checked">1小时</label>
					<label><input type="radio" value="2" name="hours" class="u-radio" >2小时</label>
					<label><input type="radio" value="3" name="hours" class="u-radio" >3小时</label>
					<label><input type="radio" value="6" name="hours" class="u-radio" >6小时</label>
					<label><input type="radio" value="12" name="hours" class="u-radio">12小时</label>
					<label><input type="radio" value="24" name="hours" class="u-radio">24小时</label>
					<label><input type="radio" value="168" name="hours" class="u-radio">1周</label>
					<label><input type="radio" value="-1" name="hours" class="u-radio js-other">其他</label>
					<div class="js-time" style="display:none;">
						<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1 startTime" name="startTime"/> &nbsp;~&nbsp;
						<input type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1 endTime" name="endTime"/>
					</div>
				</div>
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab">关闭原因：</label>
			<div class="fmcnt">
				<div class="u-radios" id="close-reason">
					<label><input type="radio" value="alarm-processing" name="reason" class="u-radio" checked="checked">报警处理中</label>
					<label><input type="radio" value="item-online" name="reason" class="u-radio" >项目上线</label>
					<label><input type="radio" value="item-offline" name="reason" class="u-radio" >项目下线</label>
					<label><input type="radio" value="hardware-maintain" name="reason" class="u-radio" >硬件维护</label>
					<label><input type="radio" value="other-" name="reason" class="u-radio" >自定义<div class="u-iptw"><input type="text" name="reasonContent" class="u-ipt u-ipt-s1 f-reasoncnt" ></div></label>
				</div>
			</div>
		</div>
		</div>
	</form>	
</textarea>
<textarea name="jst" id="jst-win-form-status">
	<div class="m-form">
		<div class="fmitem"><label class="fmlab">主机名：</label><div class="fmcnt">{if aliasname}${aliasname}{else}${hostname}{/if}</div></div>
		<div class="fmitem"><label class="fmlab">数据项：</label><div class="fmcnt">${dataModel}</div></div>
		<div class="fmitem"><label class="fmlab">实例名称：</label><div class="fmcnt">${instanceName}</div></div>
		<div class="fmitem"><label class="fmlab">采集时间：</label><div class="fmcnt">${collectTime}</div></div>
		<div class="fmitem"><label class="fmlab">数据采集详情：</label><div class="fmcnt">${dataDetail}</div></div>
	</div>
</textarea>
<textarea name="jst" id="jst-win-form-vip-status">
	<div class="m-form">
		<div class="fmitem"><label class="fmlab">VIP名称：</label><div class="fmcnt">${vipName}</div></div>
		<div class="fmitem"><label class="fmlab">数据项：</label><div class="fmcnt">${dataModel}</div></div>
		<div class="fmitem"><label class="fmlab">监控域：</label><div class="fmcnt">${domainName}</div></div>
		<div class="fmitem"><label class="fmlab">采集时间：</label><div class="fmcnt">${collectTime}</div></div>
		<div class="fmitem"><label class="fmlab">数据采集详情：</label><div class="fmcnt">${dataDetail}</div></div>
	</div>
</textarea>
</#noparse>
</div>

<#noescape>
<script type="text/javascript">
	var STATUSLIST = [];
	var viewCountEachRow;
	<#if statuses??>
		<#list statuses as x>
			STATUSLIST.push(${x});
		</#list>
	</#if>
</script>
</#noescape>	
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/status/vip.js"></script>
</body>
</html>
</#escape>
