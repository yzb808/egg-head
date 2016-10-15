<#escape x as x!""?html>
<#macro formTemplate>
<form id="form" class="form">
	<h2 class="u-tt">基本信息</h2>
	<div class="m-form">
		<div class="fmitem">
			<label class="fmlab">&#12288;&#12288;<i>*</i>报警发送模板名称：</label>
			<div class="fmcnt">
				<input type="text" 
				       name="name" 
				       class="u-ipt"
				       data-required="true"
				       data-message="不能为空"
				       value="${name!}">
			</div>
		</div>
		<div class="fmitem">
			<label class="fmlab">&#12288;&#12288;<i>*</i>报警发送模板描述：</label>
			<div class="fmcnt">
				<textarea name="descp" 
					      class="u-ipt"
					      data-required="true"
					      data-message="不能为空"
					      >${descp!}</textarea> 
			</div>
		</div>
	</div>
	<h2 class="u-tt">设置报警通知策略</h2>
	<div id="table-list">
		<table class="m-table m-table-t1" id="table">
			<thead>
				<tr>
					<th>报警通知时间段</th>
					<th>状态</th>
					<th>发送方式</th>
				</tr>
			</thead>
			<tbody>
				<#if alarmStrategyList??>
				<#list alarmStrategyList as x>
				<tr class="tb-tr">
					<td data-id="${x.alarmPeriodId!}">${x.alarmPeriodName!}</td>
					<td>${x.state!}</td>
					<td style="position:relative;">${x.sendMode!}<i class="u-icon u-icon-del del-temp" data-action="del"></i></td>
				</tr>
				</#list>
				</#if>
			</tbody>
		</table>
	</div>
	<div><span class="u-btn u-btn-c1" id="add-template">添加</span></div>
	<div class="u-btnfm">
		<span class="u-btn u-btn-s3" id="submit">提 交</span>
		<a class="u-btn u-btn-s4" href="javascript:history.go(-1)">取 消</a>
	</div>
</form>
</#macro>

<#macro jstTemplate>
<div style="display:none" id="jst-template">
	<#noparse>
	<textarea name="jst" id="jst-win-form-stategy">
		<form id="form-add" class="form">
			<h2 class="u-tt">基本信息</h2>
			<div class="m-form">
				<div class="fmitem">
					<label class="fmlab">&#12288;&#12288;<i>*</i>报警通知时间段：</label>
					<div class="fmcnt">
						<select name="alarmPeriodId">
							{if list}
							{list list as x}
							<option value="${x.id}">${x.name}</option>
							{/list}
							{/if}
						</select>
					</div>
				</div>
				<div class="fmitem">
					<label class="fmlab">&#12288;&#12288;<i>*</i>状态：</label>
					<div class="fmcnt fmbox">
						<input type="checkbox" name="state" value="critical"/><span>critical</span>
						<input type="checkbox" name="state" value="warning"/><span>warning</span>
						<input type="checkbox" name="state" value="error"/><span>error</span>
						<input type="checkbox" name="state" value="ok"/><span>ok</span>
					</div>
				</div>
				<div class="fmitem">
					<label class="fmlab">&#12288;&#12288;<i>*</i>发送方式：</label>
					<div class="fmcnt fmbox">
						<input type="checkbox" name="sendMode" value="popo"/><span>泡泡</span>
						<input type="checkbox" name="sendMode" value="email"/><span>邮件</span>
						<input type="checkbox" name="sendMode" value="yixin"/><span>易信</span>
						<input type="checkbox" name="sendMode" value="sms"/><span>短信</span>
						<input type="checkbox" name="sendMode" value="phone"/><span>电话</span>
					</div>
				</div>
			</div>
		</form>
	</textarea>
	<textarea name="jst" id="stategy-list">
	<table class="m-table m-table-t1" id="table">
		<thead>
			<tr>
				<th>报警通知时间段</th>
				<th>状态</th>
				<th>发送方式</th>
			</tr>
		</thead>
		<tbody>
			{if alarmStrategyList}
			{list alarmStrategyList as x}
			<tr class="tb-tr">
				<td data-id="${x.alarmPeriodId}">${x.alarmPeriodName}</td>
				<td>${x.state}</td>
				<td style="position:relative;">${x.sendMode}<i class="u-icon u-icon-del del-temp" data-action="del"></i></td>
			</tr>
			{/list}
			{/if}
		</tbody>
	</table>
	</textarea>
	</#noparse>
</div>
</#macro>
</#escape>