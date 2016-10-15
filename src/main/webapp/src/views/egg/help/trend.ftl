
<script type="text/javascript">

Highcharts.setOptions({global:{useUTC : false}}
	);
	
$(function () {
$('#container').highcharts({
    chart: {
        type: 'spline'
    },
    title: {
        text: ''
    },
    subtitle: {
        text: '<b>${title!}</b>'
    },
    xAxis: {
        type: 'datetime'
        
    },
    yAxis: {
        title: {
            text: ' '
        },
        min: 0
    },
    tooltip: {
        formatter: function() {
                return '<b>'+ this.series.name +' '+this.y+'</b><br>'+
                Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) ;
        }
    },
    
    series: ${dataString!}
});
});


</script>



  

