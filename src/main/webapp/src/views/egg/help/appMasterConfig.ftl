<!DOCTYPE html>
<html>
<body>



<form class="well form-inline"  method="post">
  master 地址
   
  <input id="masterIp" name="masterIp" type="text" class="text" value="${masterIp!}" style="width:150px;height:20px" >
  appName
  <input id="appName" name="appName" type="text" class="text" value="${appName!}" style="width:150px;height:20px" >
  
  serviceTag
  <input id="serviceTag" name="serviceTag" type="text" class="text" value="${serviceTag!}" style="width:150px;height:20px" >
  
   clusterName
  <input id="clusterName" name="clusterName" type="text" class="text" value="${clusterName!}" style="width:150px;height:20px" >
  

 
itemMd5
  <input id="itemMd5" name="itemMd5" type="text" class="text" value="${itemMd5!}" style="width:150px;height:20px" >
  <input type="submit" name="event_submit_do_scan_raw" size="30" value="提交" onClick="">
</form>


<p><div>  <font size="3" color="red">${errorMessage!} </font></div></p>

<p>数据返回</p>


<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
	 <thead>
	
		<tr>
			<th >hostId</th>
			<th >domainId</th>
			<th >groupId</th>
			<th >clusterId</th>
			<th >monitorList</th>
			<th >itemMd5</th>
			<th >itemChanged</th>

   		</tr>
	</thead>
	
	
	
	<tbody>
	   
	   <#if result??>
	      
	       <tr>
			   	  <td>${result.hostId!}</td>
			   	  <td>${result.domainId!}</td>
			   	  <td>${result.groupId!}</td>
			   	  <td>${result.clusterId!}</td>
			   	   <#assign mlist=result.getMonitorListString()>
			   	  <td>${mlist!}</td>
			   	  <td>${result.itemMd5!}</td>
			   	  <td>${result.itemChanged?string('true','false')}</td>
			</tr>
			   
	   </#if>
	   
	
	</tbody>
</table>



<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
	 <thead>
	
		<tr>
			
			<th >monitorItemId</th>
			<th >collectorId</th>
			<th >collectorName</th>
			<th >interval</th>

   		</tr>
	</thead>
	
	
	
	<tbody>
	   <#if result??>
		   <#if result.monitorItemList??>
		       <#assign itemList=result.getMonitorItemList() >
		       <#list itemList as item>
				   <tr>
				   	  <td>${item.monitorItemId!}</td>
				   	  <td>${item.collectorId!}</td>
				   	  <td>${item.collectorName!}</td>
				   	  <td>${item.interval!}</td>
				   </tr>
			   </#list>
		   </#if>
	   </#if>
	
	</tbody>
</table>


</body>
</html>