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
		        var url = '${BASE_URL}/background/ordercomment/getOrderCommentList';
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
		                property: 'orderid',
		                label: '订单号',
		                sortable: false
		            },
		            {
		                property: 'fromuserid',
		                label: '用户ID',
		                sortable: false
		            },
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
		        	var content;
		            $.each(items, function (index, item) {
		            	item.createtime = item.createtime==undefined?"未录入":item.createtime.substring(0,10);
		            	item.content = item.content.length>10?item.content.substring(0,10)+'...':item.content;
		            	content = item.content.length>10?item.content.substring(0,10)+'...':item.content;
		            	item.content = '<a href="javascript:detailComment(' + item.commentid + ')">'+content+'</a>';
	            		item.action = '<a href="javascript:detailComment(' + item.commentid + ')"><font color="blue"><u>查看</u></font></a>&nbsp;&nbsp;<a href="javascript:deleteComment(' + item.commentid + ')"><font color="blue"><u>删除</u></font></a>';
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
				url : "${BASE_URL}/background/ordercomment/deleteOrderComment", 
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
	
	function detailComment(commentid) {
		//绑定数据 //
		$.ajax({
				type : "post",
				url : "${BASE_URL}/background/ordercomment/detail",//更改 
				data:{commentid : commentid}, 
				dataType : 'json',
				beforeSend:function(){
					$("#tab_comment tr").each(function(){
						$(this).find("td:eq(1)").html("");
					});
				},
				success : function (data) {
					//usertype 2翻译  3用户
					var type = data.usertype;
					$("#d_orderid").html(data.orderid);
					$("#d_faccount").html(data.account);
					$("#d_name").html(data.name);
					//评论内容自动换行
					if(2==type){
						$("#d_date_trans").html(data.fromtime);
						$("#d_content_trans").html(data.fromcontent);
						$("#d_date_user").html(data.totime);
						$("#d_content_user").html(data.tocontent);	
					}else if(3==type){
						$("#d_date_user").html(data.fromtime);
						$("#d_content_user").html(data.fromcontent);
						$("#d_date_trans").html(data.totime);
						$("#d_content_trans").html(data.tocontent);
					}
					
				},
				error : function () {
					alert("获取详情失败");
				},
				
				
			});
		//打开模态框
		$("#detailModal").modal("show");
	}
	
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
	        <header class="header bg-white b-b clearfix">
	        	<div class="row m-t-sm" >
		        	<div class="col-sm-3">
		        		<h4>评价管理</h4>
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

<div class="modal hade col-sm-offset-4" id="detailModal" tabindex="-1" role="dialog"  aria-labelledby="mlabel">
	<div class="modal-dialog col-sm-12" role="document" align="center">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<b>评价详细</b>
			</div>
			<div class="modal-body">
				<table class="table table-bordered" id="tab_comment">
					<thead>
						<colgroup>
							<col width="25%"></col><col></col>
						</colgroup>
					</thead>
					<tbody>
						<tr><td class="text-right">订单号：</td><td id="d_orderid"></td></tr>
						<!-- <tr><td>用户ID：</td><td id="d_fromuid"></td></tr> -->
						<tr><td class="text-right">电话/邮箱：</td><td id="d_faccount"></td></tr>
						<tr><td class="text-right">用户名：</td><td id="d_name"></td></tr>
						<tr><td class="text-right">日期：</td><td id="d_date_trans"></td></tr>
						<tr><td class="text-right">翻译方评价内容：</td><td id="d_content_trans"></td></tr>
						<tr><td class="text-right">日期：</td><td id="d_date_user"></td></tr>
						<tr><td class="text-right">用户评价的内容：</td><td  id="d_content_user"></td></tr>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			</div>
		</div>
	</div>	
</div>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>