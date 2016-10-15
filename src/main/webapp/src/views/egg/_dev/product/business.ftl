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
	<link rel="stylesheet" type="text/css" href="${jsCommon}/module/guide/css/jquery.pagewalkthrough.css">
	</@head>

	<script src="${jsCommon}/module/My97DatePicker/WdatePicker.js"></script>
	<script src="${jsCommon}/module/jquery.min.js"></script>
	<script src="${jsCommon}/module/guide/js/jquery.pagewalkthrough.js"></script>
</head>
<body id="sentry-system">
<div class="g-doc">
	<div class="g-hd">
		<@nav index=1 />
	</div>
	<div class="g-bd" id="content">
		<div class="g-sd <#if (RequestParameters.show)??>lt-24<#else>lt0</#if>">
			<#if user.external>
			<#if my??>
			<@sidenav tree=my />
			</#if>
			<#else>
			<#if all??>
			<@sidenav tree=all />
			</#if>
			</#if>
		</div>
		<div class="g-mn g-mn-1 <#if (RequestParameters.show)??>lt0<#else>lt24</#if>">
			<#if (RequestParameters.productId)?? && (RequestParameters.productId)!="-1">
			<div class="g-cnt g-cnt-2 product">
				<div class="m-tab">
				    <ul id="tab">
				        <li class="z-act"><a href="javascript:;">业务视图</a></li>
				        <li><a href="/sentry/product/monitorstatus?productId=${RequestParameters.productId}">监控视图</a></li>
				        <li><a href="/sentry/product/volume?productId=${RequestParameters.productId}&pageNumber=1">产品容量</a></li>
				        <#-- <li><a href="javascript:;">问题定位</a></li> -->
				    </ul>
			     </div>
			     <form id="form">
				     <div class="fmitem">
						<div class="fmcnt">
							<span class="fmlab">时间范围：</span>
							<span class="u-seltag">
								<a href="business?productId=${RequestParameters.productId!}&rangeType=1h" <#if RequestParameters.rangeType?default('1h')?string == '1h'>class="act"</#if>>最近1小时</a>
							</span>
							<span class="u-seltag">
								<a href="business?productId=${RequestParameters.productId!}&rangeType=3h" <#if RequestParameters.rangeType?default('1h')?string == '3h'>class="act"</#if>>最近3小时</a>
							</span>
							<span class="u-seltag">
								<a href="business?productId=${RequestParameters.productId!}&rangeType=6h" <#if RequestParameters.rangeType?default('1h')?string == '6h'>class="act"</#if>>最近6小时</a>
							</span>
							<span class="u-seltag">
								<a href="business?productId=${RequestParameters.productId!}&rangeType=today" <#if RequestParameters.rangeType?default('1h')?string == 'today'>class="act"</#if>>今天</a>
							</span>
							<span class="u-seltag">
								<a href="business?productId=${RequestParameters.productId!}&rangeType=yesterday" <#if RequestParameters.rangeType?default('1h')?string == 'yesterday'>class="act"</#if>>昨天</a>
							</span>
							<span class="u-seltag">
								<a href="business?productId=${RequestParameters.productId!}&rangeType=3d" <#if RequestParameters.rangeType?default('1h')?string == '3d'>class="act"</#if>>最近3天</a>
							</span>
							<span class="u-seltag j-custom">
								<a href="javascript:void(0)" <#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>class="act"</#if>>自定义</a>
							</span>
							<span class="custom <#if RequestParameters.rangeType?default('1h')?string == 'selfdefine'>act-1</#if>">
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
							</span>
						</div>
					</div>
				</form>
				<#if (result??) && (result?size > 0)>
					<#-- 计算是否有xml视图 -->
					<#assign count=0 />
					<#list result as x>
						<#if x.viewConfig??>
							<#assign count=count+1 />
						</#if>
					</#list>
					<#if (count!=0)>
					<div class="m-charts m-charts-1" id="chartscnt">
						<ul class="charts f-cb">
						<#list result as xx>
							<#if xx.viewConfig??>
								<#if xx.viewConfig.viewList??>
								<#list xx.viewConfig.viewList as view>
								<li class="w2 ${view.type} js-blog">
									<#assign type = view.type>
									<div class="cnt">
										<div class="hd f-cb">
											<div class="tit js-tit">${view.title!}</div>
											<div class="opt f-cb">
												<div data-itemtype="${xx.itemType}" data-itemid="${xx.monitorItemId}" class="cluster f-icon js-cluster" title="跳转到集群">
												</div>
												<div class="zoom f-icon js-zoom" title="放大"></div>
											</div>
										</div>
										<div class='bd js-chartbd'></div>
									</div>
								</li>
								</#list>
								</#if>
							</#if>
						</#list>
						</ul>
					</div>
					<#else>
					<div class="m-tab" style="margin-top:20px;">
						<h2>请先正确配置视图XML文件</h2>
					</div>
					</#if>
				<#else>
					<div class="m-tab" style="margin-top:20px;">
						<h2>未定义业务监控标签</h2>
					</div>
				</#if>
			</div>
			<#else>
			<div class="g-cnt">
				<div class="m-tab">
					<h2>请在左侧的产品树上选择集群</h2>
				</div>
			</div>
			</#if>
		</div>
		<div class="g-sl">
			<@menu index=0/>
		</div>
	</div>
</div>

<div style="display:none" id ="jst-template">
<#noparse>
<textarea name="jst" id="jst-win-form-status">
	<div class="m-form">
		<div class="fmitem"><span class="fmlab">数据项：</span><div class="fmcnt">${dataModel}</div></div>
		<div class="fmitem"><span class="fmlab">采集时间：</span><div class="fmcnt">${collectTime}</div></div>
		<div class="fmitem"><span class="fmlab">数据采集详情：</span><div class="fmcnt">${dataDetail}</div></div>
	</div>
</textarea>
</#noparse>
</div>

<#noescape>
<script type="text/javascript">
	var VIEWLIST = [];
	var viewCountEachRow;
	var condition = '';
	var ViewType = 'product';
	<#if result??>
		<#list result as x>
			<#if x.viewConfig?? && x.viewConfig.viewList??>
			<#list x.viewConfig.viewList as view>
			var obj = {
				type: '${view.type}',
				url: '${view.url}',
				params: JSON.parse('${view.params}')
			};
			VIEWLIST.push(obj);
			</#list>
			</#if>
		</#list>
	</#if>
</script>
</#noescape>	
<#noparse>
<!-- @DEFINE -->
</#noparse>
<script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
<script src="${jsPages}/sentry/product/business.js"></script>
</body>
</html>
</#escape>