<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->
<html lang="en">
    <!--<![endif]-->
    <!-- BEGIN HEAD -->

    <head>
        <meta charset="utf-8" />
        <title>译同行 | 后台管理系统</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="/gate/plugins/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="/gate/plugins/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="/gate/plugins/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="/gate/plugins/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="/gate/plugins/global/css/components.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="/gate/plugins/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="/gate/plugins/layouts/layout4/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="/gate/plugins/layouts/layout4/css/themes/light.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="/gate/plugins/layouts/layout4/css/custom.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" /> 
        <style>
			.center {
				text-align: center;
				display: flex;
				justify-content: center;
				align-items: center;
			}
			
			th {
				text-align: center;
			}
			
			td {
				text-align: center;
			}
		</style>
        </head>
    <!-- END HEAD -->

    <body class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">
    
        <!-- BEGIN HEADER -->
        <jsp:include page="/WEB-INF/jsp/common/head.jsp" />
        <!-- END HEADER -->
        
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN SIDEBAR -->
            <jsp:include page="/WEB-INF/jsp/common/menu.jsp" />
            <!-- END SIDEBAR -->
            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <!-- BEGIN PAGE HEAD-->
                    <div class="page-head">
                        <!-- BEGIN PAGE TITLE -->
                        <div class="page-title">
                            <h1>订单管理
                                <small>预约订单管理</small>
                            </h1>
                        </div>
                        <!-- END PAGE TITLE -->
                        <!-- BEGIN PAGE TOOLBAR -->
                        
                        <!-- END PAGE TOOLBAR -->
                    </div>
                    <!-- END PAGE HEAD-->
                    <!-- BEGIN PAGE BREADCRUMB -->
                    <ul class="page-breadcrumb breadcrumb">
                        <li>
                            <a href="javascript:void(0);">订单管理</a>
                            <i class="fa fa-circle"></i>
                        </li>
                        <li>
                            <span class="active">预约订单管理</span>
                        </li>
                    </ul>
                    <!-- END PAGE BREADCRUMB -->
                    <!-- BEGIN PAGE BASE CONTENT -->
                    <div class="row">
                        <div class="col-md-12">
                            <!-- BEGIN SAMPLE TABLE PORTLET-->
                            <div class="portlet light bordered">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <span class="caption-subject font-green bold uppercase">预约订单管理</span>
                                    </div>
                                   
                                </div>
                                <div class="portlet-body">
                                    <div class="table-scrollable">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th> 用户 </th>
                                                    <th> 服务地点 </th>
                                                    <th> 开始时间 </th>
                                                    <th> 结束时间 </th>
                                                    <th> 服务时长 </th>
                                                    <th> 母语 </th>
                                                    <th> 服务语言 </th>
                                                    <th> 服务类型 </th>
                                                    <th> 费用 </th>
                                                    <th> 是否被抢单 </th>
                                                    <th> 抢单译员 </th>
                                                    <th> 抢单时间</th>
                                                    <!-- <th> 操作 </th> -->
                                                </tr>
                                            </thead>
                                            <tbody>
                                            	<!-- 遍历数据 start -->
                                            	<c:forEach items="${list}" var="list">
	                                            	<tr>
	                                                    <td> ${list.username} </td>
	                                                    <td>${list.place} ${list.address}</td>
	                                                    <td> <fmt:formatDate value='${list.begintime}' pattern='yyyy-MM-dd HH:mm:ss'/> </td>
	                                                    <td> <fmt:formatDate value='${list.endtime}' pattern='yyyy-MM-dd HH:mm:ss'/> </td>
	                                                    <td> ${list.hours}小时</td>
	                                                    <td> ${list.motherlanguage} </td>
	                                                    <td> ${list.needlanguage} </td>
	                                                    <td> ${list.level} </td>
	                                                    <td>
	                                                    	<c:choose>
	                                                    		<c:when test="${!empty list.totalfare}">${list.totalfare}元</c:when>
	                                                    		<c:otherwise><font color="red">暂无</font></c:otherwise>
	                                                    	</c:choose> 
	                                                    </td>
	                                                    <td> 
	                                                    	<c:if test="${list.state==0}"><font color="red">否</font></c:if>
	                                                    	<c:if test="${list.state==1}"><font color="green">是</font></c:if>
	                                                    </td>
	                                                    <td> ${list.tranusername} </td>
	                                                    <td> <fmt:formatDate value='${list.getbilltime}' pattern='yyyy-MM-dd HH:mm:ss'/> </td>
	                                                    <!-- <td>
	                                                        <span class="label label-sm label-info" onclick="check(${list.maketransid});">查看</span>
	                                                    </td> -->
	                                                </tr>
												</c:forEach>	
												<!-- 遍历数据 end -->
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row clearfix">
                                        <div class="col-md-12 column">
                                           ${paginationHtml}
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- END SAMPLE TABLE PORTLET-->
                        </div>
                    </div>
                   
                    <!-- END PAGE BASE CONTENT -->
                </div>
                <!-- END CONTENT BODY -->
            </div>
            <!-- END CONTENT -->
           
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <jsp:include page="/WEB-INF/jsp/common/footer.jsp" />
        <!-- END FOOTER -->
        <!--[if lt IE 9]>
		<script src="/gate/plugins/global/plugins/respond.min.js"></script>
		<script src="/gate/plugins/global/plugins/excanvas.min.js"></script> 
		<![endif]-->
        <!-- BEGIN CORE PLUGINS -->
        <script src="/gate/plugins/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="/gate/plugins/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="/gate/plugins/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="/gate/plugins/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="/gate/plugins/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="/gate/plugins/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="/gate/plugins/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN THEME GLOBAL SCRIPTS -->
        <script src="/gate/plugins/global/scripts/app.min.js" type="text/javascript"></script>
        <!-- END THEME GLOBAL SCRIPTS -->
        <!-- BEGIN THEME LAYOUT SCRIPTS -->
        <script src="/gate/plugins/layouts/layout4/scripts/layout.min.js" type="text/javascript"></script>
        <script src="/gate/plugins/layouts/layout4/scripts/demo.min.js" type="text/javascript"></script>
        <script src="/gate/plugins/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
        <!-- END THEME LAYOUT SCRIPTS -->
    </body>
    
	<script type="text/javascript">
		
		$(function(){
			//菜单选中样式添加
	        $(".page-sidebar-menu").children("li[name='orderManagement']").addClass("open");
	        $(".page-sidebar-menu").children("li[name='orderManagement']").children("li[name='preOrder']").children("a").children("span[class='arrow']").addClass("open");
	        $(".page-sidebar-menu").children("li[name='orderManagement']").children("ul").children("li[name='preOrder']").addClass("active");
	        $(".page-sidebar-menu").children("li[name='orderManagement']").children("ul").css("display","block");
		});
	
		/*
		 *进入审核页面
		 */
		function check(id){
		alert(id);
			//window.location.href = "<%=request.getContextPath()%>/backstage/userAudit/auditExamine?auditid="+id;
		}
	</script>
</html>