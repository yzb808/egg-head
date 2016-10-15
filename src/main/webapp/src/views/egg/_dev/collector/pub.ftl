<#escape x as x!""?html>
<#macro formTemplate>
<form id="form" class="form">
	<h2 class="u-tt">基本信息</h2>
	<div class="m-form">
		<div class="fmitem">
			<label class="fmlab">&#12288;&#12288;<i>*</i>采集器名称：</label>
			<div class="fmcnt">
				<input type="text" 
				       name="collectorName" 
				       class="u-ipt"
				       data-required="true"
				       data-message="不能为空"
				       value="<#if collectorConfig??>${collectorConfig.collectorName!}</#if>">
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab">采集器类型：</label>
			<div class="fmcnt">
				<select class="u-ipt" name="type">
					<#if collectorConfig?? && collectorConfig.id??>
					    <#if collectorConfig.type="system">
					    <option value="system">脚本采集</option>
					    <#elseif collectorConfig.type="app">
					    <option value="app">java应用数据采集</option>
					    <#elseif collectorConfig.type="vip">
					    <option value="vip">vip</option>
					    </#if>
					<#else>
					<option value="system" selected="selected">脚本采集</option>
					<option value="app">java应用数据采集</option>
					<option value="vip">vip</option>
					</#if>
				</select>
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab">采集器级别：</label>
			<div class="fmcnt">
				<div class="u-radios">
					<label>
						<input type="radio" name="scope" value="pub" class="u-radio" 
						<#if collectorConfig??>
						<#if collectorConfig.scope?? && collectorConfig.scope=="pub">checked="checked"</#if>
						</#if>>公有</label>
					<label>
						<input type="radio" name="scope" value="personal" class="u-radio" 
						<#if collectorConfig??>
							<#if collectorConfig.scope?? && collectorConfig.scope=="personal">checked="checked"</#if>
						<#else>
							checked="checked"
						</#if>>私有</label>
				</div>
			</div>
		</div>
		<div class="fmitem m-alarm-person">
			<label class="fmlab"><i>*</i>所有人：</label>
			<div class="fmcnt">
				<ul class="f-fl itms" id="person-list">
					<#if RequestParameters.id??>
					<#if collectorConfig.owner??>
					<#list collectorConfig.owner as person>
					<li class="j-cd">
						<input type="text" class="j-flag u-ipt person" value="${person.account}" data-id="${person.id}" placeholder="请输入邮箱前缀"/>
						<i class="u-icon u-icon-del remove-person" data-action="del"></i>
					</li>
					</#list>
					</#if>
					<#else>
					<li class="j-cd" style="position:relative;">
						<input type="text" class="j-flag u-ipt person" value="${user.userName}" data-id="${user.userId}" placeholder="请输入邮箱前缀"/>
						<i class="u-icon u-icon-del remove-person" data-action="del"></i>
					</li>
					</#if>
					<a class="u-btn add" id="add-person" data-action="add">+</a>
				</ul>
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab">采集器描述：</label>
			<div class="fmcnt">
				<textarea class="u-ipt u-txtarea-1" name="descp"><#if collectorConfig??>${collectorConfig.descp!}</#if></textarea>
			</div>
		</div>
	</div>
	<div class="u-line"></div>
	<h2 class="u-tt">高级属性</h2>
	<div class="m-form">
		<div class="fmitem j-type1" <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">style="display:none;"</#if>>
			<label class="fmlab">采集方式：</label>
			<div class="fmcnt">
				<select class="u-ipt" name="collectMethod">
					<#if collectorConfig??>
						<#if collectorConfig.type == 'system'>
						<option value="local" class="agent">本机agent采集</option>
						</#if>
					<#else>
						<option value="local" class="agent">本机agent采集</option>
					</#if>
					<option value="superagent">外部执行</option>
				</select>
			</div>
		</div>
		<div class="fmitem j-type1" <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">style="display:none;"</#if>>
			<label class="fmlab"><i>*</i>操作系统：</label>
			<div class="fmcnt">
				<div class="u-radios">
					<label><input type="checkbox" name="os" value="linux" class="u-radio" 
					<#if collectorConfig?? && collectorConfig.os??>
					<#if (collectorConfig.os!"")?contains("linux")>checked="checked"</#if>
					<#else>checked="checked"</#if>>linux</label>
					<label><input type="checkbox" name="os" value="windows" class="u-radio" <#if collectorConfig?? && (collectorConfig.os!"")?contains("windows")>checked="checked"</#if>>windows</label>
				</div>
			</div>
		</div>
		<div class="fmitem j-type1" <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">style="display:none;"</#if>>
			<label class="fmlab">是否agent内置：</label>
			<div class="fmcnt">
				<div class="u-radios">
					<label><input type="radio" name="isInner" value="1" class="u-radio" <#if collectorConfig?? && collectorConfig.isInner?? && collectorConfig.isInner==1>checked="checked"</#if>>是</label>
					<label><input type="radio" name="isInner" value="0" class="u-radio" <#if collectorConfig?? && collectorConfig.isInner??><#if collectorConfig.isInner==0>checked="checked"</#if><#else>checked="checked"</#if>>否</label>
				</div>
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab">是否支持多实例：</label>
			<div class="fmcnt">
				<div class="u-radios">
					<label><input type="radio" name="multiInstance" value="true" class="u-radio" <#if collectorConfig?? && collectorConfig.multiInstance?? && collectorConfig.multiInstance==true>checked="checked"</#if>>是</label>
					<label><input type="radio" name="multiInstance" value="false" class="u-radio" <#if collectorConfig?? && collectorConfig.multiInstance??><#if collectorConfig.multiInstance==false>checked="checked"</#if><#else>checked="checked"</#if>>否</label>
				</div>
			</div>
		</div>
		<div class="fmitem j-type1" <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">style="display:none;"</#if>>
			<label class="fmlab"><i>*</i>默认执行账号：</label>
			<div class="fmcnt"><input type="text" class="u-ipt" name="defaultExecAccount" data-required="true" data-message="选择系统采集器时，默认执行账号不能为空" value="<#if collectorConfig??>${collectorConfig.defaultExecAccount!'nobody'}<#else>nobody</#if>"></div>
		</div>
		<div class="fmitem">
			<label class="fmlab">默认采集时间段：</label>
			<div class="fmcnt">
				<div class="u-radios">
					<label><input type="radio" name="defaultCollectRange" value="0" class="" checked="checked">全天</label>
					<#-- <label><input type="radio" name="" value="" class="">上班时间</label>
					<label><input type="radio" name="" value="" class="">下班时间</label>
					<label><input type="radio" name="" value="" class="">其他</label>
					<label><input type="text" name="" value="" class="u-ipt"/></label> -->
				</div>
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab"><i>*</i>默认采集间隔：</label>
			<div class="fmcnt">
				<div class="u-iptw">
					<i class="unit">s</i>
					<input type="text"
						   name="defaultInterval" 
						   class="u-ipt"
						   value="<#if collectorConfig??>${collectorConfig.defaultInterval!'60'}<#else>60</#if>"
						   data-required="true"
						   data-message="不能为空">
				</div>
			</div>
		</div>
		<div class="fmitem j-type1" <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">style="display:none;"</#if>>
			<label class="fmlab"><i>*</i>默认超时时间：</label>
			<div class="fmcnt">
				<div class="u-iptw">
					<i class="unit">s</i>
					<input type="text" 
						   name="defaultTimeout" 
						   class="u-ipt"
						   value="<#if collectorConfig??>${collectorConfig.defaultTimeout!'10'}<#else>10</#if>"
						   <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">
						   data-required="false"
						   <#else>
						   data-required="true"
						   </#if>
						   data-message="不能为空">
				</div>
			</div>
		</div>
	</div>
	<div class="u-line"></div>
	<h2 class="u-tt">设置脚本/输出数据项</h2>
	<div class="m-form">
		<div class="fmitem j-type1" <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">style="display:none;"</#if>>
			<label class="fmlab">&#12288;&#12288;&#12288;<i>*</i>脚本名称：</label>
			<div class="fmcnt">
				<input type="text" 
					   name="scriptName" 
					   class="u-ipt j-flag"
					   <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">
					   data-required="false"
					   <#else>
					   data-required="true"
					   </#if>
					   data-message="不能为空"
					   value="<#if collectorConfig??>${collectorConfig.scriptName!}</#if>">
			</div>
		</div>
		<div class="fmitem j-type1" <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">style="display:none;"</#if>>
			<label class="fmlab">默认脚本参数：</label>
			<div class="fmcnt"><textarea name="arguments" class="u-ipt u-txtarea-2"><#if collectorConfig??>${collectorConfig.arguments!}</#if></textarea></div>
		</div>
		<div class="fmitem j-byisinner j-type1" <#if (collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app") || (collectorConfig?? && collectorConfig.isInner?? && collectorConfig.isInner==1)>style="display:none;"</#if>>
			<label class="fmlab">脚本类型：</label>
			<div class="fmcnt">
				<select class="u-ipt" name="scriptType">
					<option value="shell" <#if collectorConfig ?? && collectorConfig.scriptType?? && collectorConfig.scriptType=="shell">selected="selected"</#if>>shell</option>
					<option value="python" <#if collectorConfig ?? && collectorConfig.scriptType?? && collectorConfig.scriptType=="python">selected="selected"</#if>>python</option>
					<option value="perl" <#if collectorConfig ?? && collectorConfig.scriptType?? && collectorConfig.scriptType=="perl">selected="selected"</#if>>perl</option>
				</select>
			</div>
		</div>
		<div class="fmitem j-type1" <#if collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app">style="display:none;"</#if>>
			<label class="fmlab">采集器输出格式：</label>
			<div class="fmcnt">
				<select class="u-ipt" name="outputType">
					<option value="txt" <#if collectorConfig?? && collectorConfig.outputType?? && collectorConfig.outputType=="txt">selected="selected"</#if>>文本</option>
					<option value="json" <#if collectorConfig?? && collectorConfig.outputType?? && collectorConfig.outputType=="json">selected="selected"</#if>>JSON</option>
				</select>
			</div>
		</div>
		<div class="fmitem j-byisinner j-type1" id="changeWithScriptType" <#if (collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app") || (collectorConfig?? && collectorConfig.isInner?? && collectorConfig.isInner==1) || (collectorConfig?? && collectorConfig.scriptType?? && collectorConfig.scriptType=="c")>style="display:none;"</#if>>
			<label class="fmlab"><i>*</i>脚本内容：</label>
			<div class="fmcnt">
				<textarea name="scriptText" 
				          class="u-ipt u-txtarea-3 j-flag"
				          <#if (collectorConfig?? && collectorConfig.type?? && collectorConfig.type=="app") || (collectorConfig?? && collectorConfig.isInner?? && collectorConfig.isInner==1) || (collectorConfig?? && collectorConfig.scriptType?? && collectorConfig.scriptType=="c")>
				          data-required="false"
				          <#else>
				          data-required="true"
				          </#if>
				          data-message="不能为空"><#if collectorConfig??>${collectorConfig.scriptText!}</#if></textarea>
			</div>
		</div>
		<#-- <div class="fmitem">
			<label class="fmlab"></label>
			<div class="fmcnt"><a class="u-btn">试运行</a></div>
		</div> -->
		<div class="fmitem">
			<label class="fmlab"><i>*</i>输出数据项：</label>
			<div class="fmcnt" id="tab-box">
			</div>
		</div>
	</div>
	<div class="u-btnfm">
		<span class="u-btn u-btn-s3" id="submit">提 交</span>
		<a class="u-btn u-btn-s4" href="javascript:history.go(-1)">取 消</a>
	</div>
</form>
</#macro>

<#macro jstTemplate>
<div style="display:none" id="jst-template">
<#noparse>
	<textarea name="jst" id="jst-win-form-del">
		<div class="windescption"><i class="u-icon u-icon-warn"></i>${descption}</div>
	</textarea>
	<textarea name="txt" id="txt-add-item">
	    <li class="j-cd">
	    	<input type="text" class="j-flag u-ipt person" value="" placeholder="请输入邮箱前缀"/>
	    	<i class="u-icon u-icon-del" data-action="del"></i>
	    </li>
	</textarea>
</#noparse>
</#macro>
</#escape>