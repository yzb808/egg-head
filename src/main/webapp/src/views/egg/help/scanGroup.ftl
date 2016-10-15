<!DOCTYPE html>
<html>
<body>



<form class="well form-inline"  method="post">
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
  
  <input type="submit" name="event_submit_do_scan_raw" size="30" value="提交" onClick=""> 
</form>


<p><div>  <font size="3" color="red"><#if errorMessage??> ${errorMessage} </#if> </font></div></p>

<#include "../../common/config.ftl"/>





<#if result??>
    <p><div>  <font size="3" color="red">扫描信息: ${result.counter.toString()}  采用的索引信息:${result.scanIndex.toString()} </font></div></p>

	<div id="container" style=" height: 510; margin: 0 auto"></div>

	<#if viewType??> 
		<#if viewType == "sumtable">
		     <#include "sumtable.ftl" />
		<#elseif viewType == "trend" />
		     <#-- <#include "trend.ftl" /> -->
         <script>var dataString = ${dataString!}</script>
         <#noparse>
          <!-- @script {nodep:true,core:false} -->
          </#noparse>
          <script src="${jsLib}/define.js?pro=${jsCommon}&page=${jsPages}"></script>
          <script type="text/javascript" src="${jsCommon}/module/jquery.min.js"></script>
          <script type="text/javascript" src="${jsPages}/sentry/help/trend.js"></script>
		<#elseif viewType == "pie" />
		     <#include "pie.ftl" />
		<#else>
		                  未定义视图类型 ${viewType}
		</#if> 
	</#if>

</#if>

</body>
</html>