<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script type="text/javascript">
<!--
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
	    	pageIndex = options.pageIndex;
	    	pageSize = options.pageSize;
	        var url = '${BASE_URL}/background/useraudit/getAuditList';
	        var self = this;
	        setTimeout(function () {
	            var data = $.extend(true, [], self._data);
	            $.ajax(url, {
	                data: {
	                	rstype : "json",
	                	pageIndex : options.pageIndex + 1,
	                    pageSize : options.pageSize,
	                    name : $("#name").val(),
	                    school : $("#school").val(),
	                    account : $("#account").val(),
	                    areaname : $("#areaname").val(),
	                    education : $('select[name=education]').val(),
	                    specialtyid : $('select[name=specialtyid]').val(),
	                    languageid : $('select[name=languageid]').val(),
	                    sex : $('select[name=sex]').val(),
	                    level : $('select[name=level]').val(),
	                    auditstate : $('select[name=auditstate]').val()
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
	            	property: 'birthdayauFormat',
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
	            	property: 'createtime',
	            	label: '注册时间',
	            	sortable: false
	            },
	            {
	                property: 'auditstates',
	                label: '状态',
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
	            	if(item.level == 1) {
	            		item.levels = "初级";
	            	} else if(item.level == 2) {
	            		item.levels = "口译员";
	            	} else if(item.level == 3) {
	            		item.levels = "高级口译员";
	            	} else {
		            	item.levels = isBlankColumn(item.level);
	            	}
            		if(item.sex == 1) {
            			item.sex = "男";
            		} else if(item.sex == 2) {
            			item.sex = "女";
            		}
            		if(item.auditstate == 3) {
	            		item.auditstates = '<font color="green">' + audittxt[item.auditstate] + '</font>';
            		} else {
	            		item.auditstates = '<font color="red">' + audittxt[item.auditstate] + '</font>';
            		}
            		if(item.auditstate == 3) {
	            		item.action = '<a href="${BASE_URL}/background/useraudit/updatepage/' + item.auditid + '"><font color="blue"><u>编辑</u></font></a>';
            		} else {
            			item.action = '<a href="${BASE_URL}/background/useraudit/auditpage/' + item.auditid + '"><font color="blue"><u>审核</u></font></a><br><a href="${BASE_URL}/background/useraudit/updatepage/' + item.auditid + '"><font color="blue"><u>编辑</u></font></a>';
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
var audittxt = ["未填资料","审核中","审核不通过","审核通过","申请更新资料","更新资料审核不通过","更新资料审核通过"];
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
//-->
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
	        <header class="header bg-white b-b clearfix">
		       	<form class="form-inline">
		       		<div class="row m-t-sm">
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
		                       		<option value="2">口译员</option>
		                       		<option value="3">高级口译员</option>
		                       	</select>
		                     </div>
					    </div>
					</div>
		            <div class="row m-t-sm">
		                <div class="col-sm-12 m-b-xs">
      						<div class="form-group col-sm-2 m-b-xs">
		                    	<label class="control-label">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</label>
		                       	<select name="auditstate" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<option value="0">未填资料</option>
		                       		<option value="1">审核中</option>
		                       		<option value="2">审核不通过</option>
		                       		<option value="3">审核通过</option>
		                       	</select>
		                     </div>
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
		                        <a class="btn btn-info button_show" href="javascript:void(0)" onclick="doButton()">展开</a>
		                     </div>
               			</div>
               		</div>
	        	</form>
	        </header>
            <section class="scrollable wrapper" style="margin-top: 90px;overflow:auto">
                <section class="panel panel-default" style="width: 2000px;">
                    <div class="table-responsive" style="width: 2000px;">
                        <table class="table table-bordered table-striped table-hover m-b-none datagrid" id="content_listing">
                            <thead></thead>
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
<div>
     <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog">
             <div class="modal-content">
                 <div class="modal-header">
                     <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                     <h4 class="modal-title" id="myModalLabel">查看证件</h4>
                 </div>
                 <div class="modal-body">
                 	<div class="alert alert-info" role="alert" style="font-size: 18px;font-weight: bold;">身份证正面图片</div>
                 	<div class="col-xs-12 col-md-12">
    					<a id="images_1" href="" class="thumbnail" target="_blank">
		                    <img id="images_2" src="" title="身份证正面" class="img-rounded">
	                    </a>
                    </div>
                    <ul class="nav nav-list"> 
					     <li class="divider"></li>  
					</ul>
                    <div class="alert alert-info" role="alert" style="font-size: 18px;font-weight: bold;">身份证反面图片</div>
                 	<div class="col-xs-12 col-md-12">
    					<a id="images_3" href="" class="thumbnail" target="_blank">
		                    <img id="images_4" src="" title="身份证反面" class="img-rounded">
	                    </a>
                    </div>
                    <ul class="nav nav-list"> 
					     <li class="divider"></li>  
					</ul>
					<div class="alert alert-info" role="alert" style="font-size: 18px;font-weight: bold;">语种资格证图片</div>
                 	<div class="col-xs-12 col-md-12">
    					<a id="images_5" href="" class="thumbnail" target="_blank">
		                    <img id="images_6" src="" title="语种资格证" class="img-rounded">
	                    </a>
                    </div>
                    <ul class="nav nav-list"> 
					     <li class="divider"></li>  
					</ul>
                 </div>
                 <div class="modal-footer">
                     <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                 </div>
             </div><!-- /.modal-content -->
         </div><!-- /.modal-dialog -->
     </div><!-- /.modal -->
 </div>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>