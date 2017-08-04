<%@ page contentType="text/html;charset=UTF-8" import="com.bluemobi.po.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<link href="${STATIC_URL}/scripts/datepicker/css/datepicker3.css" rel="stylesheet" type="text/css"/>
<script src="${STATIC_URL}/scripts/datepicker/js/bootstrap-datepicker.js"></script>
<script src="${STATIC_URL}/scripts/datepicker/js/locales/bootstrap-datepicker.zh-CN.time.js" charset="UTF-8"></script>
<script type="text/javascript">
	var STATIC_URL = '${STATIC_URL}';
	var resetn='${reset}';
	var isadmin='${user.isadmin}';
	
	$(document).ready(function() {
	refreshListing();
	
	/**
	 * 刷新或搜索input-group-btn
	 */
	$('body').delegate('.action-refresh, #action_search', 'click', function(){
		$('#content_listing').datagrid('reload');
	});
	/**预处理日期选择控件*/
	$('.datepicker-input').datepicker();
});
//编辑状态弹出框
function updateStateym(t,m){
	$("#statetk").val(t);
	$("#ordertkid").val(m);
	$('#list_expresscode_modal').modal('show');
}
//查看备注
function findRemark(t) {
	$("#remarkid").val(t);
	$('#list_remarkcode_modal').modal('show');
}
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
	        var url = '${BASE_URL}/background/order/orderCancelpage';
	        var self = this;
	        setTimeout(function () {
	            var data = $.extend(true, [], self._data);
	            $.ajax(url, {
	                data:$('#ordername').serialize()+"&pageIndex="+(options.pageIndex+1)+"&pageSize="+options.pageSize,
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
  	                property: 'checkbox',
  	                label: '<input type="checkbox" />'
  	            },
				{
				    property: 'userid',
				    label: '用户ID',
				    sortable: false
				},
				{
				    property: 'username',
				    label: '用户名',
				    sortable: false
				},
				{
				    property: 'invitation',
				    label: '推荐人',
				    sortable: false
				},
	            {
	                property: 'orderid',
	                label: '订单号',
	                sortable: false
	            },
	            {
	                property: 'istimely',
	                label: '订单类型',
	                sortable: false
	            },
	            {
	                property: 'areaname',
	                label: '目的地',
	                sortable: false
	            },
	            {
	                property: 'begintime',
	                label: '开始时间',
	                sortable: false
	            },
	            {
	                property: 'endtime',
	                label: '结束时间',
	                sortable: false
	            },
	            {
	                property: 'languagename',
	                label: '语种',
	                sortable: false
	            },
	            {
	                property: 'levelname',
	                label: '等级',
	                sortable: false
	            },
	            {
	                property: 'specialtyname',
	                label: '专业',
	                sortable: false
	            },
	            {
	                property: 'cancel',
	                label: '是否退款',
	                sortable: false
	            },
	            //{
	             //   property: 'price',
	             //   label: '价格/小时(￥)',
	             //   sortable: false
	            //},
	            //{
	            //    property: 'money',
	             //   label: '总金额(￥)',
	             //   sortable: false
	            //},
	            {
	                property: 'qmoney',
	                label: '退钱/扣钱详情',
	                sortable: false
	            },
	            {
	                property: 'remark',
	                label: '备注',
	                sortable: false
	            },
	            {
	                property: 'createtime',
	                label: '发布时间',
	                sortable: false
	            },
	            {
	                property: 'reset',
	                label: '状态',
	                sortable: false
	            },
	            {
	                property: 'state',
	                label: '取消人',
	                sortable: false
	            },
	            {
	                property: 'canceltime',
	                label: '取消时间',
	                sortable: false
	            },
	            {
	                property: 'opaytype',
	                label: '支付方式',
	                sortable: false
	            },
	            {
	                property: 'odealorderid',
	                label: '支付订单号',
	                sortable: false
	            }
	            <%User user = (User)request.getAttribute("user");
		        if(user.getIsadmin().equals(1)){%>
		            ,{
		                property: 'action',
		                label: '操作',
		                sortable: false
		            }
  	            <%}%>
	        ],
	        formatter: function (items) {
	            $.each(items, function (index, item) {
	            	if(item.invitation==null) {
	            		item.invitation="";
	            	}
	            	var mo="";
	            	var isti="";
	            	if(item.istimely=="0") {
	            		isti="普通订单";
	            		if(item.reset==2) {
		            		//翻译取消(用户预约在48小时之外,取消时间离预约时间在48小时之内)
			            	mo="用户退钱￥"+item.bondmoney+",翻译扣钱￥"+item.fanyifine;
		            	} else if(item.reset==0) {
		            		//用户取消或翻译取消(用户预约在48小时之内或用户预约在48小时之外,取消时间离预约时间在48小时之外)
		            		mo="用户退钱￥"+item.bondmoney;
		            	} else if(item.reset==1) {
		            		//用户取消(用户预约在48小时之外,取消时间离预约时间在48小时之内)
		            		mo="用户扣钱￥"+item.userfine;
		            	}
	            	} else if(item.istimely=="1") {
	            		isti="即时订单";
	            		if(item.state==6) {
	            			mo="不退不扣";
	            		} else {
	            			mo="翻译扣钱￥"+item.isprice;
	            		}
	            	}
	            	item.qmoney=mo;
	            	if(item.level=="2") {
	            		item.levelname="口译员";
	            	} else if(item.level=="3") {
	            		item.levelname="高级口译员";
	            	}
	            	if (item.state==6) {
	            		if(item.cancel==0 && item.istimely=="0") {
	            			item.checkbox = '<input type="checkbox" id="check_orderid" name="post[]" class="select-single" value="' + item.orderid + '">';
	            		} else {
	            			item.checkbox = '<i class="fa fa-ban"></i>';
	            		}
					} else {
						item.checkbox = '<i class="fa fa-ban"></i>';
					}
	            	if(item.state==6) {
	            		item.state="用户";
	            	} else {
	            		item.state="翻译";
	            	}
	            	if(item.istimely=="0") {
		            	var resett=item.reset;
		            	var resetsp=resetn.split(",");
		            	for(var i=0;i<resetsp.length;i++) {
		            		if(Number(resett)==Number(i)) {
		            			item.reset=resetsp[i];
		            		}
		            	}
	            	} else{
	            		item.reset="";
	            	}
	            	item.istimely=isti;
	            	var rem="";
	            	if(item.remark !=null) {
	            		rem=item.remark;
	            		if(rem.length>10) {
	            			rem=rem.substring(0,10)+"...";
		            	}
	            	}
	            	var na="";
	            	if(item.username !=null) {
	            		na=item.username;
	            		if(na.length>7) {
	            			na=na.substring(0,7)+"...";
		            	}
	            	}
	            	item.username=na;
	            	item.remark='<a href="javascript:;" onclick="findRemark(&quot;'+item.remark+'&quot;)">'+rem+'</a>';
	            	if(item.cancel==0) {
	            		item.cancel="未退";
	            	} else {
	            		item.cancel="已退";
	            	}
	            	item.areaname=item.countryn+item.provincen+item.cityn;
	            	if(isadmin=="1") {
	            		item.action='<a href="javascript:;" onclick="deleteOrder(&quot;'+item.orderid+'&quot;)">删除</a>';
	            	}
	            	if(item.opaytype=="0") {
	            		item.opaytype="支付宝";
	            	} else if(item.opaytype=="1") {
	            		item.opaytype="微信";
	            	} else if(item.opaytype=="2") {
	            		item.opaytype="余额";
	            	} else {
	            		item.opaytype="";
	            	}
	            });
	        }
	    }),
	    loadingHTML: '<span><img src="'+STATIC_URL+'/panel/img/loading.gif"><i class="fa fa-info-sign text-muted" "></i>正在加载……</span>',
	    itemsText: '项',
	    itemText: '项',
	    dataOptions: { pageIndex: 0, pageSize: 15 }	
	});
}
//导出订单
function downe() {
	document.ordername.action="${BASE_URL}/background/excel/downCancelOrder";
	document.ordername.submit();
}
//删除订单
function deleteOrder(t) {
	var a = window.confirm("确认删除?");
	if(a==true) {
		document.ordername.action="${BASE_URL}/background/order/deleteOrder?ordercid="+t;
		document.ordername.submit();
	} else {
		a.close;
	}
}
//批量确认退款
function updateCancelRefund() {
	if ($('#check_orderid:checked').length < 1) {
		alert('请选择订单');
		return false;
	}
	var orderid="";
	$('#check_orderid:checked').each(function(i){
       if(0==i){
    	   orderid = $(this).val();
       }else{
    	   orderid += ","+$(this).val();
       }
    });
	var a = window.confirm("确认退款?");
	if(a==true) {
		$.ajax({
	    	type:'post',
	        url:'${BASE_URL}/background/order/updateCancelRefund',
	        data:'orderid='+orderid,
	        timeout:60000,
	        success:function(data){
	        	var dama=eval("("+data+")");
	        	alert(dama.msg);
	        	window.top.location="${BASE_URL}/background/order/findCancelOrder";
	    	}
	    });
	} else {
		a.close;
	}
}
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
        	<form action="#" method="post" id="ordername" name="ordername">
        		<header class="header bg-white b-b clearfix" style="padding-top: 10px;">
        		<table style="width: 100%">
	        			<tr>
	        				<td style="height: 40px; width: 60px;" align="right">
	        					用户名&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<input name="username" style="width: 150px;" class="form-control" type="text"/>
	        				</td>
	        				<td style="width: 80px;height: 40px;" align="right">
	        					订单号&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<input name="orderid" style="width: 150px;" class="form-control" type="text"/>
	        				</td>
	        				<td style="height: 40px;" align="right">
	        					语种&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<select name="languageid" style="width: 150px;" class="form-control input-sm">
	        						<option value="">==请选择==</option>
	        						<c:forEach items="${languagelist}" var="w">
	        							<option value="${w.languageid}">${w.languagename}</option>
	        						</c:forEach>
	        					</select>
	        				</td>
	        				<td style="height: 40px;" align="right">
	        					专业&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<select name="specialtyid" style="width: 150px;" class="form-control input-sm">
	        						<option value="">==请选择==</option>
	        						<c:forEach items="${specialtylist}" var="w">
	        							<option value="${w.specialtyid}">${w.specialtyname}</option>
	        						</c:forEach>
	        					</select>
	        				</td>
	        			</tr>
	        			<tr>
	        				<td style="height: 40px;" align="right">
	        					状态&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<select name="reset" style="width: 150px;" class="form-control input-sm">
	        						<option value="">==请选择==</option>
	        						<c:forEach items="${resetlist}" var="w">
	        							<option value="${w.id}">${w.reset}</option>
	        						</c:forEach>
	        					</select>
	        				</td>
	        				<td style="height: 40px;" align="right">
	        					等级&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<select name="level" style="width: 150px;" class="form-control input-sm">
	        						<option value="">==请选择==</option>
	        						<option value="2">口译员</option>
	        						<option value="3">高级口译员</option>
	        					</select>
	        				</td>
	        				<td style="width: 80px;height: 40px;" align="right">
	        					开始时间&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<input name="begintime" style="width: 150px;" class="input-sm input-s datepicker-input form-control" type="text" data-date-format="yyyy-mm-dd"/>
	        				</td>
	        				<td style="width: 80px;height: 40px;" align="right">
	        					结束时间&nbsp;&nbsp;
	        				</td>
	        				<td style="width: 180px;">
	        					<input name="endtime" style="width: 150px;" class="input-sm input-s datepicker-input form-control" type="text" data-date-format="yyyy-mm-dd"/>
	        				</td>
	        				<td align="left">
	        					<button class="btn btn-sm btn-default action-refresh" type="button">搜索</button>
	        				</td>
	        			</tr>
	        		</table>
            	</header>
            	<div style="margin-top: 10px;margin-left: 20px;">
	            	 <a href="javascript:;" class="btn btn-sm btn-default" onclick="downe()">导出excel</a>&nbsp;&nbsp;
	            	 <a href="javascript:;" class="btn btn-sm btn-default" onclick="updateCancelRefund()">批量确认退款</a>
	            </div>
           	</form>
            <section class="scrollable wrapper" style="margin-top: 130px;overflow:auto">
                <section class="panel panel-default" style="width: 2550px;">
                    <div class="table-responsive" style="width: 2550px;">
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
<!-- 查看备注 -->
<div class="modal fade" id="list_remarkcode_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document" align="center">
		<div class="modal-content" style="width: 400px;" align="left">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">备注</h4>
			</div>
			<div class="modal-body" >
				<div class="form-group">
					<textarea style="width: 100%;height: 120px;" id="remarkid" readonly="readonly"></textarea>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">确认</button>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>