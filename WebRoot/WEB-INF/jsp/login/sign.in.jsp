<%@ page contentType="text/html;charset=UTF-8" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN" class="bg-dark js no-touch no-android no-chrome firefox no-iemobile no-ie no-ie10 no-ie11 no-ios">
<head>
	<base href="<%=basePath%>">
	<meta charset="utf-8" />
	<title>${SITE_NAME}</title>
	<meta name="description" content="app, web app, responsive, admin dashboard, admin, flat, flat ui, ui kit, off screen nav" />
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  
    <link rel="stylesheet" href="${STATIC_URL}/scripts/bootstrap/3.1.0/css/bootstrap.min.css" type="text/css"/>
	<link rel="stylesheet" href="${STATIC_URL}/panel/css/animate.css" type="text/css"/>
	<link rel="stylesheet" href="${STATIC_URL}/panel/css/apps.css" type="text/css"/>
	<link rel="stylesheet" href="${STATIC_URL}/panel/css/sign.css" type="text/css"/>
	
	<script src="${STATIC_URL}/scripts/jquery/1.11.0/jquery.min.js"></script>
    <script src="${STATIC_URL}/scripts/bootstrap/3.1.0/js/bootstrap.min.js"></script>
	<script src="${STATIC_URL}/scripts/jquery-form/3.03/jquery.form.js"></script>
    <script src="${STATIC_URL}/panel/js/sign.js"></script>
</head>
<body>
<section id="aui_iwrapper" class="animated fadeInUp aui-iwrapper">
    <section class="panel panel-default bg-white m-t-lg">
        <header class="panel-heading text-center">
            <strong>后台管理系统</strong>
        </header>
        <form action="${BASE_URL}/background/login" id="form_sign" class="panel-body wrapper-lg" method="post" title="登录" data-validate="parsley">
            <div class="form-group">
                <label class="control-label">用户名</label>
                <input type="text" name="username" class="form-control" id="username" placeholder="用户名" data-maxlength="20" data-minlength="4" data-required="true" data-trigger="change"/>
                <span class="notice notice-username"></span>
            </div>
            <div class="form-group">
                <label class="control-label">密码</label>
                <input type="password" name="password" class="form-control" id="inputPassword" placeholder="密码" data-maxlength="20" data-minlength="4" data-required="true" data-trigger="change" />
                <span class="notice notice-password"></span>
            </div>
            <div class="form-group">
                <label class="control-label">验证码</label>	
                <input type="text" name="captcha" class="captcha form-control" id="login-captcha" placeholder="验证码" data-maxlength="4"  data-required="true" data-trigger="change" autocomplete="off" />
                <span class="notice notice-captcha"></span>
            </div>
            <div class="form-group">
                <img src="${BASE_URL}/background/code" alt="点击换一张" id="vcodeimg" title="看不清楚，换一张" style="cursor:pointer;width: 120px;height: 38px;" onclick="this.src='background/code?t='+Math.random();" >
	            &nbsp;<button type="submit" id="sign_submit" class="btn btn-primary">登录</button>&nbsp;
	            <button type="reset" class="btn btn-info">重置</button>&nbsp;
            </div>
            <div class="line line-dashed"></div>
            <h5 class="text text-danger notice-back"></h5>
        </form>
    </section>
</section>
<footer id="footer">
    <div class="text-center padder">
        <p>
            <small></small>
        </p>
    </div>
</footer>
</body>
</html>