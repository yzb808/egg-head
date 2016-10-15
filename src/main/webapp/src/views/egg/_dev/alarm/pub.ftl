<#escape x as x!""?html>
<#macro monitorAlert class="">
<div class="g-cnt ${class}">
	<div id="form" class="form">
	    <div class="m-tab">
		    <ul id="tab">
		    	<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>  <#-- 集群 -->
		        <li><a href="/sentry/monitor/list?clusterId=${RequestParameters.clusterId}">监控项</a></li>
		        <li class="z-act"><a href="javascript:void(0);">单机报警</a></li>
		        <li><a href="/sentry/alarm/cluster?clusterId=${RequestParameters.clusterId}">集群报警</a></li>
		        <li><a href="/sentry/monitor/vip/list?clusterId=${RequestParameters.clusterId}">VIP监控项</a></li>
		        <li><a href="/sentry/alarm/vip?clusterId=${RequestParameters.clusterId}">VIP报警</a></li>
		        <#else> <#-- 基础 -->
		        <li><a href="/sentry/monitor/list?clusterId=0">监控项</a></li>
		        <li class="z-act"><a href="javascript:void(0);">单机报警</a></li>
		        <li><a href="/sentry/monitor/vip/list?clusterId=0">VIP监控项</a></li>
		        <li><a href="/sentry/alarm/vip">VIP报警</a></li>
		        </#if>
		    </ul>
	     </div>
	     <#if RequestParameters.clusterId??>
		<div class="m-form m-alarm-person">
			<div class="fmitem">
				<label class="fmlab alarmlab">&#12288;报警接收人：</label>
				<div class="fmcnt">
					<ul class="f-fl itms" id="person-list">
						<#if noticePeople??>
						<#list noticePeople as person>
						<li class="j-cd">
							<input type="text" class="j-flag u-ipt person" value="${person.userName}" data-id="${person.userId}" placeholder="请输入邮箱前缀"/>
							<i class="u-icon u-icon-del remove-person" data-action="del"></i>
						</li>
						</#list>
						</#if>
						<a class="u-btn add" id="add-person" data-action="add">+</a>
						<a class="u-btn save-btn" id="save-person" data-action="save">保存</a>
					</ul>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab alarmlab">&#12288;报警联系人组：</label>
				<div class="fmcnt">
					<ul class="f-fl itms" id="person-list-group">
						<#if noticeGroup??>
						<#list noticeGroup as person>
						<li class="j-cd">
							<input type="text" class="j-flag u-ipt person" value="${person.groupName}" data-id="${person.groupId}" placeholder="请输入邮箱前缀"/>
							<i class="u-icon u-icon-del remove-person" data-action="del"></i>
						</li>
						</#list>
						</#if>
						<a class="u-btn add" id="add-person-group" data-action="add-group">+</a>
						<a class="u-btn save-btn" id="save-person2" data-action="save2">保存</a>
					</ul>
				</div>
			</div>
		</div>
		</#if>
		<div class="m-bar">
			<ul class="u-btns">
				<li class="j-add u-btn" id="btn-add">创建报警</li>
				<li class="j-mod u-btn u-btn-c1" id="btn-edit">修改报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-del">删除报警</li>
				<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
				<li class="j-del u-btn u-btn-c1" id="btn-close">关闭报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-open">打开报警</li>
				</#if>
			</ul>
		</div>
		<table class="m-table m-table-2" id="table" data-id="<#if (RequestParameters.clusterId)??>${RequestParameters.clusterId}</#if>">
			<thead>
				<tr>
					<th class="checkbox"><input type="checkbox" class="j-sel"></th>
					<th>报警项名称</th>
					<th>基础报警规则</th>
					<th>监控项</th>
					<th>数据项</th>
					<th>Critical表达式</th>
					<th>Warning表达式</th>
					<th>报警接收人(组)</th>
					<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
					<th>通知</th>
					</#if>
					<th>报警内容</th>
					<th>连续触发次数</th>
					<th>发送间隔</th>
				</tr>
			</thead>
			<tbody>
				<#if alarmRuleList??>
				<#list alarmRuleList as x>
				<tr>
					<td><input type="checkbox" class="j-check" data-id="${x.id!}" <#if x.isOverride?? && x.isOverride>disabled="disabled"</#if>/></td>
					<td data-id="${x.overrideRuleId!}" class="override personal" <#if x.isOverride?? && x.isOverride>style="text-decoration:line-through;"</#if>>
						${x.alarmRuleName!}
						<#if x.overrideRuleId??>
						<span class="u-icon personal"></span>
						</#if>
					</td>
					<td><#if x.clusterId??>否<#else>是</#if></td>
					<td>${x.monitorItemName!}</td>
					<td>${x.dataModelName!}</td>
					<td>${x.criticalExpression!?html}</td>
					<td>${x.warnExpression!?html}</td>
					<td class="f-dat personal">
						<#if (x.specialReceivers?? && x.specialReceivers?size!=0) || (x.specialGroups?? && (x.specialGroups?size>0))>
							<#if x.receiverFlag?? && x.receiverFlag == 1>
							<span class="u-icon personal"></span>
							<span style="padding-left:36px">
							<#else>
							<span>
							</#if>
							<#if (x.specialReceivers?? && x.specialReceivers?size!=0)>
								<#list x.specialReceivers as xx>
									${xx.userName}
									<#if xx_has_next>,</#if>
								</#list>
								<#if (x.specialGroups?? && x.specialGroups?size!=0)>
								&nbsp;|&nbsp;
								<#list x.specialGroups as xx>
									${xx.groupName}
									<#if xx_has_next>,</#if>
								</#list>
								</#if>
							<#else>
								<#if (x.specialGroups?? && x.specialGroups?size!=0)>
								<#list x.specialGroups as xx>
									${xx.groupName}
									<#if xx_has_next>,</#if>
								</#list>
								</#if>
							</#if>
							</span>
						<#else>
							<#if (RequestParameters.clusterId)??>
							<#else>
							使用默认集群报警人
							</#if>
						</#if>
					</td>
					<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
					<td>
						<#if x.disableId?? && x.disableId != 0>
						<i class="u-icon u-icon-close-alarm"></i>
						<#else>
						<i class="u-icon u-icon-open-alarm"></i>
						</#if>
					</td>
					</#if>
					<td title="${x.outputTemplate!?html}">${x.outputTemplate!?html}</td>
					<td>${x.threthold!}</td>
					<td>${x.suppressInterval!}</td>
				</tr>
				</#list>
				</#if>
			</tbody>
		</table>
		<@pagination total=total?default(0) />	
	</div>
