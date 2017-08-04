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
							地区管理 <small>地区管理</small>
						</h1>
					</div>
					<!-- END PAGE TITLE -->
					<!-- BEGIN PAGE TOOLBAR -->

					<!-- END PAGE TOOLBAR -->
				</div>
				<!-- END PAGE HEAD-->
				<!-- BEGIN PAGE BREADCRUMB -->
				<ul class="page-breadcrumb breadcrumb">
					<li><a href="javascript:void(0);">地区管理</a> <i
						class="fa fa-circle"></i></li>
					<li><span class="active">地区管理</span></li>
				</ul>
				<!-- END PAGE BREADCRUMB -->
				<!-- BEGIN PAGE BASE CONTENT -->
				<div class="row">
					<div class="col-md-12">
						<!-- BEGIN SAMPLE TABLE PORTLET-->
						<div class="portlet light bordered">
							<div class="portlet-title">
								<div class="caption">
									<span class="caption-subject font-green bold uppercase">地区管理</span>
								</div>
								<div class="actions">
									<div class="btn-group btn-group-devided" data-toggle="buttons">
										<label
											class="btn btn-transparent blue btn-outline btn-circle btn-sm active"
											onclick="addParent();">新增上级地区 </label> <label
											class="btn btn-transparent blue btn-outline btn-circle btn-sm active"
											onclick="add();">新增地区</label>
									</div>
								</div>
							</div>
							<div class="portlet-body">
								<div class="table-scrollable">
									<table class="table table-hover">
										<thead>
											<tr>
												<th>地区名称</th>
												<th>语种类型</th>
												<th>上级地区名称</th>
												<th>语言名称</th>
												<th>热门城市</th>
												<!-- <th>操作</th> -->
											</tr>
										</thead>
										<tbody>
											<!-- 遍历数据 start -->
											<c:forEach items="${list}" var="list">
												<tr>
													<td>${list.areaname}</td>
													<td>${list.areaEng}</td>
													<td>${list.parentname}</td>
													<td>${list.languagename}</td>
													<td><c:if test="${list.hotcityid==0}">
															<font color="green">是</font>
														</c:if> <c:if test="${list.hotcityid==1}">
															<font color="red">否</font>
														</c:if></td>

													<!-- <td>
														<a href="javascript:;" class="btn btn-outline btn-circle dark btn-sm black">
                                                            <i class="fa fa-trash-o"></i> 删除 </a>
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
	<!-- modal start -->
	<script
		src="<%=request.getContextPath()%>/plugins/global/plugins/bootstrap-modal/js/bootstrap-modalmanager.js"
		type="text/javascript"></script>
	<script
		src="/gate/plugins/global/plugins/bootstrap-modal/js/bootstrap-modal.js"
		type="text/javascript"></script>
	<!-- modal end -->
	<!-- END THEME LAYOUT SCRIPTS -->



</body>


