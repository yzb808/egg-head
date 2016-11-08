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
    <!-- Important. For Theming change primary-color variable in main.css  -->

    <link href="fonts/font-awesome.min.css" rel="stylesheet">

    <!-- HTML5 shiv and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
  </head>

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
          <li class="list-box dropdown">
            <a id="drop5" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-film"></i>
            </a>
            <span class="info-label info-bg">9+</span>
            <ul class="dropdown-menu stats-widget clearfix">
              <li>
                <h5 class="text-success">$37895</h5>
                <p>Revenue
                  <span class="text-success">+2%</span></p>
                <div class="progress progress-mini">
                  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                    <span class="sr-only">40% Complete (success)</span></div>
                </div>
              </li>
              <li>
                <h5 class="text-warning">47,892</h5>
                <p>Downloads
                  <span class="text-warning">+39%</span></p>
                <div class="progress progress-mini">
                  <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                    <span class="sr-only">40% Complete (warning)</span></div>
                </div>
              </li>
              <li>
                <h5 class="text-danger">28214</h5>
                <p>Uploads
                  <span class="text-danger">-7%</span></p>
                <div class="progress progress-mini">
                  <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                    <span class="sr-only">40% Complete (danger)</span></div>
                </div>
              </li>
            </ul>
          </li>
          <li class="list-box dropdown">
            <a id="drop5" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-calendar"></i>
            </a>
            <span class="info-label success-bg">6</span>
            <ul class="dropdown-menu server-activity">
              <li>
                <p>
                  <i class="fa fa-flag text-info"></i>Pending request
                  <span class="time">3 hrs</span></p>
              </li>
              <li>
                <p>
                  <i class="fa fa-fire text-warning"></i>Server Crashed
                  <span class="time">3mins</span></p>
              </li>
              <li>
                <p>
                  <i class="fa fa-user text-success"></i>3 New users
                  <span class="time">1 min</span></p>
              </li>
              <li>
                <p>
                  <i class="fa fa-bell text-danger"></i>9 pending requests
                  <span class="time">5 min</span></p>
              </li>
              <li>
                <p>
                  <i class="fa fa-plane text-info"></i>Performance
                  <span class="time">25 min</span></p>
              </li>
              <li>
                <p>
                  <i class="fa fa-envelope text-warning"></i>12 new emails
                  <span class="time">25 min</span></p>
              </li>
              <li>
                <p>
                  <i class="fa fa-cog icon-spin text-success"></i>Location settings
                  <span class="time">4 hrs</span></p>
              </li>
            </ul>
          </li>
          <li class="list-box user-profile">
            <a id="drop7" href="#" role="button" class="dropdown-toggle user-avtar" data-toggle="dropdown">
              <img src="img/user5.png" alt="Bluemoon User"></a>
            <ul class="dropdown-menu server-activity">
              <li>
                <p>
                  <i class="fa fa-cog text-info"></i>Account Settings</p>
              </li>
              <li>
                <p>
                  <i class="fa fa-fire text-warning"></i>Payment Details</p>
              </li>
              <li>
                <div class="demo-btn-group clearfix">
                  <a href="#" data-original-title="" title="">
                    <i class="fa fa-facebook fa-lg icon-rounded info-bg"></i>
                  </a>
                  <a href="#" data-original-title="" title="">
                    <i class="fa fa-twitter fa-lg icon-rounded twitter-bg"></i>
                  </a>
                  <a href="#" data-original-title="" title="">
                    <i class="fa fa-linkedin fa-lg icon-rounded linkedin-bg"></i>
                  </a>
                  <a href="#" data-original-title="" title="">
                    <i class="fa fa-pinterest fa-lg icon-rounded danger-bg"></i>
                  </a>
                  <a href="#" data-original-title="" title="">
                    <i class="fa fa-google-plus fa-lg icon-rounded success-bg"></i>
                  </a>
                </div>
              </li>
              <li>
                <div class="demo-btn-group clearfix">
                  <button href="#" class="btn btn-danger">Logout</button></div>
              </li>
            </ul>
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
              <a href='searchInput'><i class="fa fa-table"></i>search</a>
            </li>
            <li class=''>
              <a href='#'><i class="fa fa-dashboard"></i>Extras</a>
              <ul>
                <li><a href='#'>Blog</a>
                  <ul>
                    <li><a href='blog.html'>Blog</a></li>
                    <li><a href='blog-full-page.html'>Blog Full Page</a></li>
                  </ul>
                </li>
                <li><a href='edit-profile.html'>Edit Profile</a></li>
                <li><a href='invoice.html'>Invoice</a></li>
                <li><a href='default.html'>default</a></li>
                <li><a href='#'>Submenu</a>
                  <ul>
                    <li><a href='#'>Sub Product</a></li>
                    <li><a href='#'>Sub Product</a></li>
                    <li><a href='#'>Sub Product</a></li>
                  </ul>
                </li>
                <li><a href='login.html'>Login</a></li>
                <li><a href='help.html'>Help</a></li>
                <li><a href='404.html'>404</a></li>
                <li><a href='500.html'>500</a></li>
              </ul>
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
                    <div class="title">
                      玩家信息
                    </div>
                    <span class="tools">
                      <i class="fa fa-cogs"></i>
                    </span>
                  </div>
                  <div class="widget-body">
                    <div class="row">
                      <div class="col-lg-3 col-md-4 col-sm-12 col-xs-12">
                        <div class="thumbnail">
                          <img alt="270x180" src="img/profile.png">
                          <br>
                          <h4 class="center-align-text">UI Designer</h4>
                        
                        </div>
                        <br>
                      </div>
                      <div class="col-lg-9 col-md-8 col-sm-12 col-xs-12">
                        <form class="form-horizontal">
                          <h5>
                            Login Information
                          </h5>
                          <hr>
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">账号</label>
                            <div class="col-sm-11">
                              <text class="form-control" name="player_id" id="player_id" type="text" placeholder="id" />
                              ${player.account!}</div>
                          </div>
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">玩家ID</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              ${player.roleId!}</div>
                             <label class="col-sm-1 control-label" for="server">昵称</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              ${player.roleName!}</div>
                          </div>

                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="server">服务器</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              ${player.serverId!}</div>
                            <label class="col-sm-1 control-label" for="player_id">VIP等级</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              ${player.vipLevel!}</div>
                          </div>

                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">创建时间</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              ${player.createTime?datetime}
                              </div>
                            <label class="col-sm-1 control-label" for="server">在线时长</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              </div>
                          </div>
                          
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">门派</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              </div>
                            <label class="col-sm-1 control-label" for="server">等级</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              </div>
                          </div>

                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">专属</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              ${player.manager!}</div>
                            <label class="col-sm-1 control-label" for="server">微信</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              </div>
                          </div>
                          
                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">专属日期</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              </div>
                            <label class="col-sm-1 control-label" for="server">样本周期</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              </div>
                          </div>

                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">性别</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              ${player.sex!}</div>
                            <label class="col-sm-1 control-label" for="server">手机</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              </div>
                          </div>

                          <div class="form-group">
                            <label class="col-sm-1 control-label" for="player_id">婚姻</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="player_id" id="player_id" type="text" />
                              </div>
                            <label class="col-sm-1 control-label" for="server">师徒</label>
                            <div class="col-sm-5">
                              <text class="form-control" name="server" id="server" type="text" />
                              </div>
                          </div>

                          <br />
                          <div class="col-sm-2">
                            <a href="javascript:lingYu();" class="btn btn-info">灵玉消耗</a>
                          </div>
                          <hr>
                          
                        </form>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!-- Row End -->

          </div>
          <!-- Left Sidebar End -->

        </div>
        <!-- Dashboard Wrapper End -->

        <footer>
          <p>© BlueMoon 2013-14</p>
        </footer>

      </div>
    </div>
    <!-- Main Container end -->

    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.js"></script>

    <!-- Custom JS -->
    <script src="js/menu.js"></script>
    
    <script type="text/javascript">
      //ScrollUp
      $(function () {
        $.scrollUp({
          scrollName: 'scrollUp', // Element ID
          topDistance: '300', // Distance from top before showing element (px)
          topSpeed: 300, // Speed back to top (ms)
          animation: 'fade', // Fade, slide, none
          animationInSpeed: 400, // Animation in speed (ms)
          animationOutSpeed: 400, // Animation out speed (ms)
          scrollText: 'Top', // Text for element
          activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
        });
      });

      //Tooltip
      $('a').tooltip('hide');

      //Popover
      $('.popover-pop').popover('hide');

      //Dropdown
      $('.dropdown-toggle').dropdown();

      function lingYu() {
        var reg = new RegExp("(^|&)" + "id" + "=([^&]*)(&|$)","i");
        var r = window.location.search.substr(1).match(reg);
        if (r!=null) 
          window.location.href="playerLY?id=" + r[2];
      }

    </script>

  </body>
</html>