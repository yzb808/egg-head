


<form id="hide-form" class="well form-inline"  method="post" target="_blank" onsubmit="return false" style="display:none">
  起始时间 
  <input id="startTime" name="startTime" type="text" class="text" value="${startTime!}" style="width:130px;height:20px" >

    
  对象ID
  <input id="objId" name="objId" type="text" class="text" value="${objId!}" style="width:100px;height:20px" >
  监控项ID
  <input id="monitorItemId" name="monitorItemId" type="text" class="text" value="${monitorItemId!}" style="width:100px;height:20px" >
  模型 
  <input id="modelName" name="modelName" type="text" class="text" value="${modelName!}" style="width:150px;height:20px" >
  
聚合函数 
  <input id="functionExpression" name="functionExpression" type="text" class="text" value="${functionExpression!}" style="width:600px;height:20px">
  
  
  <br/><br/>
  
  
    结束时间  
  <input id="endTime" name="endTime" type="text" class="text" value="${endTime!}" style="width:130px;height:20px" >  
   过滤条件 
  <input id="enumFilter" name="enumFilter" type="text" value="${enumFilter!}" style="width:400px;height:20px" value=""  >  
分组
  <input id="groupby" name="groupby" type="text" value="${groupby!}" style="width:300px;height:20px" value=""  > 
时间间隔
  <input id="interval" name="interval" type="text" value="${interval!}" style="width:50px;height:20px" value=""  >
   
   
    <br/><br/>
  强制索引  
  <input id="forceIndex" name="forceIndex" type="text" class="text" value="${forceIndex!}" style="width:80px;height:20px" >  
  
  
 
  填充ENUM <select id="fillEnum" name="fillEnum"  class="select">
            <option value="true"  <#if fillEnum??> <#if fillEnum == "true"> selected </#if>  </#if> >是</option>
            <option value="false" <#if fillEnum??> <#if fillEnum == "false"> selected </#if>  </#if> >否</option>
      </select>
       
      
      
      自动模型转化
      <select id="autoModelTransform" name="autoModelTransform"  class="select">
            <option value="false" <#if autoModelTransform??> <#if autoModelTransform == "false"> selected </#if> </#if>  >否</option>
            <option value="true"     <#if autoModelTransform??> <#if autoModelTransform == "true"> selected </#if> </#if> >是</option>
           
      </select>
      
  limit
        <input id="limit" name="limit" type="text" class="text" value="${limit!}" style="width:30px;height:20px" >
  order by
       <input id="orderby" name="orderby" type="text" class="text" value="${orderby!}" style="width:100px;height:20px" >

 数据源      
       <select id="hisType" name="hisType"  class="select">
            <option value="ORIGIN" <#if hisType??> <#if hisType == "ORIGIN"> selected </#if> </#if>  >原始数据</option>
            <option value="H1"     <#if hisType??> <#if hisType == "H1"> selected </#if> </#if> >小时归档数据</option>
            <option value="D1"     <#if hisType??> <#if hisType == "D1"> selected </#if> </#if>  >按天归档数据</option>
      </select>
 视图类型
       <select id="viewType" name="viewType"  class="select">
            <option value="sumtable"    <#if viewType??> <#if viewType == "sumtable"> selected </#if> </#if>  >汇总表格</option>
            <option value="trend"     <#if viewType??> <#if viewType == "trend"> selected </#if> </#if> >趋势图</option>
            <option value="pie"     <#if viewType??> <#if viewType == "pie"> selected </#if> </#if> >饼状图</option>
           
      </select>
      主标题  
  <input id="title" name="title" type="text" class="text" value="${title!}" style="width:180px;height:20px" >
  
  <input id="sourceFrom" name="sourceFrom" value="sumtable">  
  <input id="groupbyFilterString" name="groupbyFilterString" value="">  
  
  <input type="submit" name="event_submit_do_scan_raw" size="30" value="提交" onClick=""> 
</form>




<script type="text/javascript">
  function submitForm(groupbyFilter,funcExp)
  {

    var hidenform=document.getElementById("hide-form");
    
    var groupbyFilterString = hidenform['groupbyFilterString'];
    
    groupbyFilterString.value=groupbyFilter;

    
    var functionExpression = hidenform['functionExpression'];
    
    functionExpression.value=funcExp;

    
    var viewType = hidenform['viewType'];
    viewType.value="trend";

    var groupby = hidenform['groupby'];
    
    groupby.value="";
    
    hidenform.submit();
  
  }
      

</script>




<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
	<thead>
	
		<tr>
			<th >time</th>

			
				<#list result.groupByExpressionList as groupbyExpression>
	    			<th >${groupbyExpression.as}</th>
	      		</#list>
	      		
	      		<#list result.functionExpressionList as functionExpression>
	    			<th >${functionExpression.as}</th>
	      		</#list>
      		
   		</tr>
   	
	</thead>
	
	<tbody>
	
		<#list result.timeRangeRowList as row>
		    <#assign rowdataList=row.getMonitorItemRowList()>
		    
			<#if rowdataList?size==0>
			    <tr>
				    <td> ${row.getTimeRange()} </td>
				    <#list result.groupByExpressionList as groupbyExpression>
		    				<td> </td>
		      		</#list>
		      		<#list result.functionExpressionList as functionExpression>
		    				<td>  </td>
		      		</#list>
	      		</tr>
			<#else>
				<#list rowdataList as dmap>
			        <tr>
	        	    <#if dmap_index==0>
				    	<td rowspan="${rowdataList?size}" > ${row.getTimeRange()} </td>
				    </#if>
				    
				    <#assign gstring="" />
				    
				    <#list result.groupByExpressionList as groupbyExpression>
	    				<td> ${dmap[groupbyExpression.as]!}</td>
	    				<#if groupbyExpression_index==0>
	    					<#assign gstring= groupbyExpression.field.name+"=" +dmap[groupbyExpression.as] />
	    				<#else>    
	    					<#assign gstring= gstring + "^"+groupbyExpression.field.name+"=" +dmap[groupbyExpression.as] />
	    				</#if>
	      		    </#list>
	      		    
	      		    
	      		    
	      		    <#list result.functionExpressionList as functionExpression>
	      		       <#assign fstring=functionExpression.toString()  />
	    				<td> <a href="javascript:void(0)" onClick="submitForm('${gstring}','${fstring}')"> ${dmap[functionExpression.as]!} </a></td>
	      			</#list>
				    </tr>
		    	</#list>
			</#if>
		    
		</#list>
	 
	</tbody>
</table>

