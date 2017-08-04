<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script type="text/javascript">
//<!--
$(document).ready(function() {
	refreshListing();
	$('body').delegate('.action_search', 'click', function() {
		$('#content_listing').datagrid('reload');
	});
	$('body').delegate('.action-refresh', 'click', function() {
		$('.form-inline')[0].reset();
		$('#content_listing').datagrid('reload');
	});
	$(".wrapper").css("margin-top", "45px");
});

function refreshListing() {
	/* fuelux datagrid */
	var DataGridDataSource = function(options) {
	    this._formatter = options.formatter;
	    this._columns = options.columns;
	    this._delay = options.delay;
	};
	DataGridDataSource.prototype = {
	    columns: function () {
	        return this._columns;
	    },
	    data: function (options, callback) {
	        var url = '${BASE_URL}/background/user/getTranList';
	        var self = this;
	        setTimeout(function () {
	            var data = $.extend(true, [], self._data);
	            $.ajax(url, {
	                data: {
	                	rstype : "json",
	                	pageIndex : options.pageIndex + 1,
	                    pageSize : options.pageSize,
	                    name : $("#name").val(),
	                    areaname:$("#areaname").val(),
	                    school : $("#school").val(),
	                    account : $("#account").val(),
	                    education : $('select[name=education]').val(),
	                    specialtyid : $('select[name=specialtyid]').val(),
	                    languageid : $('select[name=languageid]').val(),
	                    sex : $('select[name=sex]').val(),
	                    level : $('select[name=level]').val(),
	                    state : $('select[name=state]').val(),
	                    isfrozen:$('select[name=isfrozen]').val()
	                },
	                dataType: 'json',
	                async: true,
	                type: 'POST'
	            }).done(function (response) {
	            	var data = response.data.data;
                    if (! data) {
                    	return false;
                    }
                    var count = response.data.count;//设置data.total
                    var startIndex = options.pageIndex * options.pageSize;
                    var endIndex = startIndex + options.pageSize;
                    var end = (endIndex > count) ? count : endIndex;
                    var pages = Math.ceil(count / options.pageSize);
                    var page = options.pageIndex + 1;
                    var start = startIndex + 1;
                    if (self._formatter) self._formatter(data);
                    callback({data : data, start : start, end : end, count : count, pages : pages, page : page});
                }).fail(function (e) {

                });
	        }, self._delay);
	    }
	};
	
	$('#content_listing').datagrid({
	    dataSource: new DataGridDataSource({
	        columns: [
	            {
	                property: 'name',
	                label: '姓名',
	                sortable: false
	            },
	            {
	                property: 'invitation',
	                label: '推荐人',
	                sortable: false
	            },
	            {
	                property: 'account',
	                label: '邮箱',
	                sortable: false
	            },
	            {
	            	property: 'sex',
	            	label: '性别',
	            	sortable: false
	            },
	             {
	            	property: 'birthdayFormat',
	            	label: '出生年月',
	            	sortable: false
	            },
	            {
	            	property: 'areaname',
	            	label: '服务区域',
	            	sortable: false
	            },
	            {
	            	property: 'educations',
	            	label: '学历',
	            	sortable: false
	            },
	            {
	            	property: 'school',
	            	label: '毕业学校',
	            	sortable: false
	            },
	            {
	            	property: 'specialtyname',
	            	label: '专业',
	            	sortable: false
	            },
	            {
	            	property: 'languagename',
	            	label: '语种',
	            	sortable: false
	            },
	            {
	            	property: 'levels',
	            	label: '等级',
	            	sortable: false
	            },
	            {
	            	property: 'balance',
	            	label: '帐户余额',
	            	sortable: false
	            },
	            {
	            	property: 'isvip',
	            	label: '是否会员',
	            	sortable: false
	            },
	            {
	            	property: 'createtime',
	            	label: '注册时间',
	            	sortable: false
	            },
	            {
	                property: 'isexits',
	                label: '申请退出',
	                sortable: false
	            },
	            {
	                property: 'exitbalance',
	                label: '退出返还金额',
	                sortable: false
	            },
	            {
	                property: 'states',
	                label: '状态',
	                sortable: false
	            },
	            {
	                property: 'isfrozen',
	                label: '抢单冻结状态',
	                sortable: false
	            },
	             {
	            	property: 'idcardno',
	            	label: '身份证号',
	            	sortable: false
	            },
	            {
	                property: 'action',
	                label: '操作',
	                sortable: false
	            }
	        ],
	        formatter: function (items) {
	            $.each(items, function (index, item) {
	            	item.name = isBlankColumn(item.name);
	            	item.sex = isBlankColumn(item.sex);
	            	if(item.education == 1) {
	            		item.educations = "本科";
	            	} else if(item.education == 2) {
	            		item.educations = "硕士";
	            	} else if(item.education == 3) {
	            		item.educations = "博士";
	            	} else if(item.education == 4) {
	            		item.educations = "高中";
	            	} else {
	            		item.educations = isBlankColumn(item.education);
	            	}
	            	item.school = isBlankColumn(item.school);
	            	item.specialtyname = isBlankColumn(item.specialtyname);
	            	item.languagename = isBlankColumn(item.languagename);
	            	item.areaname = isBlankColumn(item.areaname);
	            	item.idcardno = isBlankColumn(item.idcardno);
	            	if(item.level == 1) {
	            		item.levels = "口译员";
	            	} else if(item.level == 2) {
	            		item.levels = "口译员";
	            	} else if(item.level == 3) {
	            		item.levels = "高级口译员";
	            	} else {
		            	item.levels = isBlankColumn(item.level);
	            	}
	            	if(isBlankColumn(item.price) == "--") {
		            	item.prices = isBlankColumn(item.price);
	            	} else {
	            		item.prices = item.price + "元/小时";
	            	}
            		if(item.sex == 1) {
            			item.sex = "男";
            		} else if(item.sex == 2) {
            			item.sex = "女";
            		}
            		if(item.state == 0) {
            			item.states = '<font color="green">未屏蔽</font>';
            		} else {
            			item.states = '<font color="red">已屏蔽</font>';
            		}
            		if(item.state == 0) {
	            		item.action = '<a href="javascript:openImg(' + item.userid + ',1)"><font color="blue"><u>证件</u></font></a><br><a href="javascript:updateState(' + item.userid + ',1)"><font color="blue"><u>屏蔽</u></font></a>';
            		} else {
            			item.action = '<a href="javascript:openImg(' + item.userid + ',1)"><font color="blue"><u>证件</u></font></a><br><a href="javascript:updateState(' + item.userid + ',0)"><font color="blue"><u>取消屏蔽</u></font></a>';
            		}
            		if(item.isexit == 0) {
            			item.isexits = "<font color=\"green\">未申请</font>";
            		} else if(item.isexit == 1) {
            			item.isexits = "<font color=\"red\">申请退出</font>";
            			item.action = item.action + '<br><a href="javascript:confirmExit(\'' + item.userid + '\',\'' + item.name + '\',\'' + item.exittime + '\',\'' + item.exitpaytype + '\',\'' + item.exitpayaccount + '\')"><font color="red"><u>确认退出</u></font></a>';
            		} else if(item.isexit == 2) {
            			item.isexits = "<font color=\"red\">已退出</font>";
            		}
            		if(item.isfrozen=="0") {
            			item.action+='<br><a href="javascript:updateIsFro(\'' + item.userid + '\')"><font color="blue"><u>解冻</u></font></a>';
            		}
            		if(item.isfrozen=="0") {
            			item.isfrozen="冻结";
            		} else if(item.isfrozen=="1") {
            			item.isfrozen="未冻结";
            		} else if(item.isfrozen=="2") {
            			item.isfrozen="可抢单一次";
            		}
	            });
	        }
	    }),
	    loadingHTML: '<span><img src="${STATIC_URL}/panel/img/loading.gif"><i class="fa fa-info-sign text-muted" "></i>正在加载……</span>',
	    itemsText: '项',
	    itemText: '项',
	    dataOptions: {pageIndex: 0, pageSize: 15}	
	});
}
function updateState(userid, state) {
	var msg = "";
	if(state == 0) {
		msg = "取消屏蔽";
	} else {
		msg = "屏蔽";
	}
	if(confirm("确认【" + msg + "】所选用户吗？")) {
		$.ajax({
			type : "post",
			url : "${BASE_URL}/background/user/updateState", 
			data:{userid : userid, state : state}, 
			dataType : 'json',
			success : function (data) {
				if(data.status == 0) {
					alert(msg + "成功");
					$('#content_listing').datagrid('reload');
				} else {
					alert(msg + "失败");
				}
			},
			error : function () {
				alert(msg + "失败");
			}
		});
	}
}
function openImg(userid) {
	$.ajax({
		type : "post",
		url : "${BASE_URL}/background/user/getImages/" + userid, 
		dataType : 'json',
		success : function (data) {
			if(data.data != null) {
				if(data.data.passporturl == null || data.data.passporturl == "") {
					$("#images_1").hide();
				} else {
					$("#images_1").show();
					$("#images_1").attr("href", '${IMG_URL}' + data.data.passporturl);
					$("#images_2").attr("src", '${IMG_URL}' + data.data.passporturlmin);
				}
				if(data.data.visaurl == null || data.data.visaurl == "") {
					$("#images_3").hide();
				} else {
					$("#images_3").show();
					$("#images_3").attr("href", '${IMG_URL}' + data.data.visaurl);
					$("#images_4").attr("src", '${IMG_URL}' + data.data.visaurlmin);
				}
				if(data.data.studentupurl == null || data.data.studentupurl == "") {
					$("#images_5").hide();
				} else {
					$("#images_5").show();
					$("#images_5").attr("href", '${IMG_URL}' + data.data.studentupurl);
					$("#images_6").attr("src", '${IMG_URL}' + data.data.studentupurlmin);
				}
				if(data.data.studentdownurl == null || data.data.studentdownurl == "") {
					$("#images_7").hide();
				} else {
					$("#images_7").show();
					$("#images_7").attr("href", '${IMG_URL}' + data.data.studentdownurl);
					$("#images_8").attr("src", '${IMG_URL}' + data.data.studentdownurl);
				}
			} else {
				$("#images_1").hide();
				$("#images_3").hide();
				$("#images_5").hide();
				$("#images_7").hide();
			}
			$("#myModal1").modal();
		}
	});
}
function confirmExit(userid, name, exittime, exitpaytype, exitpayaccount) {
	$("#userid").val(userid);
	$("#exitname").html(name);
	$("#exitpaytype").html(exitpaytype == 1 ? "微信" : "支付宝");
	$("#exitpayaccount").html(exitpayaccount);
	$("#exittime").html(exittime);
	$("#myModal").modal();
}
function btnSure() {
	if(confirm("确认【退出】所选用户吗？")) {
		$.ajax({
			type : "post",
			url : "${BASE_URL}/background/user/confirmExit/" + $("#userid").val(), 
			dataType : 'json',
			success : function (data) {
				if(data.status == 0) {
					alert("退出成功");
					$('#content_listing').datagrid('reload');
				} else {
					alert("退出失败");
				}
			},
			error : function () {
				alert("退出失败");
			}
		});
	}
}
function doExport() {
	window.location = "${BASE_URL}/background/user/transExport?account=" + $("#account").val() + "&name=" + $("#name").val() +
		"&state=" + $('select[name=state]').val() + "&school=" + $("#school").val() + "&education=" + $('select[name=education]').val() +
		"&specialtyid=" + $('select[name=specialtyid]').val() + "&languageid=" + $('select[name=languageid]').val() +
		"&sex=" + $('select[name=sex]').val() + "&level=" + $('select[name=level]').val() + "&state=" + $('select[name=state]').val();
}
function doButton() {
	if($(".button_show").html() == "展开") {
		$(".button_show").html("隐藏");
		$(".wrapper").css("margin-top", "90px");
		$(".hide_row").show();
	} else {
		$(".button_show").html("展开");
		$(".wrapper").css("margin-top", "45px");
		$(".hide_row").hide();
	}
}
//弹框
function updateIsFro(userid) {
	$("#userid").val(userid);
	$("#IsFroModal").modal();
}
//解冻
function updateFro() {
	if($("#balance").val()=="") {
		alert("账户余额不能为空");
		return false;
	}
	if(!/^[0-9]+(.[0-9]{1,2})?$/.test($("#balance").val())){
		alert("请输入正确的账户余额");
		return false;
	}
	window.top.location='${BASE_URL}/background/user/updatePro?userid='+$("#userid").val()+"&balance="+$("#balance").val();
}
//-->
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
	        <header class="header bg-white b-b clearfix">
		       	<form class="form-inline">
		        	<div class="row m-t-sm" >
			        	<div class="col-sm-12 m-b-xs">
		       				 <div class="form-group col-sm-2 m-b-xs">
		                       	<label class="control-label">姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名：</label>
		                       	<input style="width:150px" type="text" id="name" class="input-sm form-control">
		                     </div>
		                     <div class="form-group col-sm-2 m-b-xs">
		                     	<label class="control-label">服务区域：</label>
		                       	<input style="width:150px" type="text" id="areaname" class="input-sm form-control">
		                     </div>
		                     
		                     <div class="form-group col-sm-2 m-b-xs">
		                     	<label class="control-label">邮箱：</label>
		                       	<input style="width:150px" type="text" id="account" class="input-sm form-control">
		                     </div>
		                     
		                   	 <div class="form-group col-sm-2 m-b-xs">
		                    	<label class="control-label">学历：</label>
		                       	<select name="education" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<option value="1">本科</option>
		                       		<option value="2">硕士</option>
		                       		<option value="3">博士</option>
		                       	</select>
		                     </div>
		                      <div class="form-group col-sm-2 m-b-xs">
		                    	<label class="control-label">专业：</label>
		                       	<select name="specialtyid" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<c:forEach items="${specialtyList}" var="specialty">
			                       		<option value="${specialty.specialtyid}">${specialty.specialtyname}</option>
		                       		</c:forEach>
		                       	</select>
		                     </div>
						</div>
					</div>
					<div class="row m-t-sm hide_row" style="display: none">
						<div class="col-sm-12 m-b-xs">
      						 <div class="form-group col-sm-2 m-b-xs">
		                       	<label class="control-label">毕业学校：</label>
		                       	<input style="width:150px" type="text" id="school" class="input-sm form-control">
		                     </div>
		                     <div class="form-group col-sm-2 m-b-xs">
		                     	<label class="control-label">语种：</label>
		                       	<select name="languageid" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<c:forEach items="${languageList}" var="language">
		                       			<option value="${language.languageid}">${language.languagename}</option>
		                       		</c:forEach>
		                       	</select>
		                     </div>
		                   	 <div class="form-group col-sm-2 m-b-xs">
		                    	<label class="control-label">性别：</label>
		                       	<select name="sex" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<option value="1">男</option>
		                       		<option value="2">女</option>
		                       	</select>
		                     </div>
		                     <div class="form-group col-sm-2 m-b-xs">
		                    	<label class="control-label">等级：</label>
		                       	<select name="level" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<option value="1">初级</option>
		                       		<option value="2">中级</option>
		                       		<option value="3">高级</option>
		                       	</select>
		                     </div>
						</div>
					</div>
					<div class="row m-t-sm">
						<div class="col-sm-12 m-b-xs">
      						<div class="form-group col-sm-2 m-b-xs">
      							<label class="control-label">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label>
		                       	<select name="state" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<option value="0">未屏蔽</option>
		                       		<option value="1">屏蔽</option>
		                       	</select>
      						</div>
      						<div class="form-group col-sm-4 m-b-xs">
      							<label class="control-label">抢单冻结状态：</label>
		                       	<select name="isfrozen" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<option value="0">冻结</option>
		                       		<option value="1">未冻结</option>
		                       		<option value="2">可抢单一次</option>
		                       	</select>
      						</div>
      						<div class="form-group col-sm-6 m-b-xs"></div>
      						<div class="form-group col-sm m-b-xs">
		                       	<a class="btn btn-success action_search">
		                       		<i class="fa fa-search"></i>
		                       		查询
		                       	</a>
		                     </div>
		                     <div class="form-group col-sm m-b-xs">
		                       	<a class="btn btn-success action-refresh">
		                       		<i class="fa fa-refresh"></i>
		                       		重置
		                       	</a>
		                     </div>
		                     <div class="form-group col-sm m-b-xs">
		                        <a class="btn btn-info" href="javascript:void(0)" onclick="doExport()">
		                        	导出
		                        </a>
		                     </div>
		                     <div class="form-group col-sm m-b-xs">
		                        <a class="btn btn-info button_show" href="javascript:void(0)" onclick="doButton()">展开</a>
		                     </div>
		                 </div>
		        	</div>          
                </form>
	        </header>
            <section class="scrollable wrapper" style="margin-top: 90px;overflow:auto">
                <section class="panel panel-default" style="min-width: 2200px;">
                    <div class="table-responsive" style="min-width: 2200px;">
                        <table class="table table-bordered table-striped table-hover m-b-none datagrid" id="content_listing">
                            <thead />
                            <tfoot>
                                <tr>
                                    <th class="row">
                                        <div class="datagrid-footer-left col-sm-6 text-center-xs m-l-n">
                                            <div class="grid-controls m-t-sm">
                                                    <span>
                                                        <span class="grid-start"></span> -
                                                        <span class="grid-end"></span> （共
                                                        <span class="grid-count"></span>）
                                                    </span>
                                                <div class="select grid-pagesize dropup" data-resize="auto">
                                                    <button data-toggle="dropdown"
                                                            class="btn btn-sm btn-default dropdown-toggle">
                                                        <span class="dropdown-label"></span>
                                                        <span class="caret"></span>
                                                    </button>
                                                    <ul class="dropdown-menu">
                                                        <li data-value="5"><a href="#">5</a></li>
                                                        <li data-value="15" data-selected="true"><a href="#">15</a></li>
                                                        <li data-value="50"><a href="#">50</a></li>
                                                        <li data-value="100"><a href="#">100</a></li>
                                                    </ul>
                                                </div>
                                                <span>/页</span>
                                            </div>
                                        </div>
    
                                        <div class="datagrid-footer-right col-sm-6 text-right text-center-xs"
                                             style="display:none;">
                                            <div class="grid-pager m-r-n">
                                                <button type="button" class="btn btn-sm btn-default grid-prevpage"><i
                                                        class="fa fa-chevron-left"></i></button>
                                                <!--<span>页</span>-->
                                                <div class="inline">
                                                    <div class="input-group dropdown combobox">
                                                        <input class="input-sm form-control" type="text">
    
                                                        <div class="input-group-btn dropup">
                                                            <button class="btn btn-sm btn-default" data-toggle="dropdown"><i
                                                                    class="caret"></i></button>
                                                            <ul class="dropdown-menu pull-right"></ul>
                                                        </div>
                                                    </div>
                                                </div>
                                                <span>/ <span class="grid-pages"></span></span>
                                                <button type="button" class="btn btn-sm btn-default grid-nextpage"><i
                                                        class="fa fa-chevron-right"></i></button>
                                            </div>
                                        </div>
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </section>
            </section>
        </section>
    </aside>
