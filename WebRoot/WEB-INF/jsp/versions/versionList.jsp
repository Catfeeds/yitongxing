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
	href="/gate/plugins/global/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css"
	rel="stylesheet" type="text/css" />
<link
	href="/gate/plugins/global/plugins/bootstrap-modal/css/bootstrap-modal.css"
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
							版本管理 <small>版本管理</small>
						</h1>
					</div>
					<!-- END PAGE TITLE -->
					<!-- BEGIN PAGE TOOLBAR -->

					<!-- END PAGE TOOLBAR -->
				</div>
				<!-- END PAGE HEAD-->
				<!-- BEGIN PAGE BREADCRUMB -->
				<ul class="page-breadcrumb breadcrumb">
					<li><a href="javascript:void(0);">版本管理</a> <i
						class="fa fa-circle"></i></li>
					<li><span class="active">版本管理</span></li>
				</ul>
				<!-- END PAGE BREADCRUMB -->
				<!-- BEGIN PAGE BASE CONTENT -->
				<div class="row">
					<div class="col-md-12">
						<!-- BEGIN SAMPLE TABLE PORTLET-->
						<div class="portlet light bordered">
							<div class="portlet-title">
								<div class="caption">
									<span class="caption-subject font-green bold uppercase">版本管理</span>
								</div>
								<div class="actions">
									<div class="btn-group btn-group-devided" data-toggle="buttons">
										<label
											class="btn btn-transparent blue btn-outline btn-circle btn-sm active"
											onclick="addModal();">新增 </label>
									</div>
								</div>
							</div>
							<div class="portlet-body">
								<div class="table-scrollable">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>版本号</th>
												<th>更新时间</th>
												<th>文件路径</th>
												<th> 操作 </th>
											</tr>
										</thead>
										<tbody>
											<!-- 遍历数据 start -->
											<c:forEach items="${list}" var="list">
												<tr>
													<td>${list.versions}</td>
													<td><fmt:formatDate value='${list.ctime}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
													<td>${list.fileurl}</td>
													<td><span class="label label-sm label-info" onclick="check(${list.versionid});">查看内容</span></td>
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
		src="/gate/plugins/global/plugins/bootstrap-modal/js/bootstrap-modal.js"
		type="text/javascript"></script>
	<!-- modal end -->
</body>

<script type="text/javascript">
		
		$(function(){
			//菜单选中样式添加
	        $(".page-sidebar-menu").children("li[name='version']").addClass("open");
	        $(".page-sidebar-menu").children("li[name='version']").children("li[name='versionList']").children("a").children("span[class='arrow']").addClass("open");
	        $(".page-sidebar-menu").children("li[name='version']").children("ul").children("li[name='versionList']").addClass("active");
	        $(".page-sidebar-menu").children("li[name='version']").children("ul").css("display","block");
		})
	
		/*
		 * 唤起新增modal
		 */
		function addModal(){
			$("#languageModal").modal();
		}
		
		function save(){
			var languagename = $("#languagename").val();
			var languageEng = $("#languageEng").val();
			var hotLanguageId = $("#hotLanguageId").val();
			
			if(languagename==''){
				$("#languagename").focus();
				return;
			}
			
			//URI编码一次
			languagename = encodeURI(languagename);
			
			var url = "<%=request.getContextPath()%>/backstage/language/addLanguage";
			$.ajax({   
			    url:url,   
			    type:'get',
			    data:{"languagename":languagename,"languageEng":languageEng,"hotLanguageId":hotLanguageId},
			    error:function(){   
			       alert('网络异常');   
			    },   
			    success:function(json){ 
			    	json = eval('('+json+')');
					if(json.state==0){
						window.location.href = "<%=request.getContextPath()%>/backstage/language/languageList";
					}else{
						alert(json.msg);   
					}
			    }
			});
		}
</script>
</html>
<!-- 新增语言start -->
<div id="languageModal" class="modal fade" tabindex="-1" data-width="400" data-backdrop="static">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		<h4 class="modal-title" id="position_title">新增语言</h4>
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div
					class="form-group form-md-line-input form-md-floating-label has-info">
					<input type="text" class="form-control" id="languagename"
						name="languagename"> <label for="languagename">语言名称</label>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>

		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div
					class="form-group form-md-line-input form-md-floating-label has-info">
					<select class="form-control edited" id="languageEng" name="languageEng">
						<option value="CN">中文</option>
						<option value="US">英语</option>
					</select> 
					<label for="languageEng">语种类型</label>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div
					class="form-group form-md-line-input form-md-floating-label has-info">
					<select class="form-control edited" id="hotLanguageId" name="hotLanguageId">
						<option value="0">是</option>
						<option value="1">否</option>
					</select> 
					<label for="hotLanguageId">热门语言</label>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>

	<div class="modal-footer row">
		<div class="col-md-3"></div>
		<div class="col-md-3 center">
			<button type="submit" class="btn blue" onclick="save();">保存</button>
		</div>
		<div class="col-md-3 center">
			<button type="button" data-dismiss="modal"
				class="btn btn-outline dark" onclick="">取消</button>
		</div>
		<div class="col-md-3"></div>
	</div>
</div>
<!-- 新增语言 end -->