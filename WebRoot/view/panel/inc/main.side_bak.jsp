<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@page import="com.bluemobi.po.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!-- .aside -->
<aside class="bg-dark lter aside-md hidden-print" id="nav">
    <section class="vbox">
       <!--  <header class="header bg-primary lter text-center clearfix">
		    <div class="btn-group">
		        <button type="button" class="btn btn-sm btn-dark btn-icon" title="New project"><i class="fa fa-plus"></i></button>
		        <div class="btn-group hidden-nav-xs">
		            <a type="button" class="btn btn-sm btn-primary dropdown-toggle" data-toggle="dropdown" href="#">
		                <span id="nav_one_now">内容</span>
		                <span class="caret"></span>
		            </a>
		            <ul class="dropdown-menu text-left">
		                <li class="nav-one active"><a data-toggle="tab" href="#nav_content">内容</a></li>
		                <li class="nav-one"><a data-toggle="tab" href="#nav_cas">会员</a></li>
		                <li class="nav-one"><a data-toggle="tab" href="#nav_setting">配置</a></li>
		                <li class="nav-one"><a data-toggle="tab" href="#nav_favorite">收藏</a></li>
		            </ul>
		        </div>
		    </div>
		</header> -->

        <section class="w-f scrollable">
            <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="5px" data-color="#333333">

                <!-- nav -->
                <div class="tab-content">
	                <div id="nav_content" class="tab-pane fade active in nav-content">
		                <nav class="nav-primary hidden-xs">
		                    <ul class="nav" id="left_nav">
		                    <c:forEach items="${nav_two}" var="v">
		                    	 <c:if test="${v.parent_id == 1 }">
		                        <li>
		                            <a href="javascript:;" class="nav-two">
		                                <i class="fa icon ${v.icon}">
		                                    <b class="${v.icon_bg}"></b>
		                                </i>
		                                <span class="pull-right">
		                                    <i class="fa fa-angle-down text"></i>
		                                    <i class="fa fa-angle-up text-active"></i>
		                                </span>
		                                <span>${v.title}</span>
		                            </a>
		                            <ul class="nav lt nav-three">
		                             <c:forEach items="${nav_three}" var="vv">
		                    	 		<c:if test="${vv.parent_id == v.navigation_id }">
		                                <li>
		                               		 <a href="${vv.link}" class="load-content">
		                                        <i class="fa fa-angle-right"></i>
		                                        <span>${vv.title}</span>
		                                    </a>
		                                </li>
		                                </c:if>
		                                </c:forEach>
		                            </ul>
		                        </li>
		                        </c:if>
		                        </c:forEach>
		                    </ul>
		                </nav>
	                </div>
	                
	                <div id="nav_cas" class="tab-pane fade nav-content">
	                    <nav class="nav-primary hidden-xs">
                            <ul class="nav" id="left_nav">
                             <c:forEach items="${nav_two}" var="v">
                             	<c:if test="${v.parent_id == 2 }">
                                <li>
                                    <a href="javascript:;" class="nav-two">
                                        <i class="fa icon ${v.icon}">
                                            <b class="${v.icon_bg}"></b>
                                        </i>
                                        <span class="pull-right">
                                            <i class="fa fa-angle-down text"></i>
                                            <i class="fa fa-angle-up text-active"></i>
                                        </span>
                                        <span>${v.title}</span>
                                    </a>
                                    <ul class="nav lt nav-three">
                                     	<c:forEach items="${nav_three}" var="vv">
		                    	 		<c:if test="${vv.parent_id == v.navigation_id }">
                                        <li>
                                            <a href="${vv.link}" class="load-content">
                                                <i class="fa fa-angle-right"></i>
                                                <span>${vv.title}</span>
                                            </a>
                                        </li>
                                        </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>
                                </c:if>
                                </c:forEach>
                            </ul>
                        </nav>
	                </div>
	                <div id="nav_setting" class="tab-pane fade nav-content">
	                    <nav class="nav-primary hidden-xs">
                            <ul class="nav" id="left_nav">
                            <c:forEach items="${nav_two}" var="v">
		                    	 <c:if test="${v.parent_id == 3 }">
                                <li>
                                    <a href="javascript:;" class="nav-two">
                                        <i class="fa icon ${v.icon}">
                                            <b class="${v.icon_bg}"></b>
                                        </i>
                                        <span class="pull-right">
                                            <i class="fa fa-angle-down text"></i>
                                            <i class="fa fa-angle-up text-active"></i>
                                        </span>
                                        <span>${v.title}</span>
                                    </a>
                                    <ul class="nav lt nav-three">
                                    	<c:forEach items="${nav_three}" var="vv">
		                    	 		<c:if test="${vv.parent_id == v.navigation_id }">
                                        <li>
                                            <a href="${vv.link}" class="load-content">
                                                <i class="fa fa-angle-right"></i>
                                                <span>${vv.title}</span>
                                            </a>
                                        </li>
                                        </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>
                                </c:if>
                                </c:forEach>
                            </ul>
                        </nav>
	                </div>
	                <div id="nav_favorite" class="tab-pane fade nav-content">
	                    <nav class="nav-primary hidden-xs">
                            <ul class="nav" id="left_nav">
                            <c:forEach items="${nav_two}" var="v">
		                    	 <c:if test="${v.parent_id == 4 }">
                                <li>
                                    <a href="javascript:;" class="nav-two">
                                        <i class="fa icon ${v.icon}">
                                            <b class="${v.icon_bg}"></b>
                                        </i>
                                        <span class="pull-right">
                                            <i class="fa fa-angle-down text"></i>
                                            <i class="fa fa-angle-up text-active"></i>
                                        </span>
                                        <span>${v.title}</span>
                                    </a>
                                    <ul class="nav lt nav-three">
                                    	<c:forEach items="${nav_three}" var="vv">
		                    	 		<c:if test="${vv.parent_id == v.navigation_id }">
                                        <li>
                                            <a href="${vv.link}" class="load-content">
                                                <i class="fa fa-angle-right"></i>
                                                <span>{$vv.title}</span>
                                            </a>
                                        </li>
                                        </c:if>
                                        </c:forEach>
                                    </ul>
                                </li>
                                </c:if>
                                </c:forEach>
                            </ul>
                        </nav>
	                </div>
                
                </div>
                <!-- / nav -->
            </div>
        </section>

        <footer class="footer lt hidden-xs b-t b-dark">
            <a href="#nav" data-toggle="class:nav-xs" class="pull-right btn btn-sm btn-dark btn-icon">
                <i class="fa fa-angle-left text"></i>
                <i class="fa fa-angle-right text-active"></i>
            </a>
        </footer>
    </section>
</aside>
<!-- /.aside -->