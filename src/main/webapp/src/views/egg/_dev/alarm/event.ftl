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
									<option value="undo"    <#if RequestParameters.status?? && RequestParameters.status == 'undo'>selected="selected"</#if>>未处理</option>
									<option value="done"    <#if RequestParameters.status?? && RequestParameters.status == 'done'>selected="selected"</#if>>已处理</option>
									<option value="ignore"    <#if RequestParameters.status?? && RequestParameters.status == 'ignore'>selected="selected"</#if>>忽略</option>
								</select>
							</div>
						</div>
						<div class="fmitem">
							<div class="fmcnt">
								<label><input type="checkbox" name="onlyShowOwner" style="vertical-align: middle;margin-right:2px;" <#if RequestParameters.onlyShowOwner?? && RequestParameters.onlyShowOwner=='1'>checked="checked"</#if>/>我负责的产品</label>
							</div>
						</div>
						<div class="fmitem">
							<input type="button" class="u-btn u-btn-s1" name="search-ok" value="搜索"/>
						</div>
					</div>
				</form>
				<table class="m-table m-table-1" style="margin-top:20px;" id="table">
					<thead>
						<tr>
							<th>类型</th>
							<th>产品</th>
							<th>应用</th>
							<th>集群</th>
							<th>监控对象</th>
							<th>监控域</th>
							<th>实例名称</th>
							<th>监控项</th>
							<th>规则</th>
							<th>状态</th>
							<th>开始时间</th>
							<th>持续时间</th>
							<th>操作</th>
							<th>处理人</th>
							<#if user.root>
							<th>删除</th>
							</#if>
						</tr>
					</thead>
					<tbody>
						<#if statuses??>
							<#list statuses as x>
							<tr>
								<td>
									<#if x.type?? && x.type==0>
										<span>单机</span>
									<#elseif x.type?? && x.type=1>
										<span>集群</span>
									<#else>
										<span>VIP</span>
									</#if>
								</td>
								<td>${x.productName!}</td>
								<td>${x.applicationName!}</td>
								<td>${x.clusterName!}</td>
								<td>${x.hostName!}</td>
								<td>${x.domainName!}</td>								
								<td><#if x.instance?? && x.instance == "default"><#else>${x.instance!}</#if></td>
								<td>${x.monitorItemName!}</td>
								<td>${x.ruleName!}</td>
								<td class="f-cb">
									<#if x.alarmStatus == 1>
									<span class="u-tag u-tag-pending" data-id="${x.id}">pending</span>
									<#elseif x.alarmStatus == 2>
									<span class="u-tag u-tag-ok" data-id="${x.id}">ok</span>
									<#elseif x.alarmStatus == 3>
									<span class="u-tag u-tag-error">error</span>
									<#elseif x.alarmStatus == 4>
									<span class="u-tag u-tag-warning">warning</span>
									<#else>
									<span class="u-tag u-tag-critical">critical</span>
									</#if>
								</td>
								<td>${x.eventTime?string("yyyy-MM-dd HH:mm:ss")}</td>
								<td>${x.duration!}</td>
								<td>
									<#if x.linkedItilId?? && x.linkedItilId == 0>
										<span>已忽略</span>
									<#elseif x.linkedItilId??>
										<span><a href="http://itil.hz.netease.com/events/${x.linkedItilId!}">已处理</a></span>
									<#else>
										<span>
											<a href="javascript:;" data-action="ignore" data-id="${x.id!}" title="忽略">忽略</a>
											<a href="javascript:;" data-action="process" data-id="${x.id!}" title="处理">处理</a>
										</span>
									</#if>
								</td>
								<td>${x.operator!}</td>
								<#if user.root>
								<td><i class="u-icon u-icon-del2" data-action="del" data-id="${x.id!}"></i></td>
								</#if>
							</tr>
							</#list>
						</#if>
					</tbody>
				</table>
				<@pagination total=total?default(0) />
		</div>
	</div>
</div>
<div style="display:none" id="jst-template">
	<#noparse>
	<textarea name="jst" id="form-ignore">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="jst" id="form-handle">
		<form id="form" class="form">
			<div class="m-form">
				<div class="fmitem">
					<label class="fmlab"><i>*</i>ITIL事件ID：</label>
					<div class="fmcnt">
						<input type="text" class="u-ipt" name="itilId" value="" data-required="true" data-message="不能为空" data-tip="请输入数字"/>
					</div>
				</div>
			</div>
		</form>
	</textarea>
	</#noparse>
</div>
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/alarm/event.js"></script>
</body>
</html>
</@compress>
</#escape>