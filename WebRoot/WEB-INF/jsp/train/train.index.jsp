<%@ page contentType="text/html;charset=UTF-8" import="com.bluemobi.po.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<link href="${STATIC_URL}/scripts/datepicker/css/datepicker3.css" rel="stylesheet" type="text/css"/>
<script src="${STATIC_URL}/scripts/datepicker/js/bootstrap-datepicker.js"></script>
<script src="${STATIC_URL}/scripts/datepicker/js/locales/bootstrap-datepicker.zh-CN.time.js" charset="UTF-8"></script>
<script type="text/javascript">
	var STATIC_URL = '${STATIC_URL}';
	
	$(document).ready(function() {
	refreshListing();
	
	/**
	 * 刷新或搜索input-group-btn
	 */
	$('body').delegate('.action-refresh, #action_search', 'click', function(){
		$('#content_listing').datagrid('reload');
	});
});
function refreshListing() {
	/* fuelux datagrid */
	var DataGridDataSource = function (options) {
	    this._formatter = options.formatter;
	    this._columns = options.columns;
	    this._delay = options.delay;
	};
	DataGridDataSource.prototype = {
	    columns: function () {
	        return this._columns;
	    },
	    data: function (options, callback) {
	        var url = '${BASE_URL}/background/train/trainpage';
	        var self = this;
	        setTimeout(function () {
	            var data = $.extend(true, [], self._data);
	            $.ajax(url, {
	                data:$('#trainname').serialize()+"&pageIndex="+(options.pageIndex+1)+"&pageSize="+options.pageSize,
	                dataType: 'json',
	                async: true,
	                type: 'GET'
	            }).done(function (response) {
	            	var data = response.data.data;
                    if (! data) {
                    	return false;
                    }

                    var count=response.data.count;//设置data.total
                    // PAGING
                    var startIndex = options.pageIndex * options.pageSize;
                    var endIndex = startIndex + options.pageSize;
                    var end = (endIndex > count) ? count : endIndex;
                    var pages = Math.ceil(count / options.pageSize);
                    var page = options.pageIndex + 1;
                    var start = startIndex+1;

                    if (self._formatter) self._formatter(data);

                    callback({ data: data, start: start, end: end, count: count, pages: pages, page: page });
                }).fail(function (e) {

                });
	        }, self._delay);
	    }
	};
	
	$('#content_listing').datagrid({
	    dataSource: new DataGridDataSource({
	        // Column definitions for Datagrid
	        columns: [
                {
  	                property: 'index',
  	                label: '序号'
  	            },
				{
				    property: 'trainname',
				    label: '培训问题',
				    sortable: false
				},
				{
				    property: 'ctime',
				    label: '创建时间',
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
	            	item.index=index+1;
	            	var na="";
	            	if(item.trainname !=null) {
	            		na=item.trainname;
	            		if(na.length>7) {
	            			na=na.substring(0,7)+"...";
		            	}
	            	}
	            	item.trainname=na;
	            	item.action = '<a href="javascript:;" title="编辑" onclick="updateTrain('+item.trainid+')">编辑</a>'+
	            				   '&nbsp;&nbsp;<a href="javascript:;" title="删除" onclick="deleteTrain('+item.trainid+')">删除</a>';
	            });
	        }
	    }),
	    loadingHTML: '<span><img src="'+STATIC_URL+'/panel/img/loading.gif"><i class="fa fa-info-sign text-muted" "></i>正在加载……</span>',
	    itemsText: '项',
	    itemText: '项',
	    dataOptions: { pageIndex: 0, pageSize: 15 }	
	});
}
//添加
function addForm() {
	window.top.location='${BASE_URL}/background/train/addtrainym';
}
//修改
function updateTrain(trainid) {
	window.top.location='${BASE_URL}/background/train/updatetrainym?trainid='+trainid;
}
//删除
function deleteTrain(trainid) {
	var a = window.confirm("确认删除?");
	if(a==true) {
		window.top.location='${BASE_URL}/background/train/deletetrain?trainid='+trainid;
	} else {
		a.close;
	}
}
//弹框修改通过条数
function updateCountYm() {
	$('#list_count_modal').modal('show');
}
//修改通过数量
function updateCount() {
	if($("#traincount").val()=="") {
		alert("通过数量不能为空");
		return false;
	}
	if(!/^\+?[1-9][0-9]*$/.test($("#traincount").val())){
		alert("请输入正确的通过数量");
		return false;
	}
	window.top.location='${BASE_URL}/background/train/updateCount?traincount='+$("#traincount").val();
}
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
        	<form action="#" method="post" id="trainname" name="trainname">
        		<header class="header bg-white b-b clearfix" style="padding-top: 10px;">
        		<table style="width: 100%">
	        			<tr>
	        				<td style="height: 40px; width: 60px;" align="right">
	        					培训问题&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<input name="trainname" style="width: 150px;" class="form-control" type="text"/>
	        				</td>
	        				<td align="left">
	        					<button class="btn btn-sm btn-default action-refresh" type="button">搜索</button>
	        					<button class="btn btn-sm btn-default" type="button" onclick="addForm()">添加</button>
	        				</td>
	        			</tr>
	        		</table>
            	</header>
            	<div style="margin-top: 10px;margin-left: 20px;">
	            	 通过数量：${count.traincount}&nbsp;&nbsp;&nbsp;&nbsp;<button class="btn btn-sm btn-default" type="button" onclick="updateCountYm()">修改</button>
	            </div>
           	</form>
            <section class="scrollable wrapper" style="margin-top: 80px;">
                <section class="panel panel-default">
                    <div class="table-responsive">
                        <table class="table table-striped m-b-none datagrid" id="content_listing">
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
<!-- 修改通过数量 -->
<div class="modal fade" id="list_count_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document" align="center">
		<div class="modal-content" style="width: 300px;" align="left">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">修改</h4>
			</div>
			<div class="modal-body" >
				<div class="form-group">
					<table>
						<tr>
							<td>
								<label for="list_expresscode_modal_input" class="control-label">通过数量：</label>
							</td>
							<td>
								<input id="traincount" name="traincount" style="width: 150px;" class="form-control" type="text" maxlength="8" value="${count.traincount}"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-success" onclick="updateCount()">确认</button>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>