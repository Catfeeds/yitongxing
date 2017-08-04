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
	href="/gate/plugins/global/plugins/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="/gate/plugins/global/plugins/simple-line-icons/simple-line-icons.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="/gate/plugins/global/plugins/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="/gate/plugins/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css"
	rel="stylesheet" type="text/css" />
<!-- END GLOBAL MANDATORY STYLES -->
<!-- BEGIN THEME GLOBAL STYLES -->
<link href="/gate/plugins/global/css/components.min.css"
	rel="stylesheet" id="style_components" type="text/css" />
<link href="/gate/plugins/global/css/plugins.min.css" rel="stylesheet"
	type="text/css" />
<!-- END THEME GLOBAL STYLES -->
<!-- BEGIN THEME LAYOUT STYLES -->
<link href="/gate/plugins/layouts/layout4/css/layout.min.css"
	rel="stylesheet" type="text/css" />
<link href="/gate/plugins/layouts/layout4/css/themes/light.min.css"
	rel="stylesheet" type="text/css" id="style_color" />
<link href="/gate/plugins/layouts/layout4/css/custom.min.css"
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
					<li><span class="active">资料审核</span></li>
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
								<div class="actions">
									<div class="btn-group btn-group-devided" data-toggle="buttons">
										<label
											class="btn btn-transparent blue btn-outline btn-circle btn-sm active" onclick="check();">审核</label>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-1"></div>
								<div class="col-md-5">姓名：${userAudit.name}</div>
								<div class="col-md-5">性别：${userAudit.sex}</div>
								<div class="col-md-1"></div>
							</div>
							<div class="row" style="margin-top: 30px;">
								<div class="col-md-1"></div>
								<div class="col-md-5">
									学历：
									<c:if test="${userAudit.education==1}">本科</c:if>
									<c:if test="${userAudit.education==2}">硕士</c:if>
									<c:if test="${userAudit.education==3}">博士</c:if>
								</div>
								<div class="col-md-5">专业：${userAudit.specialtyname}</div>
								<div class="col-md-1"></div>
							</div>
							<!--  <div class="row" style="margin-top: 30px;">
								<div class="col-md-1"></div>
								<div class="col-md-5">语种：${userAudit.name}</div>
								<div class="col-md-5">区域：${userAudit.sex}</div>
								<div class="col-md-1"></div>
							</div>-->
							<div class="row" style="margin-top: 30px;">
								<div class="col-md-1"></div>
								<div class="col-md-5">年龄：${userAudit.age}</div>
								<div class="col-md-5">毕业学校：${userAudit.school}</div>
								<div class="col-md-1"></div>
							</div>
							<div class="row" style="margin-top: 30px;">
								<div class="col-md-1"></div>
								<div class="col-md-5">
									出生年月：
									<fmt:formatDate value='${userAudit.birthdayau}'
										pattern='yyyy-MM-dd' />
								</div>
								<div class="col-md-5">籍贯：${userAudit.origin}</div>
								<div class="col-md-1"></div>
							</div>
							<div class="row" style="margin-top: 30px;">
								<div class="col-md-1"></div>
								<div class="col-md-5">职业：${userAudit.profession}</div>

								<div class="col-md-1"></div>
							</div>

							<div class="row" style="margin-top: 30px;">
								<div class="col-md-1"></div>
								<div class="col-md-10">个人简介：${userAudit.remark}</div>
								<div class="col-md-1"></div>
							</div>
						</div>

						<div class="form-group col-md-12">

							<c:forEach items="${imgUrls}" var="img">
								<div class="col-md-6">
									<a href="ftp://192.168.1.15/imagesFTP/user/${img}"
										class="thumbnail" target="_blank"> <img title="点击查看原图"
										src="ftp://192.168.1.15/imagesFTP/user/${img}"
										class="img-rounded"> </a>
								</div>
							</c:forEach>
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
	<script src="/gate/plugins/global/plugins/jquery.min.js"
		type="text/javascript"></script>
	<script
		src="/gate/plugins/global/plugins/bootstrap/js/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="/gate/plugins/global/plugins/js.cookie.min.js"
		type="text/javascript"></script>
	<script
		src="/gate/plugins/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js"
		type="text/javascript"></script>
	<script
		src="/gate/plugins/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js"
		type="text/javascript"></script>
	<script src="/gate/plugins/global/plugins/jquery.blockui.min.js"
		type="text/javascript"></script>
	<script
		src="/gate/plugins/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js"
		type="text/javascript"></script>
	<!-- END CORE PLUGINS -->
	<!-- BEGIN THEME GLOBAL SCRIPTS -->
	<script src="/gate/plugins/global/scripts/app.min.js"
		type="text/javascript"></script>
	<!-- END THEME GLOBAL SCRIPTS -->
	<!-- BEGIN THEME LAYOUT SCRIPTS -->
	<script src="/gate/plugins/layouts/layout4/scripts/layout.min.js"
		type="text/javascript"></script>
	<script src="/gate/plugins/layouts/layout4/scripts/demo.min.js"
		type="text/javascript"></script>
	<script src="/gate/plugins/layouts/global/scripts/quick-sidebar.min.js"
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
	$(function() {
		//菜单选中样式添加
		$(".page-sidebar-menu").children("li[name='auditExamine']").addClass(
				"open");
		$(".page-sidebar-menu").children("li[name='auditExamine']").children(
				"li[name='auditExamine']").children("a").children(
				"span[class='arrow']").addClass("open");
		$(".page-sidebar-menu").children("li[name='auditExamine']").children(
				"ul").children("li[name='audit']").addClass("active");
		$(".page-sidebar-menu").children("li[name='auditExamine']").children(
				"ul").css("display", "block");
	})
	
	
	function check(){
		$("#auditModal").modal();
	}
	
	function save(){
		var auditstate = $("#auditstate").val();
		var auditid = $("#auditid").val();
		var userid = $("#userid").val();
		if(auditstate==''){
			$("#auditstate").focus();
			return;
		}
		
		var url = "<%=request.getContextPath()%>/backstage/userAudit/updateAudit";
		$.ajax({   
		    url:url,   
		    type:'get',
		    data:{"auditstate":auditstate,"auditid":auditid,"userid":userid},
		    error:function(){   
		       alert('网络异常');   
		    },   
		    success:function(json){ 
		    	json = eval('('+json+')');
				if(json.state==0){
					window.location.href = "<%=request.getContextPath()%>/backstage/userAudit/audit";
				}else{
					alert(json.msg);   
				}
		    }
		});
	}
</script>
</html>
<!-- 审核译员 start -->
<div id="auditModal" class="modal fade" tabindex="-1" data-width="400" data-backdrop="static">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		<h4 class="modal-title" id="position_title">译员审核</h4>
	</div>
	<div class="modal-body">
		<input type="hidden" value="${userAudit.auditid}" id="auditid">
		<input type="hidden" value="${userAudit.userid}" id="userid">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div
					class="form-group form-md-line-input form-md-floating-label has-info">
					<select class="form-control edited" id="auditstate" name="auditstate">
						<option value="2">审核不通过</option>
						<option value="3">审核通过</option>
						<option value="4">申请更新资料</option>
						<option value="5">更新资料审核不通过</option>
					</select> 
					<label for="auditstate">审核状态</label>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>

	<div class="modal-footer row">
		<div class="col-md-3"></div>
		<div class="col-md-3 center">
			<button type="submit" class="btn blue" onclick="save();">提交</button>
		</div>
		<div class="col-md-3 center">
			<button type="button" data-dismiss="modal"
				class="btn btn-outline dark" onclick="">取消</button>
		</div>
		<div class="col-md-3"></div>
	</div>
</div>
<!-- 审核译员 end -->
