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
//查看备注
function findRemark(t) {
	$("#remarkid").val(t);
	$('#list_remarkcode_modal').modal('show');
}
//导出订单
function downe() {
	document.ordername.action="/background/excel/downOrder";
	document.ordername.submit();
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
	        var url = '/background/order/orderpage';
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
	                property: 'orderid',
	                label: '订单号',
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
	            {
	                property: 'price',
	                label: '价格($)',
	                sortable: false
	            },
	            {
	                property: 'money',
	                label: '总金额($)',
	                sortable: false
	            },
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
	                property: 'action',
	                label: '操作',
	                sortable: false
	            }
	        ],
	        formatter: function (items) {
	            $.each(items, function (index, item) {
	            	var statet=item.state;
	            	var statesp=staten.split(",");
	            	for(var i=0;i<statesp.length;i++) {
	            		if(Number(statet)==Number(i)) {
	            			item.state=statesp[i];
	            		}
	            	}
	            	var rem="";
	            	if(item.remark !=null) {
	            		rem=item.remark;
	            		if(rem.length>10) {
	            			rem=rem.substring(0,10)+"...";
		            	}
	            	}
	            	item.remark='<a href="javascript:;" onclick="findRemark(&quot;'+item.remark+'&quot;)">'+rem+'</a>';
	            	if(item.confirm==0) {
	            		item.confirm="未退";
	            	} else {
	            		item.confirm="已退";
	            	}
	            	if(isadmin=="1") {
	            		item.action='<a href="javascript:;" onclick="updateStateym('+statet+','+item.orderid+')">编辑状态</a>';
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