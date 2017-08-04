<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
<link
	href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all"
	rel="stylesheet" type="text/css" />
<link
	href="<%=request.getContextPath()%>/plugins/global/plugins/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="<%=request.getContextPath()%>/plugins/global/plugins/simple-line-icons/simple-line-icons.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css"
	rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN THEME GLOBAL STYLES -->
<link
	href="<%=request.getContextPath()%>/plugins/global/css/components.min.css"
	rel="stylesheet" id="style_components" type="text/css" />
<link
	href="<%=request.getContextPath()%>/plugins/global/css/plugins.min.css"
	rel="stylesheet" type="text/css" />
<!-- END THEME GLOBAL STYLES -->
<!-- BEGIN THEME LAYOUT STYLES -->
<link
	href="<%=request.getContextPath()%>/plugins/layouts/layout4/css/layout.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="<%=request.getContextPath()%>/plugins/layouts/layout4/css/themes/light.min.css"
	rel="stylesheet" type="text/css" id="style_color" />
<link
	href="<%=request.getContextPath()%>/plugins/layouts/layout4/css/custom.min.css"
	rel="stylesheet" type="text/css" />
<!-- END THEME LAYOUT STYLES -->
<link rel="shortcut icon" href="favicon.ico" />
<link
	href="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css"
	rel="stylesheet" type="text/css" />
<link
	href="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap-modal/css/bootstrap-modal.css"
	rel="stylesheet" type="text/css" />
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

<body
	class="page-container-bg-solid page-header-fixed page-sidebar-closed-hide-logo">

	<!-- BEGIN HEADER -->
	<jsp:include page="/WEB-INF/jsp/common/head.jsp" />
	<!-- END HEADER -->

	<!-- BEGIN HEADER & CONTENT DIVIDER -->
	<div class="clearfix"></div>
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
						<h1>
							资料审核管理 <small>资料审核</small>
						</h1>
					</div>
					<!-- END PAGE TITLE -->
					<!-- BEGIN PAGE TOOLBAR -->

					<!-- END PAGE TOOLBAR -->
				</div>
				<!-- END PAGE HEAD-->
				<!-- BEGIN PAGE BREADCRUMB -->
				<ul class="page-breadcrumb breadcrumb">
					<li><a href="index.html">资料审核管理</a> <i class="fa fa-circle"></i>
					</li>
					<li><span class="active">资料审核</span>
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
									<span class="caption-subject font-green bold uppercase">资料审核</span>
								</div>

							</div>
							<div class="portlet-body">
								<div class="table-scrollable">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>姓名</th>
												<th>邮箱</th>
												<th>性别</th>
												<th>出生年月</th>
												<th>服务区域</th>
												<th>学历</th>
												<th>毕业学校</th>
												<th>专业</th>
												<!-- <th> 语种 </th> -->
												<!-- <th> 等级 </th> -->
												<th>注册时间</th>
												<th>状态</th>
												<th>操作</th>
											</tr>
										</thead>
										<tbody>
											<!-- 遍历数据 start -->
											<c:forEach items="${list}" var="list">
												<tr>
													<td>${list.name}</td>
													<td>${list.account}</td>
													<td>${list.sex}</td>
													<td>${list.birthdayauFormat}</td>
													<td>${list.areaname}</td>

													<td><c:if test="${list.education==1}">本科</c:if> <c:if
															test="${list.education==2}">硕士</c:if> <c:if
															test="${list.education==3}">博士</c:if>
													</td>
													<td>${list.school}</td>
													<td>${list.specialtyname}</td>
													<td><fmt:formatDate value='${list.createtime}'
															pattern='yyyy-MM-dd HH:mm:ss' /></td>
													<td><c:if test="${list.auditstate==0}">
															<font color="red">未填资料</font>
														</c:if> <c:if test="${list.auditstate==1}">
															<font color="green">审核中</font>
														</c:if> <c:if test="${list.auditstate==2}">
															<font color="red">审核不通过</font>
														</c:if> <c:if test="${list.auditstate==3}">
															<font color="green">审核通过</font>
														</c:if> <c:if test="${list.auditstate==4}">
															<font color="red">申请更新资料</font>
														</c:if> <c:if test="${list.auditstate==5}">
															<font color="red">更新资料审核不通过</font>
														</c:if></td>
													<td>
														<c:if test="${list.auditstate==1 || list.auditstate==4}">
															<span class="label label-sm label-danger"
																onclick="check(${list.auditid});">审核</span>
														</c:if>	
														<c:if test="${list.auditstate==2 || list.auditstate==3 || list.auditstate==5}">
															<span class="label label-sm label-success">已审核</span>
														</c:if>		
													</td>
												</tr>
											</c:forEach>
											<!-- 遍历数据 end -->
										</tbody>
									</table>
								</div>
							</div>
							<div class="container">
								<div class="row clearfix">
									<div class="col-md-12 column">${paginationHtml}</div>
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
		<script src="<%=request.getContextPath()%>/plugins/global/plugins/respond.min.js"></script>
		<script src="<%=request.getContextPath()%>/plugins/global/plugins/excanvas.min.js"></script> 
		<![endif]-->
	<!-- BEGIN CORE PLUGINS -->
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/jquery.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/js.cookie.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/jquery.blockui.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js"
		type="text/javascript"></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN THEME GLOBAL SCRIPTS -->
	<script
		src="<%=request.getContextPath()%>/plugins/global/scripts/app.min.js"
		type="text/javascript"></script>
	<!-- END THEME GLOBAL SCRIPTS -->
	<!-- BEGIN THEME LAYOUT SCRIPTS -->
	<script
		src="<%=request.getContextPath()%>/plugins/layouts/layout4/scripts/layout.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/layouts/layout4/scripts/demo.min.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/layouts/global/scripts/quick-sidebar.min.js"
		type="text/javascript"></script>
	<!-- END THEME LAYOUT SCRIPTS -->

	<!-- modal start -->
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap-modal/js/bootstrap-modalmanager.js"
		type="text/javascript"></script>
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap-modal/js/bootstrap-modal.js"
		type="text/javascript"></script>
	<!-- modal end -->
</body>

<script type="text/javascript">
		
		$(function(){
			//菜单选中样式添加
	        $(".page-sidebar-menu").children("li[name='auditExamine']").addClass("open");
	        $(".page-sidebar-menu").children("li[name='auditExamine']").children("li[name='auditExamine']").children("a").children("span[class='arrow']").addClass("open");
	        $(".page-sidebar-menu").children("li[name='auditExamine']").children("ul").children("li[name='audit']").addClass("active");
	        $(".page-sidebar-menu").children("li[name='auditExamine']").children("ul").css("display","block");
		})
	
		/*
		 *进入审核页面
		 */
		function check(id){
			window.location.href = "<%=request.getContextPath()%>/backstage/userAudit/auditExamine?auditid="+id;
		}
	</script>
</html>