
<#if result??>

<p><div>  <font size="3" color="red">扫描信息: ${result.counter.toString()}  采用的索引信息:${result.scanIndex.toString()} </font></div></p>

<table border="1" class=" " contenteditable="false" style="white-space:nowrap;">
	<thead>
	
		<tr>
			<th >time</th>
			<th >hbase_time</th>
			<#list result.expressionList as expression>
	    		<th >${expression.as}</th>
	      	</#list>
   		</tr>
   	
	</thead>
	
	<tbody>
	
		<#list result.rowList as row>
		    <tr>
			    <td > ${row.getDateString()} </td>
			    <td > ${row.getHbaseTimeString()} </td>
			    <#list result.expressionList as expression>
			        <#assign rdata=row.getEntries()>
			        <#assign kk=expression.getAs()>
			        <#if rdata[kk]??>
			        	<#assign vob=rdata[kk]>
			        	<#if vob??>
				           <td >
				             <#if vob?is_date>
				                ${vob?string("yyyy-MM-dd HH:mm:ss")}
				             <#else>
				                ${vob!}
				             </#if>
	                       </td>
			             
				        <#else>
				             <td ></td>
				        </#if>
				        
				    <#else>
				        <td ></td>
			        </#if>
			        
			        
			    	
			    </#list>
		
		    </tr>
		    
		</#list>
	 
	</tbody>
</table>

</#if> 	