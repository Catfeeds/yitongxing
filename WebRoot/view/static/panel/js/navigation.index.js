$(document).ready(function() {
	refreshListing();
    
    /**
     * 刷新搜索
     */
    $(".action-refresh,#action_search").on('click',function(){
    	$('#category_listing').datagrid('reload');
    	return false;
    });
    
    /**
	 * 删除 - 单条
	 */
    $("#navigation_listing").delegate('.operate-delete', 'click', function(){
		var navigationId = $(this).attr("navigationId");
		var $tr = $(this).parent().parent();
		doDelete(navigationId, $tr);
	});
    
    /**
     * 审核
     */
    $('#navigation_listing').delegate('.switch-sm', 'click', function(){
    	var navigationId = $(this).attr('navigationId');
    	publishNavigation(navigationId);
    	return false;
    });
});


/**
 * 更改导航状态
 */
function publishNavigation(id) {
	$.ajax({
    	type:'post',
        url:BASE_URL+'/panel/navigation/publish',
        data:'navigationId=' + id,
        dataType:'json',
        timeout:60000,
        success:function(data){
    		if (data.status == 0) {
    			var d = data.data;
    			if (d.status == 1) {
    				$('#navigation_' + id).prop('checked', true);
    			} else {
    				$('#navigation_' + id).prop('checked', false);
    			}
    		} else {
    			alert(data.msg);
    		}
    		return false;
    	}
    });
}

/**
 * 删除
 */
function doDelete(id, $tr) {
	var del = confirm('确定要删除所选导航吗？');
	if (! del) {return false;}
	
	/* 执行删除 */
	$.ajax({
    	type:'post',
        url:BASE_URL+'/panel/navigation/delete',
        data:'navigationId=' + id,
        dataType:'json',
        timeout:60000,
        success:function(data){
    		if (data.status == 0) {
    			$tr.remove();
    		} else {
    			alert(data.msg);
    		}
    		return false;
    	}
    });
}

/**
 * datagrid 加载列表
 */
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
	        var url = BASE_URL+'/panel/navigation/page';
	        var self = this;
	        
	        setTimeout(function () {
	
	            var data = $.extend(true, [], self._data);
	
	            $.ajax(url, {
	                data: {
	                	rstype:"json"
	                },
	                dataType: 'json',
	                async: true,
	                type: 'GET'
	            }).done(function (response) {
	            	var data = response.data;
                    if (! data) {
                    	return false;
                    }

                    if (self._formatter) self._formatter(data);

                    callback({ data: data });
                }).fail(function (e) {

                });
	        }, self._delay);
	    }
	};
	
	$('#navigation_listing').datagrid({
	    dataSource: new DataGridDataSource({
	        // Column definitions for Datagrid
	        columns: [
	            {
	                property: 'navigationId',
	                label: 'ID',
	                sortable: true
	            },
	            {
	            	property: 'title',
	            	label: '导航名称',
	            	sortable: false
	            },
	            {
	            	property: 'link',
	            	label: '链接地址',
	            	sortable: false
	            },
	            {
	            	property: 'sortOrder',
	            	label: '序号',
	            	sortable: false
	            },
	            {
	            	property: 'status',
	            	label: '状态',
	            	sortable: false
	            },
	            {
	            	property: 'operate',
	                label: '操作'
	            }
	        ],
	        formatter: function (items) {
	            $.each(items, function (index, item) {
	            	item.title = item.strPadding + item.title;
	            	
	            	var is_publish = item.status == 1 ? 'checked="checked"' : '';
	                item.status = '<label class="switch-sm" navigationId="' + item.navigationId + '">' + 
	                		'<input type="checkbox" id="navigation_' + item.navigationId + '" ' + is_publish + ' />' + 
	                		'<span></span></label>';
	                
	            	item.operate = '<a href="'+BASE_URL+'/panel/navigation/edit/?navigationId=' + item.navigationId + '" data-toggle="ajaxModal" class="operate-edit" title="编辑"><i class="fa fa-pencil"></i></a>&nbsp;&nbsp;' + 
							'<a href="javascript:;" class="operate-delete" navigationId="' + item.navigationId + '" title="删除"><i class="fa fa-times"></i></a>';
	            });
	        }
	    }),
	    loadingHTML: '<span><img src="'+STATIC_URL+'/panel/img/loading.gif"><i class="fa fa-info-sign text-muted" "></i>正在加载……</span>',
	    itemsText: '项',
	    itemText: '项',
	    dataOptions: { }	
	});
}