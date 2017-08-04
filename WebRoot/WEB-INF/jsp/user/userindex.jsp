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
	        var url = '${BASE_URL}/background/user/getUserList';
	        var self = this;
	        
	        setTimeout(function () {
	            var data = $.extend(true, [], self._data);
	            $.ajax(url, {
	                data: {
	                	rstype : "json",
	                	pageIndex : options.pageIndex + 1,
	                    pageSize : options.pageSize,
	                    account : $("#account").val(),
	                    name : $("#name").val(),
	                    state : $('select[name=state]').val()
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
	
	/* 建表插件 */
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
	                property: 'balance',
	                label: '余额',
	                sortable: false
	            },
	            {
	                property: 'account',
	                label: '手机号',
	                sortable: false
	            },
	            {
	            	property: 'sex',
	            	label: '性别',
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
	                property: 'exitpaytype',
	                label: '申请退出支付方式',
	                sortable: false
	            },
	            {
	                property: 'exitpayaccount',
	                label: '申请退出支付账号',
	                sortable: false
	            },
	            {
	                property: 'states',
	                label: '屏蔽状态',
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
	            	item.birthdays = isBlankColumn(item.birthday).replace(" 00:00:00", "");
	            	if(item.exitpayaccount==null) {
	            		item.exitpayaccount="";
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
	            		item.action = '<a href="javascript:updateState(' + item.userid + ',1)"><font color="blue"><u>屏蔽</u></font></a>';
            		} else {
            			item.action = '<a href="javascript:updateState(' + item.userid + ',0)"><font color="blue"><u>取消屏蔽</u></font></a>';
            		}
            		if(item.isexit == 0) {
            			item.isexits = "<font color=\"green\">未申请</font>";
            		} else if(item.isexit == 1) {
            			item.isexits = "<font color=\"red\">申请退出</font>";
            			item.action = item.action + '<br><a href="javascript:confirmExit(\'' + item.userid + '\',\'' + item.name + '\',\'' + item.exittime + '\',\'' + item.exitpaytype + '\',\'' + item.exitpayaccount + '\')"><font color="red"><u>确认退出</u></font></a>';
            		} else if(item.isexit == 2) {
            			item.isexits = "<font color=\"red\">已退出</font>";
            		}
            		if(item.exitpaytype=="1") {
	            		item.exitpaytype="微信";
	            	} else if(item.exitpaytype=="2") {
	            		item.exitpaytype="支付宝";
	            	} else if(item.exitpaytype==null) {
	            		item.exitpaytype="";
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
function doExport() {
	window.location = "${BASE_URL}/background/user/userExport?account=" + $("#account").val() +
		"&name=" + $("#name").val() + "&state=" + $('select[name=state]').val();
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
//-->
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
	        <header class="header bg-white b-b clearfix">
	        	<div class="row m-t-sm" >
		        	<div class="col-sm-12 m-b-xs">
		       			<form class="form-inline">
		       				 <div class="form-group col-sm-3 m-b-xs">
		                       	<label class="control-label">姓名</label>
		                       	<input style="width:150px" type="text" id="name" class="input-sm form-control">
		                     </div>
		                     <div class="form-group col-sm-3 m-b-xs">
		                     	<label class="control-label">电话</label>
		                       	<input style="width:150px" type="text" id="account" class="input-sm form-control">
		                     </div>
		                   	 <div class="form-group col-sm-2 m-b-xs">
		                    	<label class="control-label">状态</label>
		                       	<select name="state" class="form-control input-sm">
		                       		<option value="">全部</option>
		                       		<option value="0">未屏蔽</option>
		                       		<option value="1">屏蔽</option>
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
		                        <a class="btn btn-info" href="javascript:void(0)" onclick="doExport()" target="_blank">
		                        	导出
		                        </a>
		                     </div>
	                     </form>
	                 </div>
	        	</div>          
	        </header>
            <section class="scrollable wrapper" style="overflow:auto">
                <section class="panel panel-default" style="width: 1500px;">
                    <div class="table-responsive" style="width: 1500px;">
                        <table class="table table-bordered table-striped table-hover m-b-none datagrid" id="content_listing">
                            <thead>
                            </thead>
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
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>