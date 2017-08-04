<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp" />
<link href="${STATIC_URL}/scripts/datepicker/css/datepicker3.css" rel="stylesheet" type="text/css"/>
<script src="${STATIC_URL}/scripts/datepicker/js/bootstrap-datepicker.js"></script>
<script src="${STATIC_URL}/scripts/datepicker/js/locales/bootstrap-datepicker.zh-CN.time.js" charset="UTF-8"></script>
<script src="${STATIC_URL}/scripts/ajaxfileupload.js"></script>
<script type="text/javascript">
<!--
	$(document).ready(function() {
		$('.datepicker-input').datepicker();
		$(".input-submit").click(function() {
			var submit_type = $(this).attr("data_submit_type");
			switch (submit_type) {
			case 'submit_save':
				submit_save();
				break; //保存
			case 'submit_cancel':
				submit_cancel();
				break; //返回
			}
		});
	});

	/**
	 * 取消处理
	 */
	function submit_cancel() {
		location.href = "${BASE_URL}/background/useraudit/auditindex";
	}
	
	//保存
	function submit_save() {
		notice("form_notice", img_loading_small, false);
		var name_ = $("#name").val();
		if(name_ == "") {
			notice("form_notice", "姓名不可为空", true, 3000);
			$("#name").focus();
			return;
		}
		var sex_ = $("input[name='sex']:checked").val();
		if(sex_ == undefined) {
			notice("form_notice", "请填写性别", true, 3000);
			$(".sex_class").focus();
			return;
		}
		var age_ = $("#age").val();
		if(age_ == undefined) {
			notice("form_notice", "请选择年龄", true, 3000);
			$("#age").focus();
			return;
		}
		var education_ = $("input[name='education']:checked").val();
		if(education_ == undefined) {
			notice("form_notice", "请选择学历", true, 3000);
			$(".education_class").focus();
			return;
		}
		var specialtyid_ = $("input[name='specialtyid']:checked").val();
		if(specialtyid_ == undefined) {
			notice("form_notice", "请选择专业", true, 3000);
			$(".specialtyid_class").focus();
			return;
		}
		var languageid_ = $("input[name='languageid']:checked").val();
		if(languageid_ == undefined) {
			notice("form_notice", "请选择语种", true, 3000);
			$(".languageid_class").focus();
			return;
		}
		var countryid_ = $("input[name='countryid']:checked").val();
		if(countryid_ == undefined) {
			notice("form_notice", "请选择国家", true, 3000);
			$(".countryid_class").focus();
			return;
		}
		var provinceid_ = $("input[name='provinceid']:checked").val();
		if(provinceid_ == undefined) {
			notice("form_notice", "请选择省或州", true, 3000);
			$(".provinceid_class").focus();
			return;
		}
		var cityid_ = $("input[name='cityid']:checked").val();
		if(cityid_ == undefined) {
			notice("form_notice", "请选择市", true, 3000);
			$(".cityid_class").focus();
			return;
		}
		var school_ = $("#school").val();
		if(school_ == "") {
			notice("form_notice", "毕业学校不可为空", true, 3000);
			$("#school").focus();
			return;
		}
		var idcardno_ = $("#idcardno").val();
		if(idcardno_ == "") {
			notice("form_notice", "身份证号不可为空", true, 3000);
			$("#idcardno").focus();
			return;
		}
		var level_ = $("input[name='level']:checked").val();
		if(level_ == undefined) {
			notice("form_notice", "请选择等级", true, 3000);
			$(".level_class").focus();
			return;
		}
		var birthdayau = $("#birthdayau").val();
		if(birthdayau == "") {
			notice("form_notice", "出生年月不可为空", true, 3000);
			$("#idcardno").focus();
			return;
		}
		var origin = $("#origin").val();
		if(origin == "") {
			notice("form_notice", "籍贯不可为空", true, 3000);
			$("#origin").focus();
			return;
		}
		var phone = $("#phone").val();
		if(phone == "") {
			notice("form_notice", "手机号不可为空", true, 3000);
			$("#phone").focus();
			return;
		} else {
			if(!/^\+?[1-9][0-9]*$/.test(phone)){
				notice("form_notice", "请输入正确的手机号", true, 3000);
				$("#phone").focus();
				return;
			}
		}
		var passporturl_ = $("#passporturl").val();
		if(passporturl_ == "") {
			notice("form_notice", "请上传护照图片", true, 3000);
			$("#images_2").focus();
			return;
		}
		var visaurl_ = $("#visaurl").val();
		if(visaurl_ == "") {
			notice("form_notice", "请上传签证图片", true, 3000);
			$("#images_4").focus();
			return;
		}
		var studentupurl_ = $("#studentupurl").val();
		//if(studentupurl_ == "") {
		//	notice("form_notice", "请上传学生证图片", true, 3000);
		//	$("#images_6").focus();
		//	return;
		//}
		var studentdownurl_ = $("#studentdownurl").val();
		//if(studentdownurl_ == "") {
		//	notice("form_notice", "请上传外语等级证明图片", true, 3000);
		//	$("#images_8").focus();
		//	return;
		//}
		$(".input-submit").attr('disabled', true);
		$.ajax({
			type : "post",
			url : "${BASE_URL}/background/useraudit/save",
			data : {
					auditid : '${auditid}',
					name : name_,
					sex : sex_,
					age : age_,
					education : education_,
					specialtyid : specialtyid_,
					languageid : languageid_,
					countryid : countryid_,
					provinceid : provinceid_,
					cityid : cityid_,
					school : school_,
					idcardno : idcardno_,
					level : level_,
					passporturl : passporturl_,
		        	passporturlmin : $("#passporturlmin").val(),
		        	visaurl : visaurl_,
		        	visaurlmin : $("#visaurlmin").val(),
		        	studentupurl : studentupurl_,
		        	studentupurlmin : $("#studentupurlmin").val(),
		        	studentdownurl : studentdownurl_,
		        	studentdownurlmin : $("#studentdownurlmin").val(),
		        	remark : $("#remark").val(),
		        	birthdayaunew:$("#birthdayau").val(),
		        	origin:$("#origin").val(),
		        	phone:$("#phone").val()
				   },
			dataType : 'json',
			success : function (data) {
				if(data.status == 0) {
					alert("操作成功");
					submit_cancel();
				} else {
					$(".input-submit").attr('disabled', false);
					notice("form_notice", data.msg, true, 3000);
				}
			},
			error : function () {
				$(".input-submit").attr('disabled', false);
				notice("form_notice", "操作失败", true, 3000);
			}
		});
	}
	function getChildListByParentId(areaid, type) {
		$.ajax({
			type : "post",
			url : "${BASE_URL}/background/area/getChildListByParentId/" + areaid, 
			dataType : 'json',
			success : function (data) {
				if(type == 1) {
					$(".province").empty();
					$(".city").empty();
					$(".provinceValue").empty();
					$(".cityValue").empty();
					$(".province").html("请选择");
					$(".city").html("请选择");
				} else if(type == 2) {
					$(".city").empty();
					$(".cityValue").empty();
					$(".city").html("请选择");
				}
				$.each(data, function(i, value) {
					if(type == 1) {
						$(".provinceValue").append("<li onclick=\"getChildListByParentId(" + value.areaid + ",2)\"><a href=\"#\"><input type=\"radio\" name=\"provinceid\" value=\"" +
							value.areaid + "\">" + value.areaname + "</a></li>");
					} else if(type == 2) {
						$(".cityValue").append("<li><a href=\"#\"><input type=\"radio\" name=\"cityid\" value=\"" +
							value.areaid + "\">" + value.areaname + "</a></li>");
					}
		        });  
			}
		});
	}
	var fileTag_1 = true;
	var fileTag_2 = true;
	var fileTag_3 = true;
	var fileTag_4 = true;
	function uploadpic(obj) {
		var objid = obj.id;
		notice("form_notice", img_loading_small, false);
		var s = $(obj).val();
		var stuff = s.substr(Number(s.lastIndexOf(".")) + Number(1)).toLowerCase();
		var type = "gif,jpg,jpeg,png";
		if(type.indexOf(stuff) < 0) {
			notice("form_notice", "只能上传" + type + "类型的图片文件", true, 5000);
			$(obj).focus();
			return false;
		}
		if(objid == "fileid_1") {
       		fileTag_1 = false;
       	}
       	if(objid == "fileid_2") {
       		fileTag_2 = false;
       	}
       	if(objid == "fileid_3") {
       		fileTag_3 = false;
       	}
       	if(objid == "fileid_4") {
       		fileTag_4 = false;
       	}
		$(".input-submit").attr('disabled', true);
		$.ajaxFileUpload({
	        url: '${BASE_URL}/background/useraudit/uploadCert',
	        secureuri : false,
	        fileElementId : obj.id,
	        dataType : "text",
	        type : "POST",
	        success : function (data) {
	        	data = eval("(" + data + ")");
	        	if(data.status == 0) {
		        	if(objid == "fileid_1") {
		        		$("#images_1").attr("href", data.data.img_url + data.data.image);
		        		$("#images_2").attr("src", data.data.img_url + data.data.imagemin);
		        		$("#passporturl").val(data.data.image);
		        		$("#passporturlmin").val(data.data.imagemin);
		        		fileTag_1 = true;
		        		notice("form_notice", "护照图片上传成功", true, 5000);
		        	}
		        	if(objid == "fileid_2") {
		        		$("#images_3").attr("href", data.data.img_url + data.data.image);
		        		$("#images_4").attr("src", data.data.img_url + data.data.imagemin);
		        		$("#visaurl").val(data.data.image);
		        		$("#visaurlmin").val(data.data.imagemin);
		        		fileTag_2 = true;
		        		notice("form_notice", "签证图片上传成功", true, 5000);
		        	}
		        	if(objid == "fileid_3") {
		        		$("#images_5").attr("href", data.data.img_url + data.data.image);
		        		$("#images_6").attr("src", data.data.img_url + data.data.imagemin);
		        		$("#studentupurl").val(data.data.image);
		        		$("#studentupurlmin").val(data.data.imagemin);
		        		fileTag_3 = true;
		        		notice("form_notice", "学生证上传成功", true, 5000);
		        	}
		        	if(objid == "fileid_4") {
		        		$("#images_7").attr("href", data.data.img_url + data.data.image);
		        		$("#images_8").attr("src", data.data.img_url + data.data.imagemin);
		        		$("#studentdownurl").val(data.data.image);
		        		$("#studentdownurlmin").val(data.data.imagemin);
		        		fileTag_4 = true;
		        		notice("form_notice", "外语等级证明上传成功", true, 5000);
		        	}
		        	if(data != null && data != '' && data != "null") {
		        		$("#headimg").attr("src", data);
		        		$("#headurl").val(data);
		        	}
		        	if(fileTag_1 && fileTag_2 && fileTag_3 && fileTag_4) {
		        		$(".input-submit").attr('disabled', false);
		        	} else {
		        		notice("form_notice", img_loading_small, false);
		        	}
	        	} else {
	        		notice("form_notice", data.msg, true, 5000);
	        	}
	        },
	        error:function(d) {
	        	notice("form_notice", "图片上传失败", true, 5000);
	        	$(".input-submit").attr('disabled', false);
	        }
	    });
	}
