<!DOCTYPE html>
<html>
<body>



<form class="well form-inline"  method="post">
  master 地址
   
  <input id="masterIp" name="masterIp" type="text" class="text" value="${masterIp!}" style="width:150px;height:20px" >
  serviceTag
  <input id="serviceTag" name="serviceTag" type="text" class="text" value="${serviceTag!}" style="width:150px;height:20px" >
  								 
  collectorMd5
  <input id="collectorMd5" name="collectorMd5" type="text" class="text" value="${collectorMd5!}" style="width:150px;height:20px" >
  itemMd5
  <input id="itemMd5" name="itemMd5" type="text" class="text" value="${itemMd5!}" style="width:150px;height:20px" >
 

  <input type="submit" name="event_submit_do_scan_raw" size="30" value="提交" onClick="">
</form>


<p><div>  <font size="3" color="red">${errorMessage!} </font></div></p>

<p>数据返回</p>

<#if result??>
<p>isCollectorChanged:${result.isCollectorChanged!}</p>
<p>collectorMd5:${result.collectorMd5!}</p>
</#if>

<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
	 <thead>
	
		<tr>
			<th >collectorId</th>
			<th >collectorName</th>
			<th >isInternal</th>
			<th >isInner</th>
			<th >scriptName</th>
			<th >scriptType</th>
			<th >outputType</th>
			<th >arguments</th>
      		<th >modifyTime</th>
      		<th >scriptTxt</th>
   		</tr>
	</thead>
	
	
	
	<tbody>
	   <#if result??>
		   <#if result.collectorList??>
		       <#assign collectorList=result.getCollectorList() >
		       <#list collectorList as collector>
				   <tr>
				   	  <td>${collector.collectorId!}</td>
				   	  <td>${collector.collectorName!}</td>
				   	  <td>${collector.isInternal!}</td>
				   	  <td>${collector.isInner!}</td>
				   	  <td>${collector.scriptName!}</td>
				   	  <td>${collector.scriptType!}</td>
				   	  <td>${collector.outputType!}</td>
				   	  <td>${collector.arguments!}</td>
				   	  <td>${collector.modifyTime!}</td>
				   	  <td>${collector.scriptTxt!}</td>
				   </tr>
			   </#list>
		   </#if>
	   </#if>
	
	</tbody>
</table>

<#if result??>
<p>isItemChanged:${result.isItemChanged!}</p>
<p>itemMd5:${result.itemMd5!}</p>
</#if>
<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
	 <thead>
	
		<tr>
			<th >id</th>
			<th >hostId</th>
			<th >groupId</th>
			<th >domainId</th>
			<th >clusters</th>
			<th >monitorItemId</th>
			<th >collectorId</th>
			<th >collectorName</th>
			<th >isInner</th>
			<th >arguments</th>
      		<th >interval</th>
      		<th >rangeExpress</th>
      		<th >exeAccount</th>
      		<th >scriptName</th>
      		<th >timeout</th>
      		<th >attachment</th>
      		<th >md5</th>
   		</tr>
	</thead>
	
	
	
	<tbody>
	   <#if result??>
		   <#if result.monitorItemList??>
		       <#assign itemList=result.getMonitorItemList() >
		       <#list itemList as item>
				   <tr>
				      <td>${item.id!}</td>
				   	  <td>${item.hostId!}</td>
				   	  <td>${item.groupId!}</td>
				   	  <td>${item.domainId!}</td>
				   	  <td>${item.clusters!}</td>
				   	  <td>${item.monitorItemId!}</td>
				   	  <td>${item.collectorId!}</td>
				   	  <td>${item.collectorName!}</td>
				   	  <td>${item.isInner!}</td>
				   	  <td>${item.arguments!}</td>
				   	  <td>${item.interval!}</td>
				   	  <td>${item.rangeExpress!}</td>
				   	  <td>${item.exeAccount!}</td>
				   	  <td>${item.scriptName!}</td>
				   	  <td>${item.timeout!}</td>
				   	  <td>${item.attachment!}</td>
				   	  <td>${item.md5!}</td>
				   </tr>
			   </#list>
		   </#if>
	   </#if>
	
	</tbody>
</table>


</body>
</html>