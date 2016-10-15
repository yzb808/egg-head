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
</head>
<body id="sentry-system">
<div class="g-doc">
	<div class="g-hd">
		<@nav index=0 />
	</div>
	<div class="g-bd" id="content">
		<div class="g-sd <#if (RequestParameters.show)??>lt-24<#else>lt0</#if>">
			<#if user.external>
			<#if my??>
			<@sidenav tree=my index=6/>
			</#if>
			<#else>
			<#if all??>
			<@sidenav tree=all index=6/>
			</#if>
			</#if>
		</div>
		<div class="g-mn <#if (RequestParameters.show)??>lt0<#else>lt24</#if>">
			<div class="g-cnt g-cnt-2">
				<form id="search-form">
					<div class="m-form2">
						<div class="fmitem">
							<label class="fmlab">产品：</label>
							<div class="fmcnt">
								<select class="u-ipt" name="productId">
								    <option value="" >全部</option>
									<#if search??>
									<#list search as x>
										<#if x.product??>
										<#list x.product as xx>
											<option value="${xx.id}" <#if (RequestParameters.productId)?? && (RequestParameters.productId?number == xx.id?number)>selected</#if>>${xx.title!}</option>
										</#list>
										</#if>
									</#list>
									</#if>
								</select>
							</div>
						</div>
						<div class="fmitem">
							<label class="fmlab">应用：</label>
							<div class="fmcnt">
								<select class="u-ipt" name="applicationId">
								    <option value="" >全部</option>
									<#if search??>
									<#list search as x>
										<#if x.product??>
										<#list x.product as xx>
											<#if xx.application??>
											<#list xx.application as xxx>
												<#if (RequestParameters.productId)?? && (RequestParameters.productId?number != xx.id?number)>
												<option class="f-dn" data-product="${xx.id}" value="${xxx.id}" <#if (RequestParameters.applicationId)?? && (RequestParameters.applicationId?number == xxx.id?number)>selected</#if>>${xxx.title!}</option>
												<#else>
												<option data-product="${xx.id}" value="${xxx.id}" <#if (RequestParameters.applicationId)?? && (RequestParameters.applicationId?number == xxx.id?number)>selected</#if>>${xxx.title!}</option>
												</#if>
											</#list>
											</#if>
										</#list>
										</#if>
									</#list>
									</#if>
								</select>
							</div>
						</div>
						<div class="fmitem">
							<label class="fmlab">集群：</label>
							<div class="fmcnt">
								<select class="u-ipt" name="clusterId">
								    <option value="" >全部</option>
									<#if search??>
									<#list search as x>
										<#if x.product??>
										<#list x.product as xx>
											<#if xx.application??>
											<#list xx.application as xxx>
												<#if xxx.cluster??>
												<#list xxx.cluster as xxxx>
													<#if (RequestParameters.productId)?? && (RequestParameters.productId?number != xx.id?number)>
													<option class="f-dn" data-product="${xx.id}" data-application="${xxx.id}" value="${xxxx.id}" <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>selected</#if>>${xxxx.title!}</option>
													<#else>
														<#if (RequestParameters.applicationId)?? && (RequestParameters.applicationId?number != xxx.id?number)>
														<option class="f-dn" data-product="${xx.id}" data-application="${xxx.id}" value="${xxxx.id}" <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>selected</#if>>${xxxx.title!}</option>
														<#else>
														<option data-product="${xx.id}" data-application="${xxx.id}" value="${xxxx.id}" <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>selected</#if>>${xxxx.title!}</option>
														</#if>
													</#if>
												</#list>
												</#if>
											</#list>
											</#if>
										</#list>
										</#if>
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
							<div class="fmcnt">
								<label><input type="checkbox" name="onlyShowOwner" style="vertical-align: middle;margin-right:2px;" <#if RequestParameters.onlyShowOwner?? && RequestParameters.onlyShowOwner=='1'>checked="checked"</#if>/>我负责的产品</label>
								<label><input type="checkbox" name="onlyAlarmRule" style="vertical-align: middle;margin-right:2px;" <#if RequestParameters.onlyAlarmRule?? && RequestParameters.onlyAlarmRule=='1'>checked="checked"</#if>/>有报警项</label>
							</div>
						</div>
						<div class="fmitem">
							<input type="button" class="u-btn u-btn-s1" name="search-ok" value="搜索"/>
						</div>
					</div>
				</form>
			    <div class="m-bar m-bar-1">
					<div class="u-btns">
						<a href="javascript:;" class="u-btn" id="btn-quick-close" data-type="<#if !(RequestParameters.type??) || RequestParameters.type=='host'>single<#elseif RequestParameters.type=='vip'>vip<#else>cluster</#if>">快速关闭报警2小时</a>
						<a href="javascript:;" class="u-btn u-btn-c1" id="btn-close" data-type="<#if !(RequestParameters.type??) || RequestParameters.type=='host'>single<#elseif RequestParameters.type=='vip'>vip<#else>cluster</#if>">关闭报警通知</a>
						<span class="u-btn u-btn-c1" id="btn-open" data-type="<#if !(RequestParameters.type??) || RequestParameters.type=='host'>single<#elseif RequestParameters.type=='vip'>vip<#else>cluster</#if>">打开报警通知</span>
						<#if currentStatusCount??>
							<span class="u-btn u-btn-c1">[实际记录数:${currentStatusCount!},目标记录数${targetStatuscount!}]</span>
						</#if>
					</div>
				</div>
				<div class="m-tab">
				    <ul id="tab" data-act="${RequestParameters.type!''}">
				        <li <#if (RequestParameters.type??)><#if RequestParameters.type=='host'>class="z-act"</#if><#else>class="z-act"</#if>><a data-type="host">单机</a></li>
				        <li <#if (RequestParameters.type??) && (RequestParameters.type=='cluster')>class="z-act"</#if>><a data-type="cluster">集群</a></li>
				         <li <#if (RequestParameters.type??) && (RequestParameters.type=='vip')>class="z-act"</#if>><a data-type="vip">VIP</a></li>
				    </ul>
					<div class="m-bar m-bar-1">
						<div class="dtl" id="status-total">[&nbsp;总计:
							<span class="color color-ok"></span><span class="count" data-type="2">${okNum!0}</span>
							<span class="color color-warning"></span><span class="count" data-type="4">${warningNum!0}</span>
							<span class="color color-critical"></span><span class="count" data-type="5">${criticalNum!0}</span>
							<span class="color color-error"></span><span class="count" data-type="3">${errorNum!0}</span>
							<span class="color color-pending"></span><span class="count" data-type="1">${pendingNum!0}</span>
						]</div>
					</div>
			    </div>
				<table class="m-table m-table-1" id="table-list">
					<thead>
						<tr>
							<th class="checkbox"><input type="checkbox" id="select-all"></th>
							<th>产品</th>
							<th>应用</th>
							<th>集群</th>
							<#if !(RequestParameters.type??) || (RequestParameters.type=='host')><th>服务器</th></#if>
							<#if !(RequestParameters.type??) || (RequestParameters.type=='vip')><th>VIP</th></#if>
							<th>监控项</th>
							<th>数据项</th>
							<#if !(RequestParameters.type??) || (RequestParameters.type=='host')><th>实例名称</th></#if>
							<#if !(RequestParameters.type??) || (RequestParameters.type=='vip')><th>监控域</th></#if>
							<th>状态</th>
							<th class="icn">通知</th>
							<th>持续时间</th>
							<#-- <th>采集时间</th> -->
						</tr>
					</thead>
					<tbody>
						<#if statuses??>
							<#list statuses as x>
							<tr>
								<td><input type="checkbox" class="j-check" data-id="${x.id!}"></td>
								<td>
									<span>${x.productTitle!}</span>
								</td>
								<td>${x.applicationTitle!}</td>
								<td>${x.clusterTitle!}</td>
								<#if !(RequestParameters.type??) || (RequestParameters.type=='host')><td>${x.hostName!}</td></#if>
								<#if !(RequestParameters.type??) || (RequestParameters.type=='vip')><th>${x.vipName!}</th></#if>
								<td>${x.monitorItemName!}</td>
								<td>${x.dataModelName!}</td>
								<#if !(RequestParameters.type??) || (RequestParameters.type=='host')>
									<td><#if x.instanceName == "default"><#else>${x.instanceName}</#if></td>
								</#if>
								<#if !(RequestParameters.type??) || (RequestParameters.type=='vip')><th>${x.domainName!}</th></#if>
								<td class="f-cb">
									<#if x.status == 1>
									<span class="u-tag u-tag-pending" data-id="${x.id}">pending</span>
									<#elseif x.status == 2>
									<span class="u-tag u-tag-ok" data-id="${x.id}">ok</span>
									<#elseif x.status == 3>
									<span class="u-tag u-tag-error">error</span>
									<span class="u-tag-detail" data-action="show" data-type="<#if !(RequestParameters.type??) || RequestParameters.type=='host'>single<#elseif RequestParameters.type=='vip'>vip<#else>cluster</#if>" data-id="${x.id}"></span>
									<#elseif x.status == 4>
									<span class="u-tag u-tag-warning">warning</span>
									<span class="u-tag-detail" data-action="show" data-type="<#if !(RequestParameters.type??) || RequestParameters.type=='host'>single<#elseif RequestParameters.type=='vip'>vip<#else>cluster</#if>" data-id="${x.id}"></span>
									<#else>
									<span class="u-tag u-tag-critical">critical</span>
									<span class="u-tag-detail" data-action="show" data-type="<#if !(RequestParameters.type??) || RequestParameters.type=='host'>single<#elseif RequestParameters.type=='vip'>vip<#else>cluster</#if>" data-id="${x.id}"></span>
									</#if>
								</td>
								<td><#if x.isAlarmClosed??><#if x.isAlarmClosed==0><i class="u-icon u-icon-open-alarm"></i><#else><i class="u-icon u-icon-close-alarm"></i></#if></#if>
								</td>
								<td>${x.duration!}</td>
								<#-- <td>${x.triggerTime?datetime}</td> -->
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
		<div class="fmitem"><label class="fmlab">数据项：</label><div class="fmcnt">${dataModel}</div></div>
		<div class="fmitem"><label class="fmlab">采集时间：</label><div class="fmcnt">${collectTime}</div></div>
		<div class="fmitem"><label class="fmlab">数据采集详情：</label><div class="fmcnt">${dataDetail}</div></div>
	</div>
</textarea>
</#noparse>
</div>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/status/person.js"></script>
</body>
</html>
</#escape>