<#escape x as x!""?html>
<#macro monitorList class="" type="">
<div class="g-cnt ${class}">
    <div class="m-tab">
	    <ul id="tab">
	        <li class="z-act"><a href="javascript:void(0);">监控项</a></li>
	        <#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
	        <li><a href="/sentry/alarm?clusterId=${RequestParameters.clusterId}">单机报警</a></li>
	        <li><a href="/sentry/alarm/cluster?clusterId=${RequestParameters.clusterId}">集群报警</a></li>
	        <li><a href="/sentry/monitor/vip/list?clusterId=${RequestParameters.clusterId}">VIP监控项</a></li>
	        <li><a href="/sentry/alarm/vip?clusterId=${RequestParameters.clusterId}">VIP报警</a></li>
	        <#else>
	        <li><a href="/sentry/alarm">单机报警</a></li>
	        <li><a href="/sentry/monitor/vip/list?clusterId=0">VIP监控项</a></li>
	        <li><a href="/sentry/alarm/vip">VIP报警</a></li>
	        </#if>
	    </ul>
     </div>
	<div class="m-bar">
		<div class="u-btns">
			<#if type=="1">
			<a href="/sentry/monitor/add" class="u-btn">添加监控项</a>
			<a href="javascript:;" data-href="/sentry/monitor/mod" class="u-btn u-btn-c1" id="btn-edit">修改监控项</a>
			<span class="u-btn u-btn-c1" id="btn-del">删除监控项</span>
			<#else>
			<a href="javascript:;" data-href="/sentry/monitor/add?clusterId=${RequestParameters.clusterId}" class="u-btn" id="btn-add">添加监控项</a>
			<a href="javascript:;" data-href="/sentry/monitor/mod" class="u-btn u-btn-c1" id="btn-edit">修改监控项</a>
			<span class="u-btn u-btn-c1" id="btn-del">删除监控项</span>
			<span class="u-btn u-btn-c1" id="btn-copy">复制监控项</span>
			<span class="u-btn u-btn-c1" id="btn-view">个性化视图</span>
			</#if>
		</div>
	</div>
	<table class="m-table m-table-1" id="table" data-id="<#if (RequestParameters.clusterId)??>${RequestParameters.clusterId}</#if>">
		<thead>
			<tr>
				<th class="checkbox"><input type="checkbox" id="select-all"></th>
				<th>监控项名称</th>
				<th>基础监控</th>
				<th>采集间隔(秒)</th>
				<th>服务器列表</th>
				<#if RequestParameters.clusterId?? && (RequestParameters.clusterId) != '0'>
				<th>视图权限</th>
				</#if>
				<th>创建人</th>
				<th>最后操作时间</th>
			</tr>
		</thead>
		<tbody>
			<#if monitorItemList??>
			<#list monitorItemList as x>
			<tr>
				<td><input type="checkbox" class="j-check" data-id="${x.id!}" data-type="${x.type?number}"></td>
				<td><a href="javascript:void(0)" data-action="show" data-id="${x.id!}" title="查看详情">${x.name!}</a></td>
				<#if x.type?number == 1>
				<td>是</td>
				<#else>
				<td>否</td>
				</#if>
				<td>${x.interval!}</td>
				<td>
					<#if x.type?? && x.type == 0>
						<#if x.hostFlag??>
							<#if x.hostFlag == 0>
							集群全部
							<#elseif x.hostFlag == 1>
							集群指定
							<#elseif x.hostFlag == 2>
							集群排除
							</#if>
						<#else>
						集群全部
						</#if>
					<#else>
					全部
					</#if>
				</td>
				<#if RequestParameters.clusterId?? && (RequestParameters.clusterId) != '0'>
				<td>
					<#assign visableType=['公开','指定人员']/>
					<#if x.visable??>
					${visableType[x.visable]}
					</#if>
				</td>
				</#if>
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
	<textarea name="jst" id="form-copy">
		<div class="m-form">
			<div class="fmitem">
				<label class="fmlab f-tal">新的监控项名称：</label>
			</div>
			<table class="m-table" id="monitor-table">
				<thead> 
					<tr>
						<th>原监控项名称</th>
						<th>复制后监控项名称</th>
					</tr>
				</thead>
				<tbody>
					{list monitorList as x}
						<tr>
							<td>${x.name}</td>
							<td><input type="text" value="${x.name}" class="monitor-name" data-id="${x.id}"/></td>	
						</tr>
					{/list}
				</tbody>
			</table>
			<div class="fmitem">
				<label class="fmlab f-tal">请选择所复制的目标集群：</label>
				
			</div>
			<div class="u-iptsearch u-iptsearch-3">
				<input type="text" class="u-ipt u-ipt-s2" value="${searchword}" name="searchword" placeholder="搜索内容" id="search-ipt">
				<span class="u-btn u-btn-s1 j-search" id="search-btn" data-action="search">搜索</span>
			</div>
			<div id="cluster-list">
				<table class="m-table" id="cluster-table">
					<thead> 
						<tr>
							<th class="checkbox"><input type="checkbox" id="j-all"></th>
							<th>集群名称</th>
							<th>所属应用</th>
							<th>所属产品</th>
						</tr>
					</thead>
					<tbody>
						{list clusterList as x}
							<tr>
								<td><input type="checkbox" class="j-check" data-id="${x.clusterId}"></td>
								<td>${x.clusterName}</td>
								<td>${x.app}</td>
								<td>${x.product}</td>	
							</tr>
						{/list}
					</tbody>
				</table>
			</div>
			<div class="search-page"><input type="text" class="u-ipt" id="pagesize"><span class="u-btn u-btn-s1 j-confirm" id="confirm-btn" data-action="confirm">确定</span></div>
			<div class="win-pagination j-page" id="win-pagination"></div>
		</div>
	</textarea>
	<textarea name="jst" id="form-cluster">
		<div class="m-form">
			<table class="m-table" id="cluster-table">
				<thead> 
					<tr>
						<th class="checkbox"><input type="checkbox" id="j-all"></th>
						<th>集群名称</th>
						<th>所属应用</th>
						<th>所属产品</th>
					</tr>
				</thead>
				<tbody>
					{list clusterList as x}
						<tr>
							<td><input type="checkbox" class="j-check" data-id="${x.clusterId}"></td>
							<td>${x.clusterName}</td>
							<td>${x.app}</td>
							<td>${x.product}</td>	
						</tr>
					{/list}
				</tbody>
			</table>
		</div>
	</textarea>
	<textarea name="jst" id="jst-win-form-alert">
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
					全天
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
				<label class="fmlab">是否支持多实例：</label>
				<div class="fmcnt">
					{if multiInstance ==  true}
					是
					{else}
					否
					{/if}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">执行账号：</label>
				<div class="fmcnt">
					${execAccount}
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">报警项名称：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">critical表达式：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">warning表达式：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">告警输出：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">通知时间段：</label>
				<div class="fmcnt">
					全天
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">触发场景：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">恢复时通知：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">触发阀值：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">发送间隔：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">报警通知方式：</label>
				<div class="fmcnt">
					
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab">通知报警人：</label>
				<div class="fmcnt">
					
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
<#assign collectorType=monitorItem.collectorType>
<#assign collectorInterval=monitorItem.collectorInterval>
<#assign multiInstance=monitorItem.multiInstance>
<#assign collectorRange=monitorItem.collectorRange>
<#assign hostFlag=monitorItem.hostFlag>
<#assign serverList=monitorItem.serverList>
<#assign predictFlag=monitorItem.predictFlag>
<#if monitorItem.visiableType??>
<#assign visiableType=monitorItem.visiableType>
<#else>
<#assign visiableType=0>
</#if>
<#if monitorItem.users??>
<#assign users=monitorItem.users>
<#else>
<#assign users=[]>
</#if>
<#if collectorType == 'system'>
<#assign scriptName=monitorItem.scriptName>
<#assign arguments=monitorItem.arguments>
<#assign timeout=monitorItem.timeout>
<#assign execAccount=monitorItem.execAccount>
</#if>
</#if>
<div class="g-cnt ${class}">
	<#if collectorType??>
		<input type="hidden" value="${collectorType}" id="collectorType"/>
	</#if>
	<form id="form" class="form monitor-form">
		<div class="m-form">
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
			<div class="fmitem">
				<label class="fmlab">&#12288;<i>*</i>监控项名称：</label>
				<div class="fmcnt">
					<input type="text" name="name" class="u-ipt" data-required="true" data-message="不能为空" value="${name!}" id="input-monitorName">
				</div>
			</div>
			<div class="fmitem">
				<label class="fmlab"><i>*</i>服务器列表：</label>
				<div class="fmcnt">
					<div class="u-radios" id="server-list">
						<label>
							<input type="radio" name="hostFlag" value="0" <#if hostFlag?? && hostFlag == 0>checked="checked"<#else>checked="checked"</#if>>
							全部服务器
						</label>
						<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
						<#if RequestParameters.monitorItemId??>
						<#if monitorItem.clusterId??>
						<label>
							<input type="radio" name="hostFlag" value="1" <#if hostFlag?? && hostFlag == 1>checked="checked"</#if>>
							指定服务器
						</label>
						<label>
							<input type="radio" name="hostFlag" value="2" <#if hostFlag?? && hostFlag == 2>checked="checked"</#if>>
							排除服务器
						</label>
						</#if>
						<#else>
						<label>
							<input type="radio" name="hostFlag" value="1" <#if hostFlag?? && hostFlag == 1>checked="checked"</#if>>
							指定服务器
						</label>
						<label>
							<input type="radio" name="hostFlag" value="2" <#if hostFlag?? && hostFlag == 2>checked="checked"</#if>>
							排除服务器
						</label>
						</#if>
						</#if>
					</div>
					<div id="server-box" class="server-box f-cb hide">
						<div class="server-l f-fl">
							<label>服务器列表</label>
							<div class="list">
								<div class="u-iptsearch u-iptsearch-1">
									<input type="text" class="u-ipt" id="search-server" placeholder="请输入服务器名称" autocomplete="off">
								</div>
								<div id="all-list" class="all-list"></div>
							</div>
						</div>
						<div class="server-r f-fl">
							<label>已选服务器</label>
							<div class="list">
								<div class="select-list">
									<ul id="select-list">
										<#if serverList??>
										<#list serverList as x>
										<li class="j-li" data-id="${x.serverId!}"><#if x.aliasName??>${x.aliasName}-${x.hostName!}<#else>${x.hostName}</#if><i class="u-icon u-icon-del" data-action="del"></i></li>
										</#list>
										</#if>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
			<div class="fmitem">
				<label class="fmlab">监控项标签：</label>
				<div class="fmcnt">
					<div class="">
						<label><input type="checkbox" name="tagList" class="f-vam" value="1" class="j-check"  <#if monitorItem?? && monitorItem.tagList?? && monitorItem.tagList?seq_contains(1) >checked="checked"</#if> />业务指标</label>
						<label><input type="checkbox" name="tagList" class="f-vam" value="2" class="j-check"  <#if monitorItem?? && monitorItem.tagList?? && monitorItem.tagList?seq_contains(2) >checked="checked"</#if> />应用监控</label>
					</div>
				</div>
			</div>
			<div class="fmitem f-cb" id="viewAuthWrap">
				<span class="fmlab"><i>*</i>视图权限：</span>
				<div class="fmcnt">
					<input type="radio" class="f-vam" name="visiableType" value="0" data-action="server" <#if visiableType?? && visiableType == 0>checked="checked"<#else>checked="checked"</#if>/>公开
					<input type="radio" class="f-vam" name="visiableType" value="1" data-action="server" <#if visiableType?? && visiableType == 1>checked="checked"</#if> style="margin-left:20px"/>指定人员
				</div>
			</div>
			<div class="fmitem f-cb m-alarm-person" id="viewAuth" style="display:none;">
				<span class="fmlab">视图查看人员：</span>
				<div class="fmcnt">
					<div class="resp">
						<div class="sub f-cb">
							<ul class="f-fl itms f-cb person-list" id="person-list">
								<#if users??>
								<#list users as person>
								<li class="j-cd"><input type="text" name="" class="u-ipt person" value="${person.account}" placeholder="请输入邮箱前缀" data-id="${person.id}" /><i class="u-icon u-icon-del remove-person" data-action="del"></i></li>
								</#list>
								<#else>
								<li class="j-cd"><input type="text" name="" class="u-ipt person" value="" placeholder="请输入邮箱前缀"/><i class="u-icon u-icon-del remove-person" data-action="del"></i></li>
								</#if>
								<a class="u-btn add" id="add-person" data-action="add">+</a>
							</ul>
						</div>
					</div>
				</div>
			</div>
			</#if>
			<div class="fmitem">
				<label class="fmlab">说明和处理：</label>
				<div class="fmcnt"><textarea class="u-ipt u-txtarea-1" name="descp">${descp!}</textarea></div>
			</div>
		</div>
		<div id="form-add"></div>
		<div id="form2" <#if monitorItem??>style="display:block"<#else>style="display:none"</#if>>
			<div class="m-form">
			<#if collectorType??>
				<#if collectorType == 'system'>
					<div class="fmitem j-collectoritem">
						<label class="fmlab">脚本名称：</label>
						<div class="fmcnt">${scriptName!}</div>
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
							<select name="collectorRange" class="">
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
					<#if (RequestParameters.clusterId??) && (RequestParameters.clusterId?number != 0)>
					<#if RequestParameters.monitorItemId??>
					<#if monitorItem.clusterId??>
					<div class="fmitem j-collectoritem">
						<label class="fmlab"><i>*</i>是否需要趋势预测：</label>
						<div class="fmcnt">
							<div class="u-radios" id="pre">
								<input type="radio" value="1" name="predictFlag" data-action="pre" <#if predictFlag?? && predictFlag == 1>checked="checked"</#if>/>是
								<input type="radio" value="0" name="predictFlag" data-action="pre" class="u-iptw" <#if predictFlag??><#if predictFlag == 0>checked="checked"</#if><#else>checked="checked"</#if>/>否
							</div>
							<div class="pre-box hide" id="pre-box">
								<table class="m-table" id="pre-table">
									<thead> 
										<tr>
											<th>数据项名称</th>
											<th>指标项名称</th>
											<th>指标项数据类型</th>
											<th>预测算法</th>
										</tr>
									</thead>
									<tbody>
										<#if monitorItem.predictConfig??>
										<#list monitorItem.predictConfig as x>
											<#if (x.fieldList?size > 0)>
												<tr>
													<td rowspan="${x.fieldList?size}">${x.dataModelName}</td>
													<td>${x.fieldList[0].fieldName}</td>
													<td>${x.fieldList[0].dataType}</td>
													<td class="u-radios">
														<#if x.fieldList[0].algorithm??>
															<#assign algorithm=x.fieldList[0].algorithm?join(',')/>
															<input type="checkbox" value="yesterday" class="j-ch" <#if algorithm?? && algorithm?contains("yesterday")>checked="checked"</#if>/>昨天同期值
															<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch" <#if algorithm?? && algorithm?contains("sevenDaysAvg")>checked="checked"</#if>/>近7天平均
														<#else>
															<input type="checkbox" value="yesterday" class="j-ch"/>昨天同期值
															<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch"/>近7天平均
														</#if>
													</td>	
												</tr>
												<#list x.fieldList as y>
													<#if (y_index > 0)>
													<tr>
														<td>${y.fieldName}</td>
														<td>${y.dataType}</td>
														<td class="u-radios">
															<#if y.algorithm??>
																<#assign algorithm=y.algorithm?join(',')/>
																<input type="checkbox" value="yesterday" class="j-ch" <#if algorithm?? && algorithm?contains("yesterday")>checked="checked"</#if>/>昨天同期值
																<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch" <#if algorithm?? && algorithm?contains("sevenDaysAvg")>checked="checked"</#if>/>近7天平均
															<#else>
																<input type="checkbox" value="yesterday" class="j-ch"/>昨天同期值
																<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch"/>近7天平均
															</#if>
														</td>	
													</tr>
													</#if>
												</#list>
											</#if>
										</#list>
										</#if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					</#if>
					</#if>
					</#if>
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
						<label class="fmlab">是否支持多实例：</label>
						<div class="fmcnt">
							<div class="u-iptw">
								<#if multiInstance == false>
								否
								<#else>
								是
								</#if>
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
				<#else>
					<div class="fmitem j-collectoritem">
						<label class="fmlab">采集时间段：</label>
						<div class="fmcnt">
							<div class="fmcnt">
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
					</div>
					<div class="fmitem j-collectoritem">
						<label class="fmlab"><i>*</i>是否需要趋势预测：</label>
						<div class="fmcnt">
							<div class="u-radios" id="pre">
								<input type="radio" value="1" name="predictFlag" data-action="pre" <#if predictFlag?? && predictFlag == 1>checked="checked"</#if>/>是
								<input type="radio" value="0" name="predictFlag" data-action="pre" class="u-iptw" <#if predictFlag??><#if predictFlag == 0>checked="checked"</#if><#else>checked="checked"</#if>/>否
							</div>
							<div class="pre-box hide" id="pre-box">
								<table class="m-table" id="pre-table">
									<thead> 
										<tr>
											<th>数据项名称</th>
											<th>指标项名称</th>
											<th>指标项数据类型</th>
											<th>预测算法</th>
										</tr>
									</thead>
									<tbody>
										<#if monitorItem.predictConfig??>
										<#list monitorItem.predictConfig as x>
											<#if (x.fieldList?size > 0)>
												<tr>
													<td rowspan="${x.fieldList?size}">${x.dataModelName}</td>
													<td>${x.fieldList[0].fieldName}</td>
													<td>${x.fieldList[0].dataType}</td>
													<td class="u-radios">
														<#if x.fieldList[0].algorithm??>
															<#assign algorithm=x.fieldList[0].algorithm?join(',')/>
															<input type="checkbox" value="yesterday" class="j-ch" <#if algorithm?? && algorithm?contains("yesterday")>checked="checked"</#if>/>昨天同期值
															<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch" <#if algorithm?? && algorithm?contains("sevenDaysAvg")>checked="checked"</#if>/>近7天平均
														<#else>
															<input type="checkbox" value="yesterday" class="j-ch"/>昨天同期值
															<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch"/>近7天平均
														</#if>
													</td>	
												</tr>
												<#list x.fieldList as y>
													<#if (y_index > 0)>
													<tr>
														<td>${y.fieldName}</td>
														<td>${y.dataType}</td>
														<td class="u-radios">
															<#if y.algorithm??>
																<#assign algorithm=y.algorithm?join(',')/>
																<input type="checkbox" value="yesterday" class="j-ch" <#if algorithm?? && algorithm?contains("yesterday")>checked="checked"</#if>/>昨天同期值
																<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch" <#if algorithm?? && algorithm?contains("sevenDaysAvg")>checked="checked"</#if>/>近7天平均
															<#else>
																<input type="checkbox" value="yesterday" class="j-ch"/>昨天同期值
																<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch"/>近7天平均
															</#if>
														</td>	
													</tr>
													</#if>
												</#list>
											</#if>
										</#list>
										</#if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="fmitem j-collectoritem">
						<label class="fmlab"><i>*</i>采集间隔时间：</label>
						<div class="fmcnt">
							<div class="u-iptw"><i class="unit">s</i><input type="text" name="collectorInterval" class="u-ipt" value="${collectorInterval!}" data-required="true" data-message="不能为空"></div>
						</div>
					</div>
					<div class="fmitem j-collectoritem">
						<label class="fmlab">是否支持多实例：</label>
						<div class="fmcnt">
							<div class="u-iptw">
								<#if multiInstance == false>
								否
								<#else>
								是
								</#if>
							</div>
						</div>
					</div> 
				</#if>
			</#if>
			</div>
		</div>
		<div class="u-btnfm">
			<span class="u-btn u-btn-s3" id="submit">提 交</span>
			<a class="u-btn u-btn-s4" href="javascript:history.go(-1)">取 消</a>
		</div>
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
	<textarea name="jst" id="jst-win-form2">
		<div class="m-form">
			{if collectorType == 'system'}
			<div class="fmitem j-collectoritem">
				<label class="fmlab">脚本名称：</label>
				<div class="fmcnt">${scriptName}</div>
			</div>
			<div class="fmitem j-collectoritem">
				<label class="fmlab">脚本参数：</label>
				<div class="fmcnt">
					<textarea class="u-ipt" name="arguments">${arguments}<&#47;textarea>
				</div>
			</div>
			{/if}
			<div class="fmitem j-collectoritem">
				<label class="fmlab"><i>*</i>采集时间段：</label>
				<div class="fmcnt">
					<select name="collectorRange">
						<option value="[* * * * * ?]">全天</option>
						<option value="self">自定义</option>
					</select>
					<span class="selfTime hide" id="self-box">
						<input type="text" class="u-ipt u-ipt-s6" id="selfTime" name="selfTime" value="[* * * * * ?]"/>
						<div>
							<p class="f-red">注意：不合理的采集时间段会影响到正常的报警，操作需谨慎！如不清楚建议采用全天或者咨询运维开发值班！</p><p>采集时间段的解释和quartz语法请点击<a href="http://doc.hz.netease.com/pages/viewpage.action?pageId=48877622" target="_blank" style="color:#0095d9;font-weight:bold;">这里</a></p></div>
					</span>
				</div>
			</div>
			{if clusterId}
			<div class="fmitem j-collectoritem">
				<label class="fmlab"><i>*</i>是否需要趋势预测：</label>
				<div class="fmcnt">
					<div class="u-radios" id="pre">
						<input type="radio" value="1" name="predictFlag" data-action="pre"/>是
						<input type="radio" value="0" name="predictFlag" data-action="pre" class="u-iptw" checked/>否
					</div>
					<div class="pre-box hide" id="pre-box">
						<table class="m-table" id="pre-table">
							<thead> 
								<tr>
									<th>数据项名称</th>
									<th>指标项名称</th>
									<th>指标项数据类型</th>
									<th>预测算法</th>
								</tr>
							</thead>
							<tbody>
								{if predictConfig}
								{list predictConfig as x}
									{if x.fieldList.length>0}
										<tr>
											<td rowspan="${x.fieldList.length}">${x.dataModelName}</td>
											<td>${x.fieldList[0].fieldName}</td>
											<td>${x.fieldList[0].dataType}</td>
											<td class="u-radios">
												<input type="checkbox" value="yesterday" class="j-ch"/>昨天同期值
												<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch"/>近7天平均
											</td>	
										</tr>
										{list x.fieldList as y}
											{if y_index>0}
											<tr>
												<td>${y.fieldName}</td>
												<td>${y.dataType}</td>
												<td class="u-radios">
													<input type="checkbox" value="yesterday" class="j-ch"/>昨天同期值
													<input type="checkbox" value="sevenDaysAvg" class="u-iptw j-ch"/>近7天平均
												</td>	
											</tr>
											{/if}
										{/list}
									{/if}
								{/list}
								{/if}
							</tbody>
						</table>
					</div>
				</div>
			</div>
			{/if}
			<div class="fmitem j-collectoritem">
				<label class="fmlab"><i>*</i>采集间隔时间：</label>
				<div class="fmcnt">
					<div class="u-iptw"><i class="unit">s</i><input type="text" name="collectorInterval" value="${collectorInterval}" class="u-ipt" data-required="true" data-message="不能为空"></div>
				</div>
			</div>
			<div class="fmitem j-collectoritem">
				<label class="fmlab">是否支持多实例：</label>
				<div class="fmcnt">
					<div class="u-iptw">
					{if multiInstance == false}
					否
					{else}
					是
					{/if}
					</div>
				</div>
			</div>
		{if collectorType == 'system'}
			<div class="fmitem j-collectoritem">
				<label class="fmlab"><i>*</i>超时时间：</label>
				<div class="fmcnt">
					<div class="u-iptw"><i class="unit">s</i><input type="text" name="timeout" class="u-ipt" value="${timeout}" data-required="true" data-message="不能为空"></div>
				</div>
			</div>
			<div class="fmitem j-collectoritem">
				<label class="fmlab"><i>*</i>执行账号：</label>
				<div class="fmcnt"><input type="text" name="execAccount" class="u-ipt" value="${execAccount}" data-required="true" data-message="不能为空"></div>
			</div>
		{/if}
		</div>
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
	<textarea name="jst" id="jst-win-server-list">
		<ul>
			{list serverList as x}
			<li data-id="${x.serverId}" data-action="select" data-name="{if x.aliasName}${x.aliasName}-${x.hostName}{else}${x.hostName}{/if}">
				<a href="javascript:;">{if x.aliasName}${x.aliasName}-${x.hostName}{else}${x.hostName}{/if}</a>
			</li>
			{/list}
		</ul>
	</textarea>
	<textarea name="jst" id="jst-win-server-warning">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="txt" id="txt-add-item">
	    <li class="j-cd">
	    	<input type="text" class="j-flag u-ipt person" value="" placeholder="请输入邮箱前缀"/>
	    	<i class="u-icon u-icon-del" data-action="del"></i>
	    </li>
	</textarea>
	</#noparse>
</div>
</#macro>
</#escape>