//-->
</script>
<section class="hbox stretch">
	<aside class="aside-md bg-white b-r">
		<section class="vbox">
			<header class="b-b header">
				<p class="h4">编辑翻译信息</p>
			</header>
			<section class="scrollable wrapper w-f">
				<form class="form-horizontal" id="form_pass" action="" method="POST">
					<div class="form-group">
						<label class="col-sm-2 control-label">姓名：</label>
						<div class="col-sm-4">
							<input type="text" id="name" class="input-sm form-control" value="${userAudit.name}">
						</div>
						<label class="col-sm-1 control-label">性别：</label>
						<div class="col-sm-5">
							<div class="btn-group m-r">
		                       	<button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle sex_class">
		                        <span class="dropdown-label">
		                         	<c:if test="${empty userAudit.sex}">选择性别</c:if>
		                         	<c:if test="${userAudit.sex eq 1}">男</c:if>
		                         	<c:if test="${userAudit.sex eq 2}">女</c:if>
		                         </span> 
		                         <span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select">
		                           <li <c:if test="${userAudit.sex eq 1}">class="active"</c:if>><a href="#"><input type="radio" name="sex" value="1" <c:if test="${userAudit.sex eq 1}">checked="checked"</c:if>>男</a></li>
		                           <li <c:if test="${userAudit.sex eq 2}">class="active"</c:if>><a href="#"><input type="radio" name="sex" value="2" <c:if test="${userAudit.sex eq 2}">checked="checked"</c:if>>女</a></li>
		                       </ul>
		                     </div>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">学历：</label>
						<div class="col-sm-4">
							<div class="btn-group m-r">
		                       	<button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle education_class">
		                         	<span class="dropdown-label">
			                         	<c:if test="${empty userAudit.education}">选择学历</c:if>
			                         	<c:if test="${userAudit.education eq 1}">本科</c:if>
			                         	<c:if test="${userAudit.education eq 2}">硕士</c:if>
			                         	<c:if test="${userAudit.education eq 3}">博士</c:if>
			                         	<c:if test="${userAudit.education eq 4}">高中</c:if>
		                         	</span> 
		                         	<span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select">
		                           <li <c:if test="${userAudit.education eq 1}">class="active"</c:if>><a href="#"><input type="radio" name="education" value="1" <c:if test="${userAudit.education eq 1}">checked="checked"</c:if>>本科</a></li>
		                           <li <c:if test="${userAudit.education eq 2}">class="active"</c:if>><a href="#"><input type="radio" name="education" value="2" <c:if test="${userAudit.education eq 2}">checked="checked"</c:if>>硕士</a></li>
		                           <li <c:if test="${userAudit.education eq 3}">class="active"</c:if>><a href="#"><input type="radio" name="education" value="3" <c:if test="${userAudit.education eq 3}">checked="checked"</c:if>>博士</a></li>
		                           <li <c:if test="${userAudit.education eq 4}">class="active"</c:if>><a href="#"><input type="radio" name="education" value="4" <c:if test="${userAudit.education eq 4}">checked="checked"</c:if>>高中</a></li>
		                       </ul>
		                     </div>
						</div>
						<label class="col-sm-1 control-label">专业：</label>
						<div class="col-sm-5">
							<div class="btn-group m-r">
		                       <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle specialtyid_class">
		                         <span class="dropdown-label">
		                         	<c:if test="${empty userAudit.specialtyid}">选择专业</c:if>
		                         	<c:forEach items="${specialtyList}" var="specialty">
		                         		<c:if test="${specialty.specialtyid eq userAudit.specialtyid}">${specialty.specialtyname}</c:if>
		                         	</c:forEach>
		                         </span> 
		                         <span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select">
		                       	   <c:forEach items="${specialtyList}" var="specialty">
			                           <li <c:if test="${userAudit.specialtyid eq specialty.specialtyid}">class="active"</c:if>><a href="#"><input type="radio" name="specialtyid" value="${specialty.specialtyid}" <c:if test="${userAudit.specialtyid eq specialty.specialtyid}">checked="checked"</c:if>>${specialty.specialtyname}</a></li>
		                       	   </c:forEach>
		                       </ul>
		                     </div>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">语种：</label>
						<div class="col-sm-4">
							<div class="btn-group m-r">
		                       <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle languageid_class">
		                         <span class="dropdown-label">
		                         	<c:if test="${empty userAudit.languageid}">选择语种</c:if>
		                         	<c:forEach items="${languageList}" var="language">
		                         		<c:if test="${language.languageid eq userAudit.languageid}">${language.languagename}</c:if>
		                         	</c:forEach>
		                         </span> 
		                         <span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select">
		                       	   <c:forEach items="${languageList}" var="language">
			                           <li <c:if test="${userAudit.languageid eq language.languageid}">class="active"</c:if>><a href="#"><input type="radio" name="languageid" value="${language.languageid}" <c:if test="${userAudit.languageid eq language.languageid}">checked="checked"</c:if>>${language.languagename}</a></li>
		                       	   </c:forEach>
		                       </ul>
		                     </div>
						</div>
						<label class="col-sm-1 control-label">区域：</label>
						<div class="col-sm-5">
							<div class="btn-group m-r">
		                       <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle countryid_class">
		                         <span class="dropdown-label country">
		                         	<c:if test="${empty userAudit.countryid}">选择国家</c:if>
		                         	<c:forEach items="${areaList}" var="area">
		                         		<c:if test="${area.areaid eq userAudit.countryid}">${area.areaname}</c:if>
		                         	</c:forEach>
		                         </span> 
		                         <span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select">
		                       	   <c:forEach items="${areaList}" var="area">
		                       	   	   <c:if test="${area.parentid eq 0}">
				                           <li <c:if test="${userAudit.countryid eq area.areaid}">class="active"</c:if> onclick="getChildListByParentId(${area.areaid},1)"><a href="#"><input type="radio" name="countryid" value="${area.areaid}" <c:if test="${userAudit.countryid eq area.areaid}">checked="checked"</c:if>>${area.areaname}</a></li>
		                       	   	   </c:if>
		                       	   </c:forEach>
		                       </ul>
		                     </div>
		                     <div class="btn-group m-r">
		                       <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle provinceid_class">
		                         <span class="dropdown-label province">
		                         	<c:if test="${empty userAudit.provinceid}">选择省或州</c:if>
		                         	<c:forEach items="${areaList}" var="area">
		                         		<c:if test="${area.areaid eq userAudit.provinceid}">${area.areaname}</c:if>
		                         	</c:forEach>
		                         </span> 
		                         <span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select provinceValue">
		                       	   <c:forEach items="${areaList}" var="area">
			                       	   <c:if test="${area.parentid eq userAudit.countryid}">
				                           <li <c:if test="${userAudit.provinceid eq area.areaid}">class="active"</c:if> onclick="getChildListByParentId(${area.areaid},2)"><a href="#"><input type="radio" name="provinceid" value="${area.areaid}" <c:if test="${userAudit.provinceid eq area.areaid}">checked="checked"</c:if>>${area.areaname}</a></li>
		                       	   	   </c:if>
	                       	   	   </c:forEach>
		                       </ul>
		                     </div>
		                     <div class="btn-group m-r">
		                       <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle cityid_class">
		                         <span class="dropdown-label city">
		                         	<c:if test="${empty userAudit.cityid}">选择市</c:if>
		                         	<c:forEach items="${areaList}" var="area">
		                         		<c:if test="${area.areaid eq userAudit.cityid}">${area.areaname}</c:if>
		                         	</c:forEach>
		                         </span> 
		                         <span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select cityValue">	
		                       	   <c:forEach items="${areaList}" var="area">
			                       	   <c:if test="${area.parentid eq userAudit.provinceid}">
				                           <li <c:if test="${userAudit.cityid eq area.areaid}">class="active"</c:if>><a href="#"><input type="radio" name="cityid" value="${area.areaid}" <c:if test="${userAudit.cityid eq area.areaid}">checked="checked"</c:if>>${area.areaname}</a></li>
		                       	   	   </c:if>
	                       	   	   </c:forEach>
		                       </ul>
		                     </div>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">年龄：</label>
						<div class="col-sm-4">
							<input type="text" id="age" class="input-sm form-control" value="${userAudit.age}">
						</div>
						<label class="col-sm-1 control-label">等级：</label>
						<div class="col-sm-5">
	                       	<div class="btn-group m-r">
		                       <button data-toggle="dropdown" class="btn btn-sm btn-default dropdown-toggle level_class">
		                         <span class="dropdown-label">
		                         	<c:if test="${empty userAudit.level}">选择等级</c:if>
		                         	<c:if test="${userAudit.level eq 2}">口译员</c:if>
		                         	<c:if test="${userAudit.level eq 3}">高级口译员</c:if>
		                         </span> 
		                         <span class="caret"></span>
		                       </button>
		                       <ul class="dropdown-menu dropdown-select">
		                           <li <c:if test="${userAudit.level eq 2}">class="active"</c:if>><a href="#"><input type="radio" name="level" <c:if test="${userAudit.level eq 2}">checked="checked"</c:if> value="2">口译员</a></li>
		                           <li <c:if test="${userAudit.level eq 3}">class="active"</c:if>><a href="#"><input type="radio" name="level" <c:if test="${userAudit.level eq 3}">checked="checked"</c:if> value="3">高级口译员</a></li>
		                       </ul>
		                     </div>
	                     </div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">出生年月：</label>
						<div class="col-sm-4">
							<input type="text" id="birthdayau" class="input-sm input-s datepicker-input form-control" data-date-format="yyyy-mm-dd" value="${birthdayau}">
						</div>
						<label class="col-sm-1 control-label">籍贯：</label>
						<div class="col-sm-4">
	                       	<input type="text" id="origin" class="input-sm form-control" value="${userAudit.origin}" maxlength="40">
	                     </div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">手机号：</label>
						<div class="col-sm-4">
	                       	<input type="text" id="phone" class="input-sm form-control" value="${userAudit.phone}" maxlength="11">
	                     </div>
						<label class="col-sm-1 control-label">护照号：</label>
						<div class="col-sm-4">
							<input type="text" id="idcardno" class="input-sm form-control" value="${userAudit.idcardno}">
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">毕业学校：</label>
						<div class="col-sm-8">
							<input type="text" id="school" class="input-sm form-control" value="${userAudit.school}">
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group">
						<label class="col-sm-2 control-label">个人简介：</label>
						<div class="col-sm-8">
							<textarea id="remark" style="width: 90%;height: 120px;">${userAudit.remark}</textarea>
						</div>
					</div>
					<div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group col-md-12">
                        <div class="col-md-6">
                        	<label>护照图片</label>
	    					<a id="images_1" <c:if test="${!empty userAudit.passporturl}">href="${IMG_URL}${userAudit.passporturl}"</c:if> class="thumbnail" target="_blank">
	    						<c:choose>
	    							<c:when test="${empty userAudit.passporturlmin}">
					                    <img id="images_2" title="请上传护照" src="view/static/panel/img/blank.png" class="img-rounded">
	    							</c:when>
	    							<c:otherwise>
					                    <img id="images_2" title="点击查看原图" src="${IMG_URL}${userAudit.passporturlmin}" class="img-rounded">
	    							</c:otherwise>
	    						</c:choose>
		                    </a>
		                    <input type="file" id="fileid_1" name="uploadFile" accept="image/*" onchange="uploadpic(this)" style="display: none;">
		                    <input type="text" id="passporturl" value="${userAudit.passporturl}" style="display: none;">
		                    <input type="text" id="passporturlmin" value="${userAudit.passporturlmin}" style="display: none;">
		                    <p class="text-center">
		                    	<a href="javascript:void(0)" class="btn btn-s-md btn-primary" onclick="fileid_1.click()">上&nbsp;&nbsp;&nbsp;传</a>
		                    </p>
	                    </div>
                        <div class="col-md-6">
                        	<label>签证图片</label>
	    					<a id="images_3" <c:if test="${!empty userAudit.visaurl}">href="${IMG_URL}${userAudit.visaurl}"</c:if> class="thumbnail" target="_blank">
	    						<c:choose>
	    							<c:when test="${empty userAudit.visaurlmin}">
					                    <img id="images_4" title="请上传签证" src="view/static/panel/img/blank.png" class="img-rounded">
	    							</c:when>
	    							<c:otherwise>
					                    <img id="images_4" title="点击查看原图" src="${IMG_URL}${userAudit.visaurlmin}" class="img-rounded">
	    							</c:otherwise>
	    						</c:choose>
		                    </a>
		                    <input type="file" id="fileid_2" name="uploadFile" accept="image/*" onchange="uploadpic(this)" style="display: none;">
		                    <input type="text" id="visaurl" value="${userAudit.visaurl}" style="display: none;">
		                    <input type="text" id="visaurlmin" value="${userAudit.visaurlmin}" style="display: none;">
		                    <p class="text-center">
		                    	<a href="javascript:void(0)" class="btn btn-s-md btn-primary" onclick="fileid_2.click()">上&nbsp;&nbsp;&nbsp;传</a>
		                    </p>
	                    </div>
	                </div>
	                <div class="line line-dashed line-lg pull-in"></div>
					<div class="form-group col-md-12">
                        <div class="col-md-6">
                        	<label>学生证图片</label>
	    					<a id="images_5" <c:if test="${!empty userAudit.studentupurl}">href="${IMG_URL}${userAudit.studentupurl}"</c:if> class="thumbnail" target="_blank">
	    						<c:choose>
	    							<c:when test="${empty userAudit.studentupurlmin}">
					                    <img id="images_6" title="学生证图片" src="view/static/panel/img/blank.png" class="img-rounded">
	    							</c:when>
	    							<c:otherwise>
					                    <img id="images_6" title="点击查看原图" src="${IMG_URL}${userAudit.studentupurlmin}" class="img-rounded">
	    							</c:otherwise>
	    						</c:choose>
		                    </a>
		                    <input type="file" id="fileid_3" name="uploadFile" accept="image/*" onchange="uploadpic(this)" style="display: none;">
		                    <input type="text" id="studentupurl" value="${userAudit.studentupurl}" style="display: none;">
		                    <input type="text" id="studentupurlmin" value="${userAudit.studentupurlmin}" style="display: none;">
		                    <p class="text-center">
		                    	<a href="javascript:void(0)" class="btn btn-s-md btn-primary" onclick="fileid_3.click()">上&nbsp;&nbsp;&nbsp;传</a>
		                    </p>
	                    </div>
                        <div class="col-md-6">
                        	<label>外语等级证明图片</label>
	    					<a id="images_7" <c:if test="${!empty userAudit.studentdownurl}">href="${IMG_URL}${userAudit.studentdownurl}"</c:if> class="thumbnail" target="_blank">
	    						<c:choose>
	    							<c:when test="${empty userAudit.studentdownurlmin}">
					                    <img id="images_8" title="请上传外语等级证明图片" src="view/static/panel/img/blank.png" class="img-rounded">
	    							</c:when>
	    							<c:otherwise>
					                    <img id="images_8" title="点击查看原图" src="${IMG_URL}${userAudit.studentdownurlmin}" class="img-rounded">
	    							</c:otherwise>
	    						</c:choose>
		                    </a>
		                    <input type="file" id="fileid_4" name="uploadFile" accept="image/*" onchange="uploadpic(this)" style="display: none;">
		                    <input type="text" id="studentdownurl" value="${userAudit.studentdownurl}" style="display: none;">
		                    <input type="text" id="studentdownurlmin" value="${userAudit.studentdownurlmin}" style="display: none;">
		                    <p class="text-center">
		                    	<a href="javascript:void(0);" class="btn btn-s-md btn-primary" onclick="fileid_4.click();">上&nbsp;&nbsp;&nbsp;传</a>
		                    </p>
	                    </div>
					</div>
				</form>
			</section>
			<footer class="footer b-t bg-white-only">
				<div class="m-t-sm">
					<button type="button" data_submit_type="submit_save"
						class="btn btn-s-md btn-primary btn-sm input-submit">保&nbsp;&nbsp;&nbsp;&nbsp;存</button>
					<button type="button" data_submit_type="submit_cancel"
						class="btn btn-s-md btn-primary btn-sm input-submit">返&nbsp;&nbsp;&nbsp;&nbsp;回</button>
					<span id="form_notice" style="color: red;"></span>
				</div>
			</footer>
		</section>
	</aside>
</section>
<jsp:include page="/view/panel/wrapper.suffix.jsp" />