<script type="text/javascript">
		
		$(function(){
			//菜单选中样式添加
	        $(".page-sidebar-menu").children("li[name='area']").addClass("open");
	        $(".page-sidebar-menu").children("li[name='area']").children("li[name='areaList']").children("a").children("span[class='arrow']").addClass("open");
	        $(".page-sidebar-menu").children("li[name='area']").children("ul").children("li[name='areaList']").addClass("active");
	        $(".page-sidebar-menu").children("li[name='area']").children("ul").css("display","block");
			
		})
	
		/*
		 *进入审核页面
		 */
		function check(id){
			//alert(id);
			//window.location.href = "<%=request.getContextPath()%>/backstage/userAudit/auditExamine?auditid="+id;
		}


		/*
		 *	新增modal
		 */
		function add() {
			var url = "<%=request.getContextPath()%>/backstage/area/parentSelect";
			$.ajax({   
			    url:url,   
			    type:'post',   
			    error:function(){   
			       alert('网络异常');   
			    },   
			    success:function(json){ 
			    	json = eval('('+json+')');
					if(json.state==0){
						$("#parentArea").html(json.msg);
						var url = "<%=request.getContextPath()%>/backstage/area/languageSelect";
							$.ajax({   
							    url:url,   
							    type:'post',   
							    error:function(){   
							       alert('网络异常');   
							    },   
							    success:function(json){ 
							    	json = eval('('+json+')');
									if(json.state==0){
										$("#childLanguage").html(json.msg);
										$("#areaModal").modal();
									}else{
										alert('获取语言失败');   
									}
							    }
							});	
					}else{
						alert('获取语言失败');   
					}
			    }
			});	
		}

	function addParent() {
		var url = "<%=request.getContextPath()%>/backstage/area/languageSelect";
		$.ajax({   
		    url:url,   
		    type:'post',   
		    error:function(){   
		       alert('网络异常');   
		    },   
		    success:function(json){ 
		    	json = eval('('+json+')');
				if(json.state==0){
					$("#languageid").html(json.msg);
					$("#areaParentModal").modal();
				}else{
					alert('获取语言失败');   
				}
		    }
		});	
		
	}

	function save() {
		var areaChildName = $("#areaChildName").val();
		var parentArea = $("#parentArea").val();
		var childLanguage = $("#childLanguage").val();
		var hotcity = $("#hotcity").val();
		var url = "<%=request.getContextPath()%>/backstage/area/add";		
		if(areaChildName==''){
			$("#areaChildName").focus();
			return;
		}
		if(parentArea==0){
			$("#parentArea").focus();
			return;
		}
		if(childLanguage==0){
			$("#childLanguage").focus();
			return;
		}
		if(hotcity==''){
			$("#hotcity").focus();
			return;
		}
		//URI编码一次
		areaChildName = encodeURI(areaChildName);
		
		$.ajax({   
		    url:url,   
		    type:'get',
		    data:{"areaChildName":areaChildName,"parentArea":parentArea,"childLanguage":childLanguage,"hotcity":hotcity},
		    error:function(){   
		       alert('网络异常');   
		    },   
		    success:function(json){ 
		    	json = eval('('+json+')');
				if(json.state==0){
					window.location.href = "<%=request.getContextPath()%>/backstage/area/areaList";
				}else{
					alert(json.msg);   
				}
		    }
		});
	}
	
	/*
	 *	新增父级地区
	 */
	function saveParent(){
		var languageid = $("#languageid").val();
		var areaname = $("#areaname").val();
		if(languageid==0){
			$("#languageid").focus();
			return;
		}
		if(areaname==''){
			$("#areaname").focus();
			return;
		}
		//URI编码一次
		languageid = encodeURI(languageid);
		areaname = encodeURI(areaname);
		
		var url = "<%=request.getContextPath()%>/backstage/area/addParent";
		$.ajax({   
		    url:url,   
		    type:'get',
		    data:{"languageid":languageid,"areaname":areaname},
		    error:function(){   
		       alert('网络异常');   
		    },   
		    success:function(json){ 
		    	json = eval('('+json+')');
				if(json.state==0){
					window.location.href = "<%=request.getContextPath()%>/backstage/area/areaList";
				}else{
					alert(json.msg);   
				}
		    }
		});
	}
</script>


</html>
<!-- 新增上级地区 start -->
<div id="areaParentModal" class="modal fade" tabindex="-1" data-width="400" data-backdrop="static">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
		<h4 class="modal-title" id="position_title">新增上级地区</h4>
	</div>
	<div class="modal-body">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div
					class="form-group form-md-line-input form-md-floating-label has-info">
					<input type="text" class="form-control" id="areaname"
						name="areaname"> <label for="areaname">地区名称</label>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>

		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div
					class="form-group form-md-line-input form-md-floating-label has-info">
					<select class="form-control edited" id="languageid" name="languageid">
						<option></option>
					</select> 
					<label for="languageid">语言名称</label>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	
	</div>

	<div class="modal-footer row">
		<div class="col-md-3"></div>
		<div class="col-md-3 center">
			<button type="submit" class="btn blue" onclick="saveParent();">保存</button>
		</div>
		<div class="col-md-3 center">
			<button type="button" data-dismiss="modal"
				class="btn btn-outline dark" onclick="">取消</button>
		</div>
		<div class="col-md-3"></div>
	</div>
</div>
<!-- 新增上级地区 end -->

<!-- 新增地区 start -->
<div id="areaModal" class="modal fade" tabindex="-1" data-width="400"
	data-backdrop="static">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true" "></button>
		<h4 class="modal-title" id="_title">新增地区</h4>
	</div>
		<div class="modal-body">
			<div class="row">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<div
						class="form-group form-md-line-input form-md-floating-label has-info">
						<input type="text" class="form-control" id="areaChildName"
							name="areaChildName"> <label for="areaChildName">地区名称</label>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>
			
			<div class="row">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<div
						class="form-group form-md-line-input form-md-floating-label has-info">
						<select class="form-control edited" id="parentArea">
							<option value=""></option>
						</select> <label for="parentArea">上级地区名称</label>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>

			<div class="row">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<div
						class="form-group form-md-line-input form-md-floating-label has-info">
						<select class="form-control edited" id="childLanguage">
							<option value=""></option>
						</select> <label for="childLanguage">语言名称</label>
					</div>
				</div>
				<div class="col-md-2"></div>
			</div>

			<div class="row">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					<div
						class="form-group form-md-line-input form-md-floating-label has-info">
						<select class="form-control edited" id="hotcity">
							<option value="0" selected="selected">是</option>
							<option value="1">否</option>
						</select> <label for="hotcity">热门城市</label>
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
<!-- 新增地区 end -->