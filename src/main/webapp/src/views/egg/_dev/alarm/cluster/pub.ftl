<#escape x as x!""?html>
<#macro monitorAlert class="">
<div class="g-cnt ${class}">
	<div id="form" class="form">
	    <div class="m-tab">
		    <ul id="tab">
		    	<#if RequestParameters.clusterId??>
		        <li><a href="/sentry/monitor/list?clusterId=${RequestParameters.clusterId}">监控项</a></li>
		        <li><a href="/sentry/alarm?clusterId=${RequestParameters.clusterId}">单机报警</a></li>
		        <li class="z-act"><a href="javascript:void(0);">集群报警</a></li>
		        <li><a href="/sentry/monitor/vip/list?clusterId=${RequestParameters.clusterId}">VIP监控项</a></li>
		        <li><a href="/sentry/alarm/vip?clusterId=${RequestParameters.clusterId}">VIP报警</a></li>
		        <#else>
		        <li><a href="/sentry/monitor/list?clusterId=0">监控项</a></li>
		        <li><a href="/sentry/alarm?clusterId=0">单机报警</a></li>
		        <li><a href="/sentry/monitor/vip/list?clusterId=0">VIP监控项</a></li>
		        <li><a href="/sentry/alarm/vip?clusterId=0">VIP报警</a></li>
		        </#if>
		    </ul>
	     </div>
		<div class="m-bar">
			<ul class="u-btns">
				<li class="j-add u-btn" id="btn-add">创建集群报警</li>
				<li class="j-mod u-btn u-btn-c1" id="btn-edit">修改集群报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-del">删除集群报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-close">关闭报警</li>
				<li class="j-del u-btn u-btn-c1" id="btn-open">打开报警</li>
			</ul>
		</div>
		<table class="m-table m-table-2" id="table" data-id="<#if (RequestParameters.clusterId)??>${RequestParameters.clusterId}</#if>">
			<thead>
				<tr>
					<th class="checkbox"><input type="checkbox" class="j-sel"></th>
					<th>报警项名称</th>
					<th>报警类型</th>
					<th>监控项</th>
					<th>数据项</th>
					<th>Critical表达式</th>
					<th>Warning表达式</th>
					<th>报警接收人(组)</th>
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
					<td><input type="checkbox" class="j-check" data-id="${x.id!}"></td>
					<td data-id="${x.overrideRuleId!}" class="override personal">${x.alarmRuleName!}
						<#if x.overrideRuleId??>
						<span class="u-icon personal"></span>
						</#if>
					</td>
					<td>
					<#if x.accType??><#if x.accType=='accumulate'>累计值<#else>当前值</#if></#if>
					</td>
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
				<label class="fmlab">报警类型：</label>
				<div class="fmcnt">
					<select name="accType" data-action="type">
						<option value="current">当前值</option>
					</select>
					<span class="type-area hide">与前 <input type="text" class="u-ipt u-small" value="${accIntervalTime|default:30}" name="accIntervalTime" data-required="true" data-message="不能为空">分钟比</span>
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
						<input type="text" class="u-ipt" name="threshold" value="${threshold|default:3}" data-required="true" data-tip="超过阀值，发送报警" data-message="不能为空"/>
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
				<p>集群报警表达式说明：</p> 
				<p>集群报警的每个指标项都有如下属性值：</p>
				<div class="rule-content">
				<p>Int/Float/Double类型指标项:</p>
				<p class="rule-content">
				<span class="alarm-color">min：</span>当前集群该指标项的最小值<br>  
				<span class="alarm-color">max：</span>当前集群该指标项最大值<br>  
				<span class="alarm-color">sum：</span>当前集群该指标项的累计值<br> 
				<span class="alarm-color">avg：</span>当前集群该指标项的算术平均值<br>   
				<span class="alarm-color">count：</span>当前集群该笔数据由多少笔原始数据组成<br>   
				<span class="alarm-color">last：</span>集群当次采集中该指标项的最后一笔数值<br>   
				</p>
				<p>String类型指标项：</p>
				<p class="rule-content">
				<span class="alarm-color">count：</span>当前集群该笔数据由多少笔原始数据组成<br>  
				<span class="alarm-color">last：</span>集群当次采集中该指标项的最后一笔数值<br>  
				</p>
				</div>
				<p>表达式举例：</p>
				<p class="rule-content">指标项为：<span class="alarm-color">total_order</span>，类型为INT，含义：总下单量<br>
				集群总下单量小于100：<span class="alarm-color">total_order.sum&lt;100</span><br>
				集群单机最大下单量超过10：<span class="alarm-color">total_order.max&gt;10</span></p>
			</div>
			<div id="alarm-items" class="alarm-items" style="height:92px;"></div>
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
<#macro alarmHistory class="">	
<div class="g-cnt ${class}">
	<form id="form">
		<div class="m-form2 m-form2-1 m-alarm-form">
			<div class="fmitem">
				<div class="fmcnt">
					<label class="fmlab">发送状态：</label>
					<select class="u-ipt" name="sendStatus">
						<option value="" <#if RequestParameters.sendStatus??><#else>selected="selected"</#if>>所有</option>
						<option value="send" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='send'>selected="selected"</#if>>发送成功</option>
						<option value="failed" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='failed'>selected="selected"</#if>>发送失败</option>
						<option value="part_failed" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='part_failed'>selected="selected"</#if>>部分发送失败</option>
						<option value="threshold_suppress" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='threshold_suppress'>selected="selected"</#if>>次数抑制</option>
						<option value="interval_suppress" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='interval_suppress'>selected="selected"</#if>>时间抑制</option>
						<option value="rule_close" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='rule_close'>selected="selected"</#if>>报警关闭</option>‘
						<option value="no_rule_match" <#if RequestParameters.sendStatus?? && RequestParameters.sendStatus=='no_rule_match'>selected="selected"</#if>>模板不匹配</option>
					</select>
				</div>
			</div>
			<div class="u-iptsearch u-iptsearch-3">
				<input type="text" class="u-ipt u-ipt-s5" value="${searchword!}" name="searchword" onKeyPress="if (event.which == 13) return false;" placeholder="搜索内容">
				<#-- <input type="submit" class="u-btn u-btn-s1 j-search" value="搜索"/> -->
				<span class="u-btn u-btn-s1 j-search">搜索</span>
			</div>
			<div class="fmitem">
				<div class="fmcnt">
					<label class="fmlab">时间范围：</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=1h&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}" <#if RequestParameters.rangeType?default('1h')?string == '1h'>class="act"</#if>>1小时</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=3h&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}" <#if RequestParameters.rangeType?default('1h')?string == '3h'>class="act"</#if>>3小时</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=6h&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}" <#if RequestParameters.rangeType?default('1h')?string == '6h'>class="act"</#if>>6小时</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=12h&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}" <#if RequestParameters.rangeType?default('1h')?string == '12h'>class="act"</#if>>12小时</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=1d&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}" <#if RequestParameters.rangeType?default('1h')?string == '1d'>class="act"</#if>>1天</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=2d&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}" <#if RequestParameters.rangeType?default('1h')?string == '2d'>class="act"</#if>>2天</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=3d&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}" <#if RequestParameters.rangeType?default('1h')?string == '3d'>class="act"</#if>>3天</a>
					</label>
					<label class="u-seltag">
						<a href="history?clusterId=${RequestParameters.clusterId!}&rangeType=1w&searchword=${RequestParameters.searchword!}&sendStatus=${RequestParameters.sendStatus!}" <#if RequestParameters.rangeType?default('1h')?string == '1w'>class="act"</#if>>1周</a>
					</label>
					<label class="u-seltag j-custom">
						<a href="javascript:void(0)" <#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>class="act"</#if>>自定义</a>
					</label>
					<label class="custom <#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>act-1</#if>">
					
						<input type="text" name="startTime" value="<#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>${(condition.startTime)?string('yyyy-MM-dd HH:mm:ss')}</#if>" placeholder="yyyy-mm-dd hh:mm:ss"> - <input type="text" name="endTime" placeholder="yyyy-mm-dd hh:mm:ss" value="<#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>${(condition.endTime)?string('yyyy-MM-dd HH:mm:ss')}</#if>"/><span class="u-btn u-btn-s7 j-interval">提交</span>
					
					</label>
				</div>

			</div>
		</div>
	</form>
	<table class="m-table m-table-1" id="table-list">
		<thead>
			<tr>
				<th class="cnt">通知内容</th>
				<th>发送方式</th>
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
				<td class="f-dat">${x.alarmContent!}</td>
				<td class="f-cb">
					<#if x.sendMethod ??>
						<#if x.sendMethod?contains('popo')>
						<span class="u-tag u-icon popo"></span>
						<#else>
						<span class="u-tag u-icon un-popo"></span>
						</#if>
						<#if x.sendMethod?contains('yixin')>
						<span class="u-tag u-icon yixin"></span>
						<#else>
						<span class="u-tag u-icon un-yixin"></span>
						</#if>
						<#if x.sendMethod?contains('email')>
						<span class="u-tag u-icon email"></span>
						<#else>
						<span class="u-tag u-icon un-email"></span>
						</#if>
						<#if x.sendMethod?contains('sms')>
						<span class="u-tag u-icon sms"></span>
						<#else>
						<span class="u-tag u-icon un-sms"></span>
						</#if>
						<#if x.sendMethod?contains('phone')>
						<span class="u-tag u-icon phone"></span>
						<#else>
						<span class="u-tag u-icon un-phone"></span>
						</#if>
					<#else>
						<span class="u-tag u-icon popo"></span>
						<span class="u-tag u-icon yixin"></span>
						<span class="u-tag u-icon email"></span>
						<span class="u-tag u-icon sms"></span>
						<span class="u-tag u-icon phone"></span>
					</#if>
				</td>
				<td class="f-dat">${x.receiversNames!}</td>
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
				<#assign sendstatus = {"send":"发送成功","failed":"发送失败","part_failed":"部分发送失败","threshold_suppress":"次数抑制","interval_suppress":"时间抑制","rule_close":"报警关闭","no_rule_match":"模板不匹配"} />
				<#if x.sendStatus??>
				<td class="j-cb">${sendstatus[x.sendStatus!]!}</td>
				<#else>
				<td class="j-cb"></td>
				</#if>
				<td>${x.alarmTime?datetime}</td>
			</tr>
			</#list>
			</#if>
		</tbody>
	</table>
	<@pagination total=total?default(0) />
</div>
</#macro>
</#escape>