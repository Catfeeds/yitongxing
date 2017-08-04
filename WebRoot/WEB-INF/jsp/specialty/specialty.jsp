<%@ page contentType="text/html;charset=UTF-8" import="com.bluemobi.po.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<link href="${STATIC_URL}/scripts/datepicker/css/datepicker3.css" rel="stylesheet" type="text/css"/>
<script src="${STATIC_URL}/scripts/datepicker/js/bootstrap-datepicker.js"></script>
<script src="${STATIC_URL}/scripts/datepicker/js/locales/bootstrap-datepicker.zh-CN.time.js" charset="UTF-8"></script>
<script type="text/javascript">
$(document).ready(function() {
	refreshListing();
});
function refreshListing() {
	/* fuelux datagrid */
	var DataGridDataSource = function (options) {
	    this._formatter = options.formatter;
	    this._columns = options.columns;
	    this._delay = options.delay;
	};
	var allid="";
	DataGridDataSource.prototype = {
	    columns: function () {
	        return this._columns;
	    },
	    data: function (options, callback) {
	        var url = '${BASE_URL}/background/specialty/getall';
	        var self = this;
	        setTimeout(function () {
	            var data = $.extend(true, [], self._data);
	            $.ajax(url, {
	                data:$('#ordername').serialize()+"pageIndex="+(options.pageIndex+1)+"&pageSize="+options.pageSize,
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
	        columns: [
	        	{
  	                property: 'specialtyid',
  	                label: '序号',
  	                sortable: false
  	            },
				{
				    property: 'specialtyname',
				    label: '语种',
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
	            	item.action = '<a onclick="del( '+item.specialtyid +');" href="javascript:openImg(' + item.specialtyid + ',1)"><font color="blue"><u>删除</u></font></a>';
	            });
	        }
	    }),
	    loadingHTML: '<span><img src="'+STATIC_URL+'/panel/img/loading.gif"><i class="fa fa-info-sign text-muted" "></i>正在加载……</span>',
	    itemsText: '项',
	    itemText: '项',
	    dataOptions: { pageIndex: 0, pageSize: 15 }	
	});
}

function addyz(){
	$('#list_remarkcode_modal').modal('show');
}
function okyz(){
	document.ordername.action="${BASE_URL}/background/specialty/save?specialtyname="+$('#specialtyname').val();
	document.ordername.submit();
}
function del(id){
	var s=confirm('成功删除');
	if(s){
		document.ordername.action="${BASE_URL}/background/specialty/del?id="+id;
		document.ordername.submit();
	}else{close();}
}
function addSpecialty(){
	var specialtyname = $("#specialtyname").val();
	if(!/^[0-9a-zA-Z\u4e00-\u9fa5]{1,100}$/.test(specialtyname)){
			alert("请输入正确专业名称");
			return;
		}
	/* 执行 */
	$.ajax({
    	type:'post',
        url:'${BASE_URL}/background/specialty/save',
        data:{specialtyname:specialtyname },
        dataType:'json',
        success:function(data){
        	 if(data == '1'){
     			window.location.href="${BASE_URL}/background/specialty/entrance";
     			return; 
        	 }else{
        		 alert(data);
        	 }
    	},
		error:function(data) {
			alert("系统异常！");
		}
    });
}

function deleteById(id) {
	var update = confirm('确定要删除吗？');
	if (! update) {return false;}
	/* 执行 */
	$.ajax({
    	type:'post',
        url:'${BASE_URL}/background/specialty/del',
        data:{id:id },
        dataType:'json',
        success:function(data){
        	 if(data == '1'){
        		window.location.href="${BASE_URL}/background/specialty/entrance";
     			return; 
        	 }else{
        		 alert(data);
        		 return;
        	 }
    	},
		error:function(data) {
			alert("系统异常！");
			return;
		}
    });
}
</script>
<section class="hbox stretch">
    <aside class="aside-md bg-white b-r">
        <section class="vbox">
            <header class="b-b header">
                <p class="h4">专业管理</p>
            </header>
                
            <section class="scrollable wrapper w-f">
                <form class="form-horizontal" id="edit_form"  method="post" enctype="multipart/form-data">
                   <div class="form-group">
                   		<div class="col-sm-1">
   						</div>
                   		<div class="col-sm-11">
     						<button id="bt" type="button" data-toggle="modal" data-target="#reason_modal" data_submit_type="submit_cancel" class="btn btn-primary btn-sm input-submit">&nbsp;&nbsp;添&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;加&nbsp;&nbsp;</button>
   						</div>	
                   </div>
                   <div class="form-group">
                  		<div class="col-sm-1">
   						</div>
   						<div class="col-sm-11">
     						<table class="table-bordered">
     							<tr height="50px" align="center"><td width="50px">序号</td><td width="200px">专业</td><td width="200px">操作</td></tr>
     							<c:forEach items="${list}" var="l" varStatus="status">
     								<tr height="35px" align="center"><td>${status.count}</td><td>${l.specialtyname}</td><td><a href="javascript:deleteById(${l.specialtyid})">删除</a></td></tr>
     							</c:forEach>
     						</table>
   						</div>	 
 					</div>
                </form>
            </section>
        </section>
    </aside>
</section>
<div class="modal fade" id="reason_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">请填专业名称</h4>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group">
						<input style="width:300px;margin-left: 100px;" type="text" id="specialtyname" name="specialtyname" class="input-sm form-control">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="javascript:addSpecialty();">确认</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>