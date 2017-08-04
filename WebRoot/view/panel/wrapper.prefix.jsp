<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% boolean isAjax = com.appcore.util.AjaxUtil.checkIsAjax(request); %><!--确定指定的HTTP请求是否是AJAX请求(返回值Boolean) -->
<c:if test="${isAjax != true}">
	<jsp:include page="/view/panel/wrapper.prefix-tiny.jsp"/> 
	<body>
	<section class="vbox">
		<!-- top网页头部  start-->
	    <jsp:include page="/view/panel/inc/main.top.jsp"/>
	    <!-- top网页头部  end-->
	    <section>
	        <section class="hbox stretch">
	       	<!-- left网页左侧菜单  start-->
			<jsp:include page="/view/panel/inc/main.side.jsp"/>
			<!-- left网页左侧菜单  end-->
	        <section id="content">
</c:if> 