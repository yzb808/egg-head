<#macro view viewConfig>
<#if viewConfig != 'false'>
<div class="m-charts">
	<ul class="f-cb">
		<#-- 一行显示图表的数量 -->
		<#assign rownum = viewConfig.viewCountEachRow>
		<#list viewConfig.viewList as view>
		<li class="w${rownum} ${view.type} js-blog">
			<#assign type = view.type>
			<div class="cnt">
				<div class="hd f-cb">
					<div class="tit js-tit">${view.title!}</div>
					<#if type = "graph">
					<div class="opt f-cb">
						<div class="refresh f-icon js-refresh"></div>
						<div class="zoom f-icon js-zoom"></div>
					</div>
					</#if>
				</div>
				<div class='bd js-chartbd'></div>
			</div>
		</li>
		</#list>
	</ul>
</div>
<#else>
	${errorMessage!}
</#if>
</#macro>

<#macro multiQuery>
	<div class="g-parameters <#if (displayMultiItemList?? && displayMultiItemList?size>0) >j-multi</#if>">
		<div class="m-parameters" id="parameters">
			<dl class="f-cb j-domain">
				<dt>域选择：</dt>
				<dd>
				<#if (domainList?? && domainList?size>0)>
					<ul class="f-cb js-options" data-label="domain">
					   
						<#list domainList as domain>
						<li data-domainId="${domain.id}" <#if condition??><#if condition.domainId?number == domain.id?number>class="cur"</#if></#if>>${domain.domainName}</li>
						</#list>
					</ul>
				<#else>
				域为空
				</#if>
				</dd>
			</dl>
			<dl class="f-cb j-instances js-flag">
				<dt>实例列表：</dt>
				<dd>
					<#if (allInstanceList?? && allInstanceList?size>0)>
					<ul class="f-cb js-options" data-label="instance">
						<#list allInstanceList as instance>
						<li data-instanceId="${instance.id}" class="j-item <#if condition??><#if condition.instanceId == instance.id>cur</#if></#if>">${instance.name}</li>
						</#list>
						<li class="j-more hidden" data-type="instances"><a>更多实例&gt;</a></li>
					</ul>

					<#else>
					实例为空
					</#if>
				</dd>
			</dl>
			<dl class="f-cb j-monitoritems js-flag">
				<dt>监控项：</dt>
				<dd>
					<ul class="f-cb js-options" data-label="monitor">
					<#if (tagList??  && tagList?size>0 )>
						<#list tagList as monitorItem>						
						<li data-itemId="${monitorItem.id}" data-itemType="0" class="j-item <#if condition??><#if (condition.itemId?number == monitorItem.id?number && condition.itemType?number == 0)>cur</#if></#if>">${monitorItem.tagName}</li>
						</#list>
					</#if>
					<span>|</span>
					<#if (displaySingleItemList?? && displaySingleItemList?size>0)>
						<#list displaySingleItemList as monitorItem>						
						<li data-itemId="${monitorItem.id}" data-itemType="1" class="j-item <#if condition??><#if (condition.itemId?number == monitorItem.id?number && condition.itemType?number == 1)>cur</#if></#if>">${monitorItem.name}</li>
						</#list>
						<#if (allSingleItemList?size > displaySingleItemList?size) >
						<li class="j-more"  data-type="singleItem"><a>更多监控项&gt;</a></li>
						</#if>
					<#else>
					监控项为空
					</#if>
					</ul>
				</dd>
			</dl>
			<#if (allMultiItemList?? && allMultiItemList?size>0) >
			<dl class="f-cb j-monitoritems js-flag">
				<dt>多实例：</dt>
				<dd>
					<ul class="f-cb js-options" data-label="monitor">
						<#list allMultiItemList as monitorItem>			
						<li data-itemId="${monitorItem.id}" data-itemType="2" class="j-item <#if condition??><#if (condition.itemId?number == monitorItem.id?number && condition.itemType?number = 2)>cur</#if></#if>">${monitorItem.name}</li>
						</#list>
						<li class="j-more hidden" data-type="multiItem"><a>更多多实例&gt;</a></li>
					</ul>		
				</dd>
			</dl>
			</#if>
			<dl class="f-cb time-select-box">
				<dt>时间段：</dt>
				<#if condition??>
					<#assign rangeType = condition.rangeType?default('1h') />
				<#else>
					<#assign rangeType = '1h' />
				</#if>
				<dd class="j-time">
					<ul class="f-cb js-options" data-label="time">
						<li data-rangeType="1h" <#if rangeType = '1h'>class="cur"</#if>>最近1小时</li>
						<li data-rangeType="3h" <#if rangeType = '3h'>class="cur"</#if>>最近3小时</li>
						<li data-rangeType="6h" <#if rangeType = '6h'>class="cur"</#if>>最近6小时</li>
						<li data-rangeType="today" <#if rangeType = 'today'>class="cur"</#if>>今天</li>
						<li data-rangeType="yesterday" <#if rangeType = 'yesterday'>class="cur"</#if>>昨天</li>
						<li data-rangeType="3d" <#if rangeType = '3d'>class="cur"</#if>>最近3天</li>
						<li data-rangeType="time" class="ipt-time">
							最近<input type="text" class="u-ipt u-small" id="ipt-time" <#if rangeType?? && rangeType?substring(0,1)=='-'>value="${rangeType?substring(1,rangeType?length-1)}"</#if>/>分钟
						</li>
						<#-- <li data-rangeType="7d" <#if rangeType = '7d'>class="cur"</#if>>最近7天</li>
						<li data-rangeType="1m" <#if rangeType = '1m'>class="cur"</#if>>最近1月</li> -->
						<#if condition??>
							<#if rangeType == 'selfdefine'>
							<div class="j-custom">
								<input type="text" value="<#if condition.startTime??>${condition.startTime}</#if>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
								~
								<input type="text" value="<#if condition.endTime??>${condition.endTime}</#if>" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
								<a class="u-btn u-btn-c1 j-confirm">确定</a>
							</div>
							<#else>
							<li data-type="selfdefine" class="j-more" ><a>自定义>></a></li>
							<div class="j-custom" style="display:none;" >
								<input type="text" value="" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
								~
								<input type="text" value="" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',autoPickDate:true})" class="Wdate u-ipt u-ipt-s1"/>
								<a class="u-btn u-btn-c1 j-confirm">确定</a>
							</div>
							</#if>
						</#if>
					</ul>
				</dd>
			</dl>
		</div>
		<div class="m-stretch opened" id="stretch">
			<div class="arrow"></div>
		</div>
	</div>
</#macro>