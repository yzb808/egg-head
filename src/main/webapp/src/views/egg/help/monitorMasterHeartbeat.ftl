<!DOCTYPE html>
<html>
<body>



<form class="well form-inline"  method="post">
  master 地址
   
  <input id="masterIp" name="masterIp" type="text" class="text" value="${masterIp!}" style="width:150px;height:20px" >

  sn
  <input id="sn" name="sn" type="text" class="text" value="${sn!}" style="width:150px;height:20px" >

  hostName
  <input id="hostName" name="hostName" type="text" class="text" value="${hostName!}" style="width:150px;height:20px" >
 

  <input type="submit" name="event_submit_do_scan_raw" size="30" value="提交" onClick="">
</form>


<p><div>  <font size="3" color="red">${errorMessage!} </font></div></p>

<p>数据返回</p>


<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
	 <thead>
	
		<tr>
			<th >hostId</th>
			<th >groupId</th>
			<th >groupName</th>
			<th >domainId</th>
			<th >domainName</th>
			<th >clusterId</th>
			<th >clusterName</th>
	</thead>

	<tbody>
	   
	   <#if result??>
	      
	       <tr>
			   	  <td>${result.hostId!}</td>
			   	  <td>${result.groupId!}</td>
			   	  <td>${result.groupName!}</td>
			   	  <td>${result.domainId!}</td>
			   	  <td>${result.domainName!}</td>
			   	  <td>${result.clusterId!}</td>
			   	  <td>${result.clusterName!}</td>
			</tr>
			   
	   </#if>
	   
	
	</tbody>
</table>

<p>私网IP:</p>

<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
<#if result??>
	<#if result.analyserGroup1??>
		<tbody>
			<tr>
				<#list result.analyserGroup1 as analyser>
					<td>${analyser!}</td>
					</#list>
				</tr>
		</tbody>
	</#if>
</#if>
</table>

<p>公网IP:</p>

<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
<#if result??>
	<#if result.analyserGroup2??>
		<tbody>
			<tr>
				<#list result.analyserGroup2 as analyser>
					<td>${analyser!}</td>
					</#list>
				</tr>
		</tbody>
	</#if>
</#if>



</body>
</html>