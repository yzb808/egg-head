<!DOCTYPE html>
<html>
  
  <head>
    <title>Blue Moon - Responsive Admin Dashboard</title>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Blue Moon - Responsive Admin Dashboard" />
    <meta name="keywords" content="Notifications, Admin, Dashboard, Bootstrap3, Sass, transform, CSS3, HTML5, Web design, UI Design, Responsive Dashboard, Responsive Admin, Admin Theme, Best Admin UI, Bootstrap Theme, Wrapbootstrap, Bootstrap, bootstrap.gallery" />
    <meta name="author" content="Bootstrap Gallery" />
    <link rel="shortcut icon" href="img/favicon.ico">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/new.css" rel="stylesheet">
    <!-- Important. For Theming change primary-color variable in main.css -->
    <link href="fonts/font-awesome.min.css" rel="stylesheet">
    <!-- HTML5 shiv and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]--></head>
  
  <body>
    <!-- Header Start -->
    <header>
      <a href="index.html" class="logo">
        <img src="img/logo.png" alt="Logo" /></a>
      <div class="pull-right">
        <ul id="mini-nav" class="clearfix">
          <li class="list-box hidden-xs">
            <!-- Modal -->
            <div class="modal fade" id="modalMd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title text-danger" id="myModalLabel5">Coding Style</h4></div>
                  <div class="modal-body">
                    <img src="img/documentation.png" alt="Esquare Admin"></div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">
                      <i class="fa fa-times"></i>Close</button>
                  </div>
                </div>
              </div>
            </div>
          </li>
        </ul>
      </div>
    </header>
    <!-- Main Container start -->
    <div class="dashboard-container">
      <div class="container">
        <!-- Top Nav Start -->
        <div id='cssmenu'>
          <ul>
            <li class='active'>
              <a href='searchInput'>
                <i class="fa fa-table"></i>search</a>
            </li>
          </ul>
        </div>
        <!-- Top Nav End -->
        <!-- Dashboard Wrapper Start -->
        <div class="dashboard-wrapper">
          <!-- Left Sidebar Start -->
          <div class="left-sidebar">
            <!-- Row Start -->
            <div class="row">
              <div class="col-lg-12 col-md-12">
                <div class="widget no-margin">
                  <div class="widget-header">
                    <div class="title">灵玉消耗</div>
                    <span class="tools">
                      <i class="fa fa-cogs"></i>
                    </span>
                  </div>
                  <div class="widget-body">
                    <div class="row">
                      <div class="col-lg-2 col-md-4 col-sm-12 col-xs-12">
                        <hr>
                        <div class="thumbnail">
                          <img alt="270x180" src="img/role/${roleImgName!}.png" id="roleImg">
                          <br>
                          <h4 class="center-align-text">${roleImgName!}</h4></div>
                        <br></div>
                      <div class="col-lg-9 col-md-8 col-sm-12 col-xs-12">
                        <form class="form-horizontal">
                          <hr>
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">玩家ID</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              ${player.roleId!}</div>
                             <label class="col-sm-1 control-label" for="niki">昵称</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              ${player.roleName!}</div>
                          </div>
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="zbxl">装备洗练</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="zbxl"></span>
                                <text class="form-control" name="washEquipment" id="washEquipment" type="text" />${player.playerSpendLY.washEquipment!}</div></div>
                            <label class="col-sm-1 control-label" for="zbqh">装备强化</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="zbqh"></span>
                                <text class="form-control" name="wssStrong" id="wssStrong" type="text" />${player.playerSpendLY.wssStrong!}</div></div>
                          </div>
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="lsxl">灵兽洗练</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="lsxl"></span>
                                <text class="form-control" name="washAnimal" id="washAnimal" type="text" />${player.playerSpendLY.washAnimal!}</div></div>
                            <label class="col-sm-1 control-label" for="fbxl">法宝洗练</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="fbxl"></span>
                                <text class="form-control" name="washPrecious" id="washPrecious" type="text" />${player.playerSpendLY.washPrecious!}</div></div>
                          </div>
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="dhyb">兑换元宝</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="dhyb"></span>
                                <text class="form-control" name="goldIngot" id="goldIngot" type="text" />${player.playerSpendLY.goldIngot!}</div></div>
                            <label class="col-sm-1 control-label" for="hbff">红包发放</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="hbff"></span>
                                <text class="form-control" name="redPacket" id="redPacket" type="text" />${player.playerSpendLY.redPacket!}</div></div>
                          </div>
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="yzsh">一掌山河</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="yzsh"></span>
                                <text class="form-control" name="onHand" id="onHand" type="text" />${player.playerSpendLY.onHand!}</div></div>
                            <label class="col-sm-1 control-label" for="szgm">时装购买</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="szgm"></span>
                                <text class="form-control" name="clother" id="clother" type="text" />${player.playerSpendLY.clother!}</div></div>
                          </div>
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="djts">遁甲天书</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="djts"></span>
                                <text class="form-control" name="kaiShu" id="kaiShu" type="text" />${player.playerSpendLY.kaiShu!}</div></div>
                            <label class="col-sm-1 control-label" for="jbsj">交保释金</label>
                            <div class="col-lg-5">
                              <div class="input-group">
                                <span class="input-group-addon">
                                  <input type="checkbox" id="jbsj"></span>
                                <text class="form-control" name="baoShiJin" id="baoShiJin" type="text" />${player.playerSpendLY.baoShiJin!}</div></div>
                          </div>
                          <div class="form-group">
                            <div class="col-sm-11"></div>
                            <div class="col-sm-1">
                              <a class="btn btn-info" data-toggle="modal" data-target="#myModal">提交</a>
                              <!-- 模态框（Modal） -->
                              <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                  <div class="modal-content">
                                    <div class="modal-body">
                                      <div id="content">
                                        <div id="container"></div>
                                      </div>
                                    </div>
                                  </div>
                                  <!-- /.modal-content --></div>
                                <!-- /.modal --></div>
                            </div>
                          </div>
                          <hr>
                          <div class="form-group">
                            <div class="col-sm-6"></div>
                            <div class="col-sm-6">
                              <a href="javascript:playerInfo();" class="btn btn-info">返回人物信息</a></div>
                          </div>
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- Row End --></div>
          <!-- Left Sidebar End --></div>
        <!-- Dashboard Wrapper End -->
        <footer>
          <p>© egg head 2016</p>
        </footer>
      </div>
    </div>
    <!-- Main Container end -->
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.js"></script>
    <script src="js/highcharts.js"></script>
    <script src="js/highcharts-3d.js"></script>
    <script src="js/exporting.js"></script>
    <!-- Custom JS -->
    <script src="js/menu.js"></script>
    <script type="text/javascript">//ScrollUp
      $(function() {
        $.scrollUp({
          scrollName: 'scrollUp',
          // Element ID
          topDistance: '300',
          // Distance from top before showing element (px)
          topSpeed: 300,
          // Speed back to top (ms)
          animation: 'fade',
          // Fade, slide, none
          animationInSpeed: 400,
          // Animation in speed (ms)
          animationOutSpeed: 400,
          // Animation out speed (ms)
          scrollText: 'Top',
          // Text for element
          activeOverlay: false,
          // Set CSS color to display scrollUp active point, e.g '#00FFFF'
        });
      });

      //Tooltip
      $('a').tooltip('hide');

      //Popover
      $('.popover-pop').popover('hide');

      //Dropdown
      $('.dropdown-toggle').dropdown();

      function playerInfo() {
        var reg = new RegExp("(^|&)" + "id" + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) window.location.href = "player?id=" + r[2];
      }

      var data = [{
          name: 'Jane',
          data: [["一",50.5], ["二",40.8], 64.5,100,10,88,75]
      }];
      //绘图数据
      var option = {
        chart: {
          renderTo: 'container',
          type: 'line',
          zoomType: "xy" //用鼠标选中一段区域，可对该区域进行
        },
        title: {
          text: "五周数据"
        },
        xAxis: {
          categories: ['一', '二', '三', '四', '五(本周)'],
          tickWidth: 1,
          //刻度的宽度  
          lineWidth: 1,
          //自定义x轴宽度
          gridLineWidth: 1
        },
        yAxis: {
          title: {
            text: 'value'
          }
        },
        credits: {
          enabled: false
        },
        plotOptions: {
          column: {
            pointPadding: 0,
            borderWidth: 0
          },
          pie: {
            allowPointSelect: true,
            //选中某块区域是否允许分离
            cursor: 'pointer',
            dataLabels: {
              enabled: false //是否直接呈现数据 也就是外围显示数据与否
            },
            depth: 35,
            showInLegend: true
          }
        },
        series: data,
        tooltip: {
          enabled: true
        },
        dataLabels: {
          enabled: true,
          formatter: function() {
            return Highcharts.numberFormat(this.y / 1000, 0, ',') + 'k';
          },
          style: {
            color: '#FFFFFF',
            fontWeight: 'bold',
            textShadow: '0px 0px 3px black'
          }
        },
        pointPadding: 0
      }

      $(function() {
        console.log(option);
      });

      //图片对象
      var chartObj;

      //绘制图表方法，每次绘制完成后，将绘制的图标存入变量chartObj
      var drawImage = function() {
        chartObj = new Highcharts.Chart(option);
      }

      $('#myModal').on('shown.bs.modal',
      function() {
        var spCodesTemp = 'nothing';
        $('input:checkbox[type=checkbox]:checked').each(function(i){
          if (0 == i) {
            spCodesTemp = $(this).attr("id");
          } else {
            spCodesTemp += (","+$(this).attr("id"));
          }
        });
        console.log(spCodesTemp);

        if (spCodesTemp == 'nothing') {
          alert('未选择任何条目');
        } else {
          var reg = new RegExp("(^|&)" + "id" + "=([^&]*)(&|$)", "i");
          var r = window.location.search.substr(1).match(reg);

          $.post('/api/recommend?playerId=' + r[2], {select:spCodesTemp}, function(dataAjax) {
            // var seriesData;
            // option.series = seriesData;
            // for(var i = 0; i < data.data.length; i++){
            //   option.series[i].data = data.data[i];
            //   console.log(data.data[i]);
            // }
            console.log(dataAjax.data);
            console.log(data);
            option.series = dataAjax.data;
            drawImage();
          });
        }
        
      })

      </script>
  </body>

</html>