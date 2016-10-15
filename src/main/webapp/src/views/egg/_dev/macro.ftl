<#escape x as x!""?html>
<#include "/common/config.ftl"/>
<#include "/common/function.ftl"/>
<#-- 分页 -->
<#include "/common/pagination.ftl"/>
<#-- head -->
<#macro head title='哨兵系统'>
<title>${title}</title>
<meta charset="utf-8"/>
<meta name="keywords" content=""/>
<meta name="description" content=""/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="shortcut icon" href="/src/public/images/sentry.ico">
<#nested/>
</#macro>
<#-- 头部导航 -->
<#macro nav index=0>
<a href="javascript:;"><h1 class="m-logo">哨兵系统</h1></a>
<div class="m-nav">
  <ul>
    <li<#if index==0> class="z-act"</#if>>
      <b>我的产品<i class="u-icon u-icon-nav"></i></b>
      <div class="menu">
        <a href="/sentry/status/personSummary">我的监控</a>
        <a href="/sentry/alarm/event?onlyShowOwner=1">监控事件</a>
      </div>
    </li>
    <li<#if index==1> class="z-act"</#if>><a href="/sentry/appMonitor/view?clusterId=-1&sign=1">产品监控</a></li>
    <#-- <li<#if index==1 && (RequestParameters.sign?? && RequestParameters.sign == '1')> class="z-act"</#if>><a href="/sentry/appMonitor/view?clusterId=-1&sign=1">产品监控</a></li> -->
    <li<#if index==2> class="z-act"</#if>>
      <b>监控配置<i class="u-icon u-icon-nav"></i></b>
      <div class="menu">
        <a href="/sentry/collector/list">采集器</a>
        <a href="/sentry/monitor/list?clusterId=0">基础监控管理</a>
        <a href="/sentry/alarm/template">报警发送模板</a>
        <a href="/sentry/receiver/group/list">报警联系人组</a>
      </div>
    </li>
    <li<#if index==3> class="z-act"</#if>>
      <b>系统管理<i class="u-icon u-icon-nav"></i></b>
      <div class="menu">
        <a href="/sentry/tag/list">图表标签管理</a>
        <a href="/sentry/help/statistic">UV统计</a>
      </div>
    </li>
    <li<#if index==4> class="z-act"</#if>>
      <b>帮助<i class="u-icon u-icon-nav"></i></b>
      <div class="menu">
        <a href="http://doc.hz.netease.com/pages/viewpage.action?pageId=46878771" target="_blank">联系我们</a>
        <a href="http://doc.hz.netease.com/pages/viewpage.action?pageId=42560668" target="_blank">哨兵系统帮助</a>
        <a href="http://doc.hz.netease.com/pages/viewpage.action?pageId=46878755" target="_blank">CMDB帮助</a>
        <a href="/sentry/help/guide">新功能指引</a>
      </div>
    </li>
  </ul>
</div>
<div class="m-tbar">
  <span class="u-iptsearch u-iptsearch-1 f-fl"><input type="text" class="u-ipt" placeholder="请输入ip、主机名、别名、sn搜索" id="search-all" autocomplete="off"></span>
  <#-- <span class="popo f-fl">
    <span>值班popo：grp.hzdevops@corp.netease.com</span>
  </span> -->
  <span class="user">
    <i></i><b>您好，${(Session.user.userName)!}</b>
  </span>
  <a href="javascript:;" id="user-setting">设置</a>
  <a href="/logout/">安全退出</a>
</div>
</#macro>
<#-- 右侧菜单 -->
<#macro menu index=0>
  <div id="nav-right">
     <ul>
         <li <#if index==0>class="active"</#if>>
            <a href="javascript:;" class="durl" data-url="/sentry/appMonitor/view?clusterId=${RequestParameters.clusterId}"><i class="u-bg u-bg-1"></i><p>视图</p></a>
         </li>
         <li <#if index==1>class="active"</#if>>
            <a href="javascript:;" class="durl link-status" data-url="/sentry/status?clusterId=${RequestParameters.clusterId}&status=all"><i class="u-bg u-bg-2"></i><p>状态</p></a>
         </li>
         <li <#if index==2>class="active"</#if>>
            <a href="javascript:;" class="durl" data-url="/sentry/monitor/list?clusterId=${RequestParameters.clusterId}"><i class="u-bg u-bg-3"></i><p>配置</p></a>
         </li>
         <li <#if index==3>class="active"</#if>>
            <a href="javascript:;" class="durl" data-url="/sentry/alarm/history?clusterId=${RequestParameters.clusterId}"><i class="u-bg u-bg-4"></i><p>报警</p></a>
         </li>
     </ul>
  </div>
