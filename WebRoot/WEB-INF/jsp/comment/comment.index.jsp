<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script type="text/javascript">
	$(document).ready(function() {
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
		        var url = '${BASE_URL}/background/comment/getCommentList';
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
		                label: '用户名',
		                sortable: false
		            },
		            {
		                property: 'content',
		                label: '内容',
		                sortable: false
		            },
		            {
		            	property: 'account',
		            	label: '电话',
		            	sortable: false
		            },
		            {
		            	property: 'createtime',
		            	label: '日期',
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
		            	item.createtime = item.createtime.substring(0,10);
	            		item.action = '<a href="javascript:deleteComment(' + item.commentid + ')"><font color="blue"><u>删除</u></font></a>';
		            	//item.action = '<button type="button" class="btn btn-primary btn-sm" onclick="deleteComment(' + item.commentid + ')">删除</button>';
		            });
		        }
		    }),
		    loadingHTML: '<span><img src="${STATIC_URL}/panel/img/loading.gif"><i class="fa fa-info-sign text-muted" "></i>正在加载……</span>',
		    itemsText: '项',
		    itemText: '项',
		    dataOptions: {pageIndex: 0, pageSize: 15}	
		});
	}
	
	function deleteComment(commentid) {
		if(confirm("确认删除吗？")) {
			$.ajax({
				type : "post",
				url : "${BASE_URL}/background/comment/deleteComment", 
				data:{commentid : commentid}, 
				dataType : 'json',
				success : function (data) {
					if(data) {
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
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
	        <header class="header bg-white b-b clearfix">
	        	<div class="row m-t-sm" >
		        	<div class="col-sm-3">
		        		<h4>用户意见</h4>
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