</section>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content col-sm-12">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">用户申请退出</h4>
            </div>
            <div class="modal-body">
            	<section class="scrollable">
            		<div class="form-group">
						<div class="col-sm-12">
							姓名：<span id="exitname"></span>
						</div>
					</div>
					<BR>
            		<div class="form-group">
						<div class="col-sm-12">
							退款支付方式：<span id="exitpaytype"></span>
						</div>
					</div>
					<BR>
            		<div class="form-group">
						<div class="col-sm-12">
							退款支付账号：<span id="exitpayaccount"></span>
						</div>
					</div>
					<BR>
            		<div class="form-group">
						<div class="col-sm-12">
							申请时间：<span id="exittime"></span>
						</div>
					</div>
	            </section>
            </div>
            <div class="modal-footer">
            	<input type="hidden" id="userid" value="">
                <button type="button" class="btn btn-primary" onclick="btnSure()" data-dismiss="modal">已退款</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">查看证件</h4>
            </div>
            <div class="modal-body">
            	<div class="col-xs-12 col-md-12">
            		<div class="alert alert-info" role="alert" style="font-size: 14px;">护照照片</div>
            	</div>
            	<div class="col-xs-12 col-md-12">
					<a id="images_1" href="" class="thumbnail" target="_blank">
	                 	<img id="images_2" src="" title="护照照片" class="img-rounded">
	                </a>
               	</div>
               	<div class="line line-dashed line-lg pull-in"></div>
               	<div class="col-xs-12 col-md-12">
               		<div class="alert alert-info" role="alert" style="font-size: 14px;">签证照片</div>
               	</div>
            	<div class="col-xs-12 col-md-12">
					<a id="images_3" href="" class="thumbnail" target="_blank">
	                 	<img id="images_4" src="" title="签证照片" class="img-rounded">
	                </a>
               	</div>
               	<div class="line line-dashed line-lg pull-in"></div>
               	<div class="col-xs-12 col-md-12">
					<div class="alert alert-info" role="alert" style="font-size: 14px;">学生证正面照片</div>
				</div>
            	<div class="col-xs-12 col-md-12">
					<a id="images_5" href="" class="thumbnail" target="_blank">
	                 	<img id="images_6" src="" title="学生证正面照片" class="img-rounded">
	                </a>
               	</div>
               	<div class="line line-dashed line-lg pull-in"></div>
               	<div class="col-xs-12 col-md-12">
					<div class="alert alert-info" role="alert" style="font-size: 14px;">学生证反面面照片</div>
				</div>
            	<div class="col-xs-12 col-md-12">
					<a id="images_7" href="" class="thumbnail" target="_blank">
	                 	<img id="images_8" src="" title="学生证反面面照片" class="img-rounded">
	                </a>
               	</div>
               	<div class="line line-dashed line-lg pull-in"></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 解冻页面 -->
<form action="#" name="froForm" method="get">
	<div class="modal fade" id="IsFroModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		<div class="modal-dialog" role="document" align="center">
			<div class="modal-content" style="width: 300px;" align="left">
				<input type="hidden" name="userid" id="userid">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="exampleModalLabel">解冻</h4>
				</div>
				<div class="modal-body" >
					<div class="form-group">
						<table style="width: 100%">
							<tr>
								<td style="padding-top: 10px;">
									<label for="list_expresscode_modal_input" class="control-label">账户余额：</label>
								</td>
								<td>
									<input name="balance" id="balance" style="width: 150px;" class="form-control" type="text" maxlength="10" value="0"/>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-success" onclick="updateFro()">确认</button>
				</div>
			</div>
		</div>
	</div>
</form>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>