</div>
</#macro>

<#macro jstTemplate3>
<div style="display:none" id="jst-template">
<#noparse>
	<textarea name="jst" id="jst-win-form-tip">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="jst" id="jst-win-collector">
		<form id="form-add" class="m-form form">
			<div class="fmitem">
				<label class="fmlab">监控项：</label>
				<div class="fmcnt">
					<select name="monitorItemId" data-action="monitor">
						{list monitorItemList as x}
							<option value="${x.monitorItemId}" {if monitorItemId==x.monitorItemId}selected="selected"{/if}>${x.monitorItemName}</option>
						{/list}
					</select>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">数据项：</label>
				<div class="fmcnt">
					<select name="dataModelId" data-action="dataModel">
						{list monitorItemList as x}
						{if monitorItemId == x.monitorItemId}
						{list x.dataModel as xx}
							<option value="${xx.dataModelId}" {if dataModelId==xx.dataModelId}selected="selected"{/if}>${xx.dataModelName}</option>
						{/list}
						{/if}
						{/list}
					</select>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab"><i>*</i>报警项名称：</label>
				<div class="fmcnt">
					<input type="text" class="u-ipt alarmName" name="name" value="${name}" placeholder="建议直接使用监控项名称" data-required="true" data-message="不能为空"/>
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
						<input type="text" class="u-ipt" name="threthold" value="${threthold|default:3}" data-required="true" data-tip="超过阀值，发送报警" data-message="不能为空"/>
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
			<div class="fmitem m-alarm-person">
				<label class="fmlab"><i>*</i>报警接收人：</label>
				<div class="fmcnt">
					<input type="radio" value="0" name="receiverFlag" checked data-action="alarmPerson"/>默认 - 使用集群报警人
					<input type="radio" value="1" name="receiverFlag" data-action="alarmPerson"/>个性化 
					<div id="self-person">
						<p>报警人:</p>
						<ul class="itms f-cb" id="person-list2">
							{if specialReceivers}
							{list specialReceivers as person}
							<li class="j-cd">
								<input type="text" class="j-flag u-ipt person" value="${person.account}" data-id="${person.userId}" placeholder="请输入邮箱前缀"/>
								<i class="u-icon u-icon-del remove-person" data-action="del"></i>
							</li>
							{/list}
							{else}
							<li class="j-cd">
								<input type="text" class="j-flag u-ipt person" value="" placeholder="请输入邮箱前缀"/>
								<i class="u-icon u-icon-del remove-person" data-action="del"></i>
							</li>
							{/if}
							<a class="u-btn add" id="add-person2" data-action="add2">+</a>
						</ul>
						<p>报警联系人组:</p>
						<ul class="itms f-cb" id="person-list-group2">
							{if specialGroups}
							{list specialGroups as group}
							<li class="j-cd">
								<input type="text" class="j-flag u-ipt person" value="${group.groupName}" data-id="${group.groupId}" placeholder="请输入联系人组"/>
								<i class="u-icon u-icon-del remove-person" data-action="del"></i>
							</li>
							{/list}
							{else}
							<li class="j-cd">
								<input type="text" class="j-flag u-ipt person" value="" placeholder="请输入联系人组"/>
								<i class="u-icon u-icon-del remove-person" data-action="del"></i>
							</li>
							{/if}
							<a class="u-btn add" id="add-group2" data-action="add-group2">+</a>
						</ul>
					</div>
				</div>
			</div>
		</form>
		<div id="alarm-table" class="f-fl table m-alarm-table">
			<div class="alarm-rule">
				<p>报警规则表达式举例：(详细用法请点击<a href="http://doc.hz.netease.com/pages/viewpage.action?pageId=43573142" class="alarm-color">这里</a>)</p> 
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
</#noparse>
<#noparse> 
	<textarea name="jst" id="form-del">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>您确定要删除该报警项?</div>
	</textarea>
	<textarea name="txt" id="txt-add-item">
	    <li class="j-cd">
	    	<input type="text" class="j-flag u-ipt person" value="" placeholder="请输入邮箱前缀"/>
	    	<i class="u-icon u-icon-del" data-action="del"></i>
	    </li>
	</textarea>
	<textarea name="txt" id="txt-add-item1">
	    <li class="j-cd">
	    	<input type="text" class="j-flag u-ipt person" value="" placeholder="请输入联系人组"/>
	    	<i class="u-icon u-icon-del" data-action="del"></i>
	    </li>
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
</div>
</#noparse>
</#macro>
<#macro jstTemplate4>
<div style="display:none" id="jst-template">
<#noparse> 
	<textarea name="jst" id="jst-win-table">
		<table class="m-table" id="table">
			<thead> 
				<tr>
					<th>姓名</th>
					<th>popo</th>
					<th>popo状态</th>
					<th>email</th>
					<th>email状态</th>
					<th>易信</th>
					<th>易信状态</th>
					<th>短信</th>
					<th>短信状态</th>
					<th>语音</th>
					<th>语音状态</th>
				</tr>
			</thead>
			<tbody>
				{list receivers as x}
				<tr>
					 <td>${x.name}</td>
					 <td>
					 	{if x.paopaoNotice}
					 	{if x.paopaoNotice.contentId && x.paopaoNotice.contentId != 0}
					 	<a href="javascript:;" data-id="${x.paopaoNotice.contentId}">${x.paopaoNotice.paopao}</a>
					 	{else}
					 	${x.paopaoNotice.paopao}
					 	{/if}
					 	{/if}
					 </td>
			     	 <td>{if x.paopaoNotice}${x.paopaoNotice.status}{/if}</td>
				     <td>
				     	{if x.emailNotice}
				     	{if x.emailNotice.contentId && x.emailNotice.contentId != 0}
					 	<a href="javascript:;" data-id="${x.emailNotice.contentId}">${x.emailNotice.email}</a>
					 	{else}
				     	${x.emailNotice.email}
					 	{/if}
				     	{/if}
				     </td>	
				     <td>{if x.emailNotice}${x.emailNotice.status}{/if}</td>	
				     <td>
				     	{if x.yixinNotice}
				     	{if x.yixinNotice.contentId && x.yixinNotice.contentId != 0}
					 	<a href="javascript:;" data-id="${x.yixinNotice.contentId}">${x.yixinNotice.yixin}</a>
					 	{else}
				     	${x.yixinNotice.yixin}
					 	{/if}
				     	{/if}
				     </td>
				     <td>{if x.yixinNotice}${x.yixinNotice.status}{/if}</td>
				     <td>
				     	{if x.phoneNotice}
				     	{if x.phoneNotice.contentId && x.phoneNotice.contentId != 0}
					 	<a href="javascript:;" data-id="${x.phoneNotice.contentId}">${x.phoneNotice.phone}</a>
					 	{else}
				     	${x.phoneNotice.phone}
					 	{/if}
				     	{/if}
				     </td>
				     <td>{if x.phoneNotice}${x.phoneNotice.status}{/if}</td>
				     <td>
				     	{if x.phoneVoiceNotice}
				     	{if x.phoneVoiceNotice.contentId && x.phoneVoiceNotice.contentId != 0}
					 	<a href="javascript:;" data-id="${x.phoneVoiceNotice.contentId}">${x.phoneVoiceNotice.phone}</a>
					 	{else}
				     	${x.phoneVoiceNotice.phone}
					 	{/if}
				     	{/if}
				     </td>
				     <td>{if x.phoneVoiceNotice}${x.phoneVoiceNotice.status}{/if}</td>
				 </tr>
				{/list}
			</tbody>
		</table>
	</textarea>
	<textarea name="jst" id="jst-win-email">
	<div class="m-table m-table-email" style="line-height:25px">
		${body}
	</div>
	</textarea>
