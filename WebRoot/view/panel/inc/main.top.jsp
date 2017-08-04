<%@page import="com.bluemobi.po.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<header class="bg-dark dk header navbar navbar-fixed-top-xs">
    <div class="navbar-header aside-md">
        <a class="btn btn-link visible-xs" data-toggle="class:nav-off-screen,open" data-target="#nav,html">
            <i class="fa fa-bars"></i>
        </a>
        <a href="javascript:;" class="navbar-brand" data-toggle="fullscreen">
            <img src="${STATIC_URL}/panel/img/logo.png" class="m-r-sm">译同行管理系统
        </a>
        <a class="btn btn-link visible-xs" data-toggle="dropdown" data-target=".nav-user">
            <i class="fa fa-cog"></i>
        </a>
    </div>
    <ul class="nav navbar-nav navbar-right hidden-xs nav-user">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                <span class="thumb-sm avatar pull-left">
                    <img src="${STATIC_URL}/panel/img/avatar.jpg">
                </span>
                ${user.name}<b class="caret"></b>
            </a>
            <ul class="dropdown-menu animated fadeInRight">
                <li>
                    <a href="${BASE_URL}/background/sign/out" class="sign-out">注销</a>
                </li>
            </ul>
        </li>
    </ul>      
</header>