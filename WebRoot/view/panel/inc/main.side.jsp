<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@page import="com.bluemobi.po.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<aside class="bg-dark lter aside-md hidden-print" id="nav">
    <section class="vbox">
        <section class="w-f scrollable">
            <div class="slim-scroll" data-height="auto" data-disable-fade-out="true" data-distance="0" data-size="5px" data-color="#333333">
	        	<div class="tab-content">
	                <div id="nav_content" class="tab-pane fade active in nav-content">
		                <nav class="nav-primary hidden-xs">
		                    <ul class="nav" id="left_nav">
			                    <c:forEach items="${menuList}" var="v">
			                    	 <c:if test="${v.parentid == 1}">
				                        <li>
				                            <a href="javascript:;" class="nav-two">
				                                <i class="fa icon ${v.icon}">
				                                    <b class="${v.iconBg}"></b>
				                                </i>
				                                <span class="pull-right">
				                                    <i class="fa fa-angle-down text"></i>
				                                    <i class="fa fa-angle-up text-active"></i>
				                                </span>
				                                <span>${v.title}</span>
				                            </a>
				                            <ul class="nav lt nav-three">
				                             	<c:forEach items="${menuList}" var="vv">
					                    	 		<c:if test="${vv.parentid == v.menuid}">
						                                <li>
						                               		 <a href="${BASE_URL}${vv.link}" class="load-content">
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
	        	</div>
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