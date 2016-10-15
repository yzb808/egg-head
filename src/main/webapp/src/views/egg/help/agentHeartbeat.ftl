<!DOCTYPE html>
<html>
<body>



<form class="well form-inline"  method="post">
  master 地址
   
  <input id="masterIp" name="masterIp" type="text" class="text" value="${masterIp!}" style="width:150px;height:20px" >
								 
  serviceTag
  <input id="serviceTag" name="serviceTag" type="text" class="text" value="${serviceTag!}" style="width:150px;height:20px" >
 

  <input type="submit" name="event_submit_do_scan_raw" size="30" value="提交" onClick="">
</form>


<p><div>  <font size="3" color="red">${errorMessage!} </font></div></p>

<p>数据返回</p>
<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
	 <thead>
	
		<tr>
			
			<th >hostId</th>
			<th >groupId</th>
			<th >clusters</th>
			<th >domainId</th>
			<th >domainName</th>
      		<th >monitorCount</th>
      		<th >monitorList</th>
   		</tr>
	</thead>
	
	
	
	<tbody>
	   
	   <#if result??>
		   <tr>
		   	  <td>${result.hostId!}</td>
		   	  <td>${result.groupId!}</td>
		   	  <td>${result.clusters!}</td>
		   	  <td>${result.domainId!}</td>
		   	  <td>${result.domainName!}</td>
		   	  <td>${result.monitorCount!}</td>
		   	  <#assign dd=result.getMonitorListString()>
		   	  <td>${dd}</td>
		   </tr>
	   </#if>
	   
	
	</tbody>
</table>



</body>
</html>