</div>
</#noparse>
</#macro>
<#macro alarmHistory class="">	
<div class="g-cnt ${class}">
	<form id="form">
		<div class="m-form2 m-alarm-form">
			<div class="fmitem">
				<label class="fmlab">报警类型：</label>
				<div class="fmcnt">
					<select class="u-ipt" name="alarmType" id="alarm-type">
						<option value="">全部</option>
						<option value="0" <#if RequestParameters.alarmType?? && RequestParameters.alarmType=='0'>selected="selected"</#if>>单机</option>
						<option value="1" <#if RequestParameters.alarmType?? && RequestParameters.alarmType=='1'>selected="selected"</#if>>集群</option>
						<option value="3" <#if RequestParameters.alarmType?? && RequestParameters.alarmType=='3'>selected="selected"</#if>>VIP</option>
					</select>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">发送状态：</label>
				<div class="fmcnt">
					<select class="u-ipt" name="sendStatus">
						<option value="" <#if RequestParameters.sendStatus??><#else>selected="selected"</#if>>全部</option>
						<option value="send" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='send'>selected="selected"</#if>>发送成功</option>
						<option value="failed" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='failed'>selected="selected"</#if>>发送失败</option>
						<option value="part_failed" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='part_failed'>selected="selected"</#if>>部分发送失败</option>
						<option value="threshold_suppress" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='threshold_suppress'>selected="selected"</#if>>次数抑制</option>
						<option value="interval_suppress" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='interval_suppress'>selected="selected"</#if>>时间抑制</option>
						<option value="rule_close" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='rule_close'>selected="selected"</#if>>报警关闭</option>‘
						<option value="send_method_close" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='send_method_close'>selected="selected"</#if>>发送方式未配</option>‘
						<option value="no_rule_match" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='no_rule_match'>selected="selected"</#if>>模板不匹配</option>
					</select>
				</div>
			</div>
			<div class="fmitem server-single">
				<label class="fmlab">主机/VIP</label>
				<div class="fmcnt">
					<select class="u-ipt" name="serverId">
					    <option value="">全部</option>
						<#if servers??>
							<#list servers as server>
							 <option value="${server.id}" class="base" <#if RequestParameters.serverId?? && RequestParameters.serverId == '${server.id}'>selected="selected"</#if>><#if server.hostAlias?? && server.hostAlias != ''>${server.hostAlias}<#else>${server.hostName}</#if></option>
					        </#list>
				        </#if>
				        <#if vips??>
							<#list vips as vip>
							 <option value="${vip.id}" class="vip" <#if RequestParameters.vipId?? && RequestParameters.vipId == '${vip.id}'>selected="selected"</#if>>${vip.vipName}</option>
					        </#list>
				        </#if>
					</select>
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">监控项：</label>
				<div class="fmcnt">
				<select class="u-ipt" name="monitorItemId">
					    <option value="">全部</option>
						<#if monitorItems??>
							<#list monitorItems as config>
							<option value="${config.id}" class="base" <#if RequestParameters.monitorItemId?? && RequestParameters.monitorItemId == '${config.id}' >selected="selected"</#if>>${config.name}</option>
					        </#list>
				        </#if>
				        <#if monitorItemVips??>
							<#list monitorItemVips as config>
							<option value="${config.id}" class="vip" <#if RequestParameters.monitorItemId?? && RequestParameters.monitorItemId == '${config.id}' >selected="selected"</#if>>${config.name}</option>
					        </#list>
				        </#if>
				</select>
				</div>
			</div>
			<div class="u-iptsearch u-iptsearch-3">
				<input type="text" class="u-ipt u-ipt-s5" value="${searchword!}" name="searchword" onKeyPress="if (event.which == 13) return false;" placeholder="搜索内容">
				<span class="u-btn u-btn-s1 j-search">搜索</span>
			</div>
			<div class="fmitem">
				<div class="fmcnt">
					<label class="fmlab">时间范围：</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=1h&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}<#if RequestParameters.alarmType??>&alarmType=${RequestParameters.alarmType!}</#if><#if RequestParameters.serverId??>&serverId=${RequestParameters.serverId!}</#if><#if RequestParameters.monitorItemId??>&monitorItemId=${RequestParameters.monitorItemId!}</#if>" <#if RequestParameters.rangeType?default('1h')?string == '1h'>class="act"</#if>>1小时</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=3h&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}<#if RequestParameters.alarmType??>&alarmType=${RequestParameters.alarmType!}</#if><#if RequestParameters.serverId??>&serverId=${RequestParameters.serverId!}</#if><#if RequestParameters.monitorItemId??>&monitorItemId=${RequestParameters.monitorItemId!}</#if>" <#if RequestParameters.rangeType?default('1h')?string == '3h'>class="act"</#if>>3小时</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=6h&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}<#if RequestParameters.alarmType??>&alarmType=${RequestParameters.alarmType!}</#if><#if RequestParameters.serverId??>&serverId=${RequestParameters.serverId!}</#if><#if RequestParameters.monitorItemId??>&monitorItemId=${RequestParameters.monitorItemId!}</#if>" <#if RequestParameters.rangeType?default('1h')?string == '6h'>class="act"</#if>>6小时</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=12h&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}<#if RequestParameters.alarmType??>&alarmType=${RequestParameters.alarmType!}</#if><#if RequestParameters.serverId??>&serverId=${RequestParameters.serverId!}</#if><#if RequestParameters.monitorItemId??>&monitorItemId=${RequestParameters.monitorItemId!}</#if>" <#if RequestParameters.rangeType?default('1h')?string == '12h'>class="act"</#if>>12小时</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=1d&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}<#if RequestParameters.alarmType??>&alarmType=${RequestParameters.alarmType!}</#if><#if RequestParameters.serverId??>&serverId=${RequestParameters.serverId!}</#if><#if RequestParameters.monitorItemId??>&monitorItemId=${RequestParameters.monitorItemId!}</#if>" <#if RequestParameters.rangeType?default('1h')?string == '1d'>class="act"</#if>>1天</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=2d&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}<#if RequestParameters.alarmType??>&alarmType=${RequestParameters.alarmType!}</#if><#if RequestParameters.serverId??>&serverId=${RequestParameters.serverId!}</#if><#if RequestParameters.monitorItemId??>&monitorItemId=${RequestParameters.monitorItemId!}</#if>" <#if RequestParameters.rangeType?default('1h')?string == '2d'>class="act"</#if>>2天</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=3d&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}<#if RequestParameters.alarmType??>&alarmType=${RequestParameters.alarmType!}</#if><#if RequestParameters.serverId??>&serverId=${RequestParameters.serverId!}</#if><#if RequestParameters.monitorItemId??>&monitorItemId=${RequestParameters.monitorItemId!}</#if>" <#if RequestParameters.rangeType?default('1h')?string == '3d'>class="act"</#if>>3天</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=1w&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}<#if RequestParameters.alarmType??>&alarmType=${RequestParameters.alarmType!}</#if><#if RequestParameters.serverId??>&serverId=${RequestParameters.serverId!}</#if><#if RequestParameters.monitorItemId??>&monitorItemId=${RequestParameters.monitorItemId!}</#if>" <#if RequestParameters.rangeType?default('1h')?string == '1w'>class="act"</#if>>1周</a>
					</label>
					<label class="u-seltag j-custom">
						<a href="javascript:void(0)" <#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>class="act"</#if>>自定义</a>
					</label>
					<label class="custom <#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>act-1</#if>">
						<#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>
							<input type="text" value="<#if RequestParameters.startTime??>${RequestParameters.startTime}</#if>" name="startTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
							~
							<input type="text" value="<#if RequestParameters.endTime??>${RequestParameters.endTime}</#if>" name="endTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
							<span class="u-btn u-btn-s7 j-interval">提交</span>
						<#else>
							<input type="text" value="" name="startTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
							~
							<input type="text" value="" name="endTime" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
							<span class="u-btn u-btn-s7 j-interval">提交</span>
						</#if>
					</label>
				</div>

			</div>
		</div>
	</form>
	<table class="m-table m-table-1" id="table-list">
		<thead>
			<tr>
				<th>通知类型</th>
				<th>主机/VIP</th>
				<th>监控域</th>
				<th>监控项</th>
				<th>数据项</th>
				<th>规则</th>
				<th class="cnt">通知内容</th>
				<th>发送对象</th>
				<th>状态</th>
				<th>发送状态</th>
				<th>报警通知时间</th>
			</tr>
		</thead>
		<tbody>
			<#if alarmHistoryList??>
			<#list alarmHistoryList as x>
			<tr data-id="${x.id!}">
				<#assign alarmType = ['单机','集群','域','VIP'] />
				<td>
					<#if x.alarmType??>
					${alarmType[x.alarmType!]}
					<#else>
					单机
					</#if>
				</td>
				<td title="${x.serverName!}">${x.serverName!}</td>
				<td title="${x.domainName!}">${x.domainName!}</td>
				<td title="${x.monitorItemName!}">${x.monitorItemName!}</td>
				<td title="${x.dataModelName!}">${x.dataModelName!}</td>
				<td title="${x.ruleExpress!}">${x.ruleExpress!}</td>
				<td class="f-dat" title="${x.alarmContent!}"><div style="">${x.alarmContent!}</div></td>
				<td data-action="person" data-id="${x.id!}" style="cursor:pointer;color:#0095d9;">${x.receiversNames!}</a></td>
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
				<#assign sendstatus = {"send":"发送成功","failed":"发送失败","part_failed":"发送失败（部分失败）","threshold_suppress":"发送失败（次数抑制）","interval_suppress":"发送失败（时间抑制）","rule_close":"发送失败（报警关闭）","no_rule_match":"发送失败（模板不匹配）","send_method_close":"发送失败（发送方式未匹配）"} />
				<#if x.sendStatus??>
				<td class="j-cb" title="${sendstatus[x.sendStatus!]!}">${sendstatus[x.sendStatus!]!}</td>
				<#else>
				<td class="j-cb"></td>
				</#if>
				<td title="${x.alarmTime?datetime}">${x.alarmTime?datetime}</td>
			</tr>
			</#list>
			</#if>
		</tbody>
	</table>
	<@pagination total=total?default(0) />
</div>
</#macro>
</#escape>