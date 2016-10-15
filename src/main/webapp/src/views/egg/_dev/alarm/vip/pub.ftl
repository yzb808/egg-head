<#escape x as x!""?html>
<#macro monitorAlert class="">
<div class="g-cnt ${class}">
	<div id="form" class="form">
	    <div class="m-tab">
		    <ul id="tab">
		    	<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>  <#-- 集群 -->
		        <li><a href="/sentry/monitor/list?clusterId=${RequestParameters.clusterId}">监控项</a></li>
		        <li><a href="/sentry/alarm?clusterId=${RequestParameters.clusterId}">单机报警</a></li>
		        <li><a href="/sentry/alarm/cluster?clusterId=${RequestParameters.clusterId}">集群报警</a></li>
		        <li><a href="/sentry/monitor/vip/list?clusterId=${RequestParameters.clusterId}">VIP监控项</a></li>
		        <li class="z-act"><a href="javascript:void(0);">VIP报警</a></li>
		        <#else> <#-- 基础 -->
		        <li><a href="/sentry/monitor/list?clusterId=0">监控项</a></li>
		        <li><a href="/sentry/alarm">单机报警</a></li>
		        <li><a href="/sentry/monitor/vip/list?clusterId=0">VIP监控项</a></li>
		        <li class="z-act"><a href="javascript:void(0);">VIP报警</a></li>
		        </#if>
		    </ul>
	    </div>
		<div class="m-bar">
			<ul class="u-btns">
				<li class="j-add u-btn" id="btn-add">创建VIP报警</li>
				<li class="j-mod u-btn u-btn-c1" id="btn-edit">修改VIP报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-del">删除VIP报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-close">关闭报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-open">打开报警</li>
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
					<th>报警接收人</th>
					<th>通知</th>
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
					<td>
						<#if x.disableId?? && x.disableId != 0>
						<i class="u-icon u-icon-close-alarm"></i>
						<#else>
						<i class="u-icon u-icon-open-alarm"></i>
						</#if>
					</td>
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
</#escape>