</#macro>
<#-- 左侧树 -->
<#macro sidenav tree index=-1>
<#if tree??>
<#list tree as x> <#-- 分级展现 -->
    <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == x.id?number)>
        <#local divisionId = x.id />
    </#if>
    <#if x.product??>
        <#list x.product as xx>
            <#if (RequestParameters.productId)?? && (RequestParameters.productId?number == xx.id?number)>
                <#local divisionId = x.id />
                <#local productId = xx.id />
            </#if>
            <#if xx.application??>
                <#list xx.application as xxx>
                <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxx.id?number)>
                    <#local divisionId = x.id />
                    <#local productId = xx.id />
                    <#local applicationId = xxx.id />
                </#if>
                <#if xxx.cluster??>
                  <#list xxx.cluster as xxxx>
                  <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>
                      <#local divisionId = x.id />
                      <#local productId = xx.id />
                      <#local applicationId = xxx.id />
                      <#local clusterId = xxxx.id />
                  </#if>
                </#list>
              </#if>
              </#list>
            </#if>
        </#list>
    </#if>
</#list>  
</#if>
<input type="hidden" value="<#if RequestParameters.show??>0<#else>1</#if>" id="showflag">
<input type="hidden" value="<#if RequestParameters.show??>${RequestParameters.sign}<#else>1</#if>" id="signflag">
<div class="m-sidenav">
  <ul class="tab" id="tabForMyOrAll">
    <#assign sign=RequestParameters.sign!"1">
    <#if !(user.external)>
    <li data-sign="0" <#if sign=='0'>class="z-act"</#if>>我的产品</li>
    <li data-sign="1" <#if sign=='1'>class="z-act"</#if>>全部产品</li>
    <#else>
    <#assign sign="0">
    <li data-sign="0" class="z-act" <#if sign=='0'>class="z-act"</#if>>我的产品</li>
    </#if>
  </ul>
  <div class="cnt">
    <div class="search" id="product-search" <#if sign=='0'>style="display:none;"</#if>>
      <form onsubmit="return false"><div class="u-iptsearch u-iptsearch-1"><input type="text" class="u-ipt" id="search-product" placeholder="按产品、应用、集群名称查找"></div></form>
    </div>
    <div class="nav" id="sidenav" <#if sign=='0'>style="top:10px;"</#if>>
      <ul class="lv1 my" <#if sign!='0'>style="display:none;"</#if>>
        <#if (my?? && my?size>0)>
        <li>
          <ul class="lv2">
            <#list my as x>
            <#if x??>
              <li class="j-item <#if divisionId??><#if divisionId?number == x.id?number>z-open</#if></#if> <#if x_index==0>act-item</#if>">
                <h2 <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == x.id?number)>class="z-act"</#if>>
                    <a href="javascript:;">
                      <i class="u-icon u-icon-business" title="事业部"></i>
                      ${x.title}
                    </a>
                    <i class="j-toggle"></i>
                </h2>
                <ul class="lv3">
                  <#if x.product??>
                  <#list x.product as xx>
                  <li class="j-item <#if productId??><#if productId?number == xx.id?number>z-open</#if></#if>">
                    <h3 data-id="${xx.id}" data-action="${xx.isPub}" <#if (RequestParameters.productId)?? && (RequestParameters.productId?number == xx.id?number)>class="z-act"</#if>>
                      <a href="javascript:;">
                        <i class="u-icon <#if (RequestParameters.productId)?? && (RequestParameters.productId?number == xx.id?number)>u-icon-act-pro<#else>u-icon-pro</#if>" title="产品"></i>
                        ${xx.title}<#if xx.isPub?? && xx.isPub == 1><span class="u-icon u-icon-lock" style="margin-left:5px;"></span></#if></a><i class="j-toggle"></i>
                    </h3>
                    <ul class="lv4">
                      <#if xx.application??>
                      <#list xx.application as xxx>
                      <li class="j-item <#if applicationId??><#if applicationId?number == xxx.id?number>z-open</#if></#if>">
                        <h4 <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxx.id?number)>class="z-act"</#if>>
                          <a href="javascript:;">
                          <i class="u-icon u-icon-app" title="应用"></i>
                            ${xxx.title}</a><i class="j-toggle"></i>
                        </h4>
                        <ul class="lv5">
                          <#if xxx.cluster??>
                          <#list xxx.cluster as xxxx>
                          <li class="j-item <#if clusterId??><#if clusterId?number == xxxx.id?number>z-open</#if></#if>">
                            <h5 <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>class="z-act"</#if>>
                              <#if index=1>
                              <a href="/sentry/status?clusterId=${xxxx.id}&sign=0&status=all" title="${xxxx.title}"><i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>${xxxx.title}</a>
                              <#elseif index=2>
                              <a href="/sentry/monitor/list?clusterId=${xxxx.id}&sign=0" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#elseif index=3>
                              <a href="/sentry/alarm?clusterId=${xxxx.id}&sign=0" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#elseif index=4>
                              <a href="/sentry/alarm/history?clusterId=${xxxx.id}&sign=0" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#elseif index=5>
                              <a href="/sentry/alarm/cluster?clusterId=${xxxx.id}&sign=0" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#elseif index=6>
                              <a href="/sentry/status/cluster?clusterId=${xxxx.id}&sign=0" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#else>
                              <a href="/sentry/appMonitor/view?clusterId=${xxxx.id}&sign=0" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              </#if>
                            </h5>
                          </li> 
                          </#list>
                          </#if>
                        </ul>
                      </li> 
                      </#list>
                      </#if>
                    </ul>
                  </li> 
                  </#list>
                  </#if>
                </ul>
              </li>
            </#if>
            </#list>
          </ul>
        </li>
        <#else>
        <p class="no-product">您还没有产品,请点击<a href="http://cmdb.netease.com" style="color:#c33;">这里</a>创建产品。</p>
        </#if>
      </ul>
      <ul class="lv1 all" <#if sign!='1'>style="display:none;"</#if>>
        <li>
          <ul class="lv2">
            <#list tree as x>
            <#if x??>
              <li class="j-item <#if divisionId??><#if divisionId?number == x.id?number>z-open</#if></#if> <#if x_index==0>act-item</#if>">
                <h2 <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == x.id?number)>class="z-act"</#if>>
                    <a href="javascript:;">
                      <i class="u-icon u-icon-business" title="事业部"></i>
                      ${x.title}
                    </a>
                    <i class="j-toggle"></i>
                </h2>
                <ul class="lv3">
                  <#if x.product??>
                  <#list x.product as xx>
                  <li class="j-item <#if productId??><#if productId?number == xx.id?number>z-open</#if></#if>">
                    <h3 data-id="${xx.id}" data-action="${xx.isPub}" <#if (RequestParameters.productId)?? && (RequestParameters.productId?number == xx.id?number)>class="z-act"</#if>>
                      <a href="javascript:;">
                        <i class="u-icon <#if (RequestParameters.productId)?? && (RequestParameters.productId?number == xx.id?number)>u-icon-act-pro<#else>u-icon-pro</#if>" title="产品"></i>
                        ${xx.title}<#if xx.isPub?? && xx.isPub == 1><span class="u-icon u-icon-lock" style="margin-left:5px;"></span></#if></a><i class="j-toggle"></i>
                    </h3>
                    <ul class="lv4">
                      <#if xx.application??>
                      <#list xx.application as xxx>
                      <li class="j-item <#if applicationId??><#if applicationId?number == xxx.id?number>z-open</#if></#if>">
                        <h4 <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxx.id?number)>class="z-act"</#if>>
                          <a href="javascript:;">
                          <i class="u-icon u-icon-app" title="应用"></i>
                            ${xxx.title}</a><i class="j-toggle"></i>
                        </h4>
                        <ul class="lv5">
                          <#if xxx.cluster??>
                          <#list xxx.cluster as xxxx>
                          <li class="j-item <#if clusterId??><#if clusterId?number == xxxx.id?number>z-open</#if></#if>">
                            <h5 <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>class="z-act"</#if>>
                              <#if index=1>
                              <a href="/sentry/status?clusterId=${xxxx.id}&sign=1&status=all" title="${xxxx.title}"><i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>${xxxx.title}</a>
                              <#elseif index=2>
                              <a href="/sentry/monitor/list?clusterId=${xxxx.id}&sign=1" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#elseif index=3>
                              <a href="/sentry/alarm?clusterId=${xxxx.id}&sign=1" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#elseif index=4>
                              <a href="/sentry/alarm/history?clusterId=${xxxx.id}&sign=1" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#elseif index=5>
                              <a href="/sentry/alarm/cluster?clusterId=${xxxx.id}&sign=1" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#elseif index=6>
                              <a href="/sentry/status/cluster?clusterId=${xxxx.id}&sign=1" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              <#else>
                              <a href="/sentry/appMonitor/view?clusterId=${xxxx.id}&sign=1" title="${xxxx.title}">
                              <i class="u-icon <#if (RequestParameters.clusterId)?? && (RequestParameters.clusterId?number == xxxx.id?number)>u-icon-act-cluster<#else>u-icon-cluster</#if>" title="集群"></i>
                                ${xxxx.title}</a>
                              </#if>
                            </h5>
                          </li> 
                          </#list>
                          </#if>
                        </ul>
                      </li> 
                      </#list>
                      </#if>
                    </ul>
                  </li> 
                  </#list>
                  </#if>
                </ul>
              </li>
            </#if>
            </#list>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</div>
<div class="ut-toggle <#if (RequestParameters.show)??><#else>show</#if>" id="tog-left">
  <a><i class="u-icon j-toggle"></i></a>
</div>
</#macro>
<#macro load>
<div class="m-loading" id="loading">
  <div class="mask"></div>
  <div class="loading"></div>
</div>
</#macro>
</#escape>