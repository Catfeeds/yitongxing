<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<link href="${STATIC_URL}/scripts/datepicker/css/datepicker3.css" rel="stylesheet" type="text/css"/>
<script src="${STATIC_URL}/scripts/datepicker/js/bootstrap-datepicker.js"></script>
<script src="${STATIC_URL}/scripts/datepicker/js/locales/bootstrap-datepicker.zh-CN.time.js" charset="UTF-8"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('.datepicker-input').datepicker();
		
		$('body').delegate('.action-refresh, #action_search', 'click', function() {
			$('#content_listing').datagrid('reload');
		});
		
		$("#btn_add").click(function(){
			window.location.href="${BASE_URL}/background/message/toAddMessage";
		});
		
		refreshListing();
		
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
		        var url = '${BASE_URL}/background/message/getMessageList';
		        var self = this;
		        
		        setTimeout(function () {
		            var data = $.extend(true, [], self._data);
		            $.ajax(url, {
		                data: {
		                	rstype : "json",
		                	pageIndex : options.pageIndex + 1,
		                    pageSize : options.pageSize,
		                    //account : $("#account").val(),
		                    //name : $("#name").val(),
		                    //state : $('select[name=state]').val()
		                    createtime:$("#c_date").val(),
		                    content:$("#c_content").val()
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
		                property: 'index',
		                label: '编号',
		                sortable: false
		            },
		            {
		                property: 'title',
		                label: '消息标题',
		                sortable: false
		            },
		            {
		                property: 'content',
		                label: '系统消息',
		                sortable: false
		            },
		            {
		            	property: 'createtime',
		            	label: '发布时间',
		            	sortable: false
		            },
		           	/*
		            {
		            	property: 'senduname',
		            	label: '管理员',
		            	sortable: false
		            },
		            */
		            {
		                property: 'action',
		                label: '操作',
		                sortable: false
		            }
		        ],
		        formatter: function (items) {
		        	var content;
		            $.each(items, function (index, item) {
		            	item.index = index+1;
		            	item.senduname = item.name;
		            	item.content = item.content==undefined?"":item.content.substring(0,15);
		            	item.createtime = item.createtime.substring(0,10);
	            		item.action = '<a href="javascript:detailMessage(' + item.msgid + ')"><font color="blue"><u>查看</u></font></a>&nbsp;&nbsp;<a href="javascript:deleteMessage(' + item.msgid + ')"><font color="blue"><u>删除</u></font></a>';
		            });
		        }
		    }),
		    loadingHTML: '<span><img src="${STATIC_URL}/panel/img/loading.gif"><i class="fa fa-info-sign text-muted" "></i>正在加载……</span>',
		    itemsText: '项',
		    itemText: '项',
		    dataOptions: {pageIndex: 0, pageSize: 15}	
		});
	}
	
	function deleteMessage(msgid) {
		if(confirm("确认删除吗？")) {
			$.ajax({
				type : "post",
				url : "${BASE_URL}/background/message/delete", 
				data:{msgid : msgid}, 
				dataType : 'json',
				success : function (data) {
					if(data=="1") {
						alert("删除成功");
						$('#content_listing').datagrid('reload');
					} else {
						alert("删除失败");
					}
				},
				error : function () {
					alert("失败");
				}
			});
		}
	}
	
	function detailMessage(msgid){
		//alert(msgid);
		window.location.href="${BASE_URL}/background/message/detail?msgid="+msgid;
	}
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
	        <header class="header bg-white b-b clearfix">
	        	<div class="row m-t-sm" >
		        	<div class="col-sm-12 m-b-xs">
		       			<form class="form-inline">
		       				 <div class="form-group col-sm-3 m-b-xs">
		                       	<label class="control-label">发布时间</label>
		                       	<input id="c_date" style="width: 150px;" class="input-sm input-s datepicker-input form-control" type="text" data-date-format="yyyy-mm-dd"/>
		                     </div>
		                     <div class="form-group col-sm-3 m-b-xs">
		                     	<label class="control-label">系统消息</label>
		                       	<input id="c_content" style="width:150px" type="text" id="account" class="input-sm form-control">
		                     </div>
		                   	 <div class="form-group col-sm m-b-xs">
		                       	<a class="btn btn-success action-refresh">
		                       		<i class="fa fa-search"></i>
		                       		查询
		                       	</a>
		                     </div>
		                     <div class="form-group col-sm m-b-xs">
		                       	<a class="btn btn-warning" id="btn_add">
		                       		<i class="fa fa-plus"></i>
		                       		添加
		                       	</a>
		                     </div>
	                     </form>
	                 </div>
	        	</div>          
	        </header>
            <section class="scrollable wrapper">
                <section class="panel panel-default" >
                    <div class="table-responsive" >
                        <table class="table table-striped m-b-none datagrid" id="content_listing" >
                            <thead>
                            </thead>
                            <tfoot>
                                <tr>
                                    <th class="row">
                                        <div class="datagrid-footer-left col-sm-6 text-center-xs m-l-n"
                                             style="display:none;">
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
                                                        <li data-value="20"><a href="#">20</a></li>
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
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>