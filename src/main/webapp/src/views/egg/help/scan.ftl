<!DOCTYPE html>
<html>
<body>



<form class="well form-inline"  method="post">
  起始时间 
  <input id="startTime" name="startTime" type="text" class="text" value="${startTime!}" style="width:150px;height:20px" >

    
  对象ID
  <input id="objId" name="objId" type="text" class="text" value="${objId!}" style="width:150px;height:20px" >
  监控项ID
  <input id="monitorItemId" name="monitorItemId" type="text" class="text" value="${monitorItemId!}" style="width:150px;height:20px" >
  模型 
  <input id="modelName" name="modelName" type="text" class="text" value="${modelName!}" style="width:150px;height:20px" >
  
   扫描列  
  <input id="fields" name="fields" type="text" class="text" value="${fields!}" style="width:300px;height:20px">
  
  最多返回行数<input id="maxRows" name="maxRows" type="text" class="text" value="${maxRows!}" style="width:40px;height:20px">
  
  <br/><br/>
  
  
    结束时间  
  <input id="endTime" name="endTime" type="text" class="text" value="${endTime!}" style="width:150px;height:20px" >  
   过滤条件 
  <input id="enumFilter" name="enumFilter" type="text" value="${enumFilter!}" style="width:500px;height:20px" value=""  >  
  强制索引  
  <input id="forceIndex" name="forceIndex" type="text" class="text" value="${forceIndex!}" style="width:80px;height:20px" >  
  
  
 
  是否填充ENUM <select id="fillEnum" name="fillEnum"  class="select">
            <option value="true"  <#if fillEnum??> <#if fillEnum == "true"> selected </#if>  </#if> >是</option>
            <option value="false" <#if fillEnum??> <#if fillEnum == "false"> selected </#if>  </#if> >否</option>
      </select>
       
      <select id="hisType" name="hisType"  class="select">
            <option value="ORIGIN" <#if hisType??> <#if hisType == "ORIGIN"> selected </#if> </#if>  >原始数据</option>
            <option value="H1"     <#if hisType??> <#if hisType == "H1"> selected </#if> </#if> >小时归档数据</option>
            <option value="D1"     <#if hisType??> <#if hisType == "D1"> selected </#if> </#if>  >按天归档数据</option>
      </select>
  <input type="submit" name="event_submit_do_scan_raw" size="30" value="提交" onClick=""> 
</form>


<p><div>  <font size="3" color="red"><#if errorMessage??> ${errorMessage} </#if> </font></div></p>


<#if result??>
	<#include "sanResult.ftl" />
</#if>

</body>
</html>