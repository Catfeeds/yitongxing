<%@ page contentType="text/html;charset=UTF-8" import="com.bluemobi.po.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<link href="${STATIC_URL}/scripts/datepicker/css/datepicker3.css" rel="stylesheet" type="text/css"/>
<script src="${STATIC_URL}/scripts/datepicker/js/bootstrap-datepicker.js"></script>
<script src="${STATIC_URL}/scripts/datepicker/js/locales/bootstrap-datepicker.zh-CN.time.js" charset="UTF-8"></script>
<script type="text/javascript">
	var STATIC_URL = '${STATIC_URL}';
	var staten='${state}';
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
	//$("#statetk").val(t);
	$("#ordertkid").val(m);
	$('#list_expresscode_modal').modal('show');
}
//查看备注
function findRemark(t) {
	$("#remarkid").val(t);
	$('#list_remarkcode_modal').modal('show');
}
//编辑状态
function updateOrder() {
	if($("#paytypeid").val()!="2") {
		$("#dealorderid").val($("#dealorderid").val().replace(/\s+/g,""));
		if($("#dealorderid").val()=="") {
			alert("订单号不能为空");
			return false;
		}
		if(!/^[a-z A-Z 0-9]*$/.test($("#dealorderid").val())){
			alert("请输入正确的订单号");
			return false;
		}
	}
	$.ajax({
    	type:'post',
        url:'${BASE_URL}/background/order/updateOrder',
        data:'orderid='+$("#ordertkid").val()+"&state="+$("#statetk").val()+"&dealorderid="+$("#dealorderid").val()+"&paytype="+$("#paytypeid").val(),
        timeout:60000,
        success:function(data){
        	var dama=eval("("+data+")");
        	alert(dama.msg);
        	window.top.location="${BASE_URL}/background/order/findOrder";
    	}
    });
}
//批量确认退款
function updateRefund() {
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
	        url:'${BASE_URL}/background/order/updateRefund',
	        data:'orderid='+orderid,
	        timeout:60000,
	        success:function(data){
	        	var dama=eval("("+data+")");
	        	alert(dama.msg);
	        	window.top.location="${BASE_URL}/background/order/findOrder";
	    	}
	    });
	} else {
		a.close;
	}
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
	        var url = '${BASE_URL}/background/order/orderpage';
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
	                property: 'confirm',
	                label: '是否退款',
	                sortable: false
	            },
	           /*  {
	                property: 'price',
	                label: '价格(￥)',
	                sortable: false
	            },
	            {
	                property: 'money',
	                label: '总金额(￥)',
	                sortable: false
	            }, */
	            {
	                property: 'bondmoney',
	                label: '担保金(￥)',
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
	                property: 'state',
	                label: '状态',
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
	            	//待评价、已完成可退款
	            	if (item.state==4 || item.state==5) {
	            		if(item.confirm==0) {
	            			item.checkbox = '<input type="checkbox" id="check_orderid" name="post[]" class="select-single" value="' + item.orderid + '">';
	            		} else {
	            			item.checkbox = '<i class="fa fa-ban"></i>';
	            		}
					} else {
						item.checkbox = '<i class="fa fa-ban"></i>';
					}
					if(item.istimely=="0") {
	            		item.istimely="普通订单";
	            	} else if(item.istimely=="1") {
	            		item.istimely="即时订单";
	            		item.bondmoney="0";
	            	}
	            	if(item.level=="2") {
	            		item.levelname="口译员";
	            	} else if(item.level=="3") {
	            		item.levelname="高级口译员";
	            	}
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
	            	if(item.confirm==0) {
	            		item.confirm="未退";
	            	} else {
	            		item.confirm="已退";
	            	}
	            	item.areaname=item.countryn+item.provincen+item.cityn
	            	var statet=item.state;
	            	if(isadmin=="1") {
	            		if(statet==0) {
	            			item.action='<a href="javascript:;" onclick="updateStateym('+statet+',&quot;'+item.orderid+'&quot;)">编辑状态</a>';
	            		} else {
	            			item.action="";
	            		}
	            	}
	            	var statesp=staten.split(",");
	            	for(var i=0;i<statesp.length;i++) {
	            		if(Number(statet)==Number(i)) {
	            			item.state=statesp[i];
	            		}
	            	}
	            	var payt="";
	            	if(item.paytime==null) {
	            		payt="";
	            	} else {
	            		payt=item.paytime;
	            	}
	            	if(statet==6 && payt!="") {
	            		item.state="<font color='red'>用户取消已支付定金订单</font>";
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
	document.ordername.action="${BASE_URL}/background/excel/downOrder";
	document.ordername.submit();
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
	        					<select name="state" style="width: 150px;" class="form-control input-sm">
	        						<option value="">==请选择==</option>
	        						<c:forEach items="${statelist}" var="w">
	        							<option value="${w.id}">${w.state}</option>
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
	            	 <a href="javascript:;" class="btn btn-sm btn-default" onclick="updateRefund()">批量确认退款</a>
	            </div>
           	</form>
            <section class="scrollable wrapper" style="margin-top: 130px;overflow:auto">
                <section class="panel panel-default" style="width: 2300px;">
                    <div class="table-responsive" style="width: 2300px;">
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
<!-- 编辑状态 -->
<div class="modal fade" id="list_expresscode_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document" align="center">
		<div class="modal-content" style="width: 300px;" align="left">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">编辑状态</h4>
			</div>
			<div class="modal-body" >
				<div class="form-group">
					<input type="hidden" id="ordertkid">
					<table>
						<tr>
							<td>
								<label for="list_expresscode_modal_input" class="control-label">状态：</label>
							</td>
							<td>
								<select style="width: 150px;" class="form-control input-sm" id="statetk">
			   						<!--<c:forEach items="${statelist}" var="w">
			   							<option value="${w.id}">${w.state}</option>
			   						</c:forEach>-->
			   						<option value="2">订单进行中</option>
			   					</select>
							</td>
						</tr>
						<tr>
							<td style="padding-top: 10px;">
								<label for="list_expresscode_modal_input" class="control-label">支付方式：</label>
							</td>
							<td style="padding-top: 10px;">
								<select style="width: 150px;" class="form-control input-sm" id="paytypeid">
			   						<option value="0">支付宝</option>
			   						<option value="1">微信</option>
			   						<option value="2">余额</option>
			   					</select>
							</td>
						</tr>
						<tr>
							<td style="padding-top: 10px;">
								<label for="list_expresscode_modal_input" class="control-label">支付订单号：</label>
							</td>
							<td style="padding-top: 10px;">
								<input id="dealorderid" style="width: 150px;" class="form-control" type="text" maxlength="30"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-success" onclick="updateOrder()">确认</button>
			</div>
		</div>
	</div>
</div>
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