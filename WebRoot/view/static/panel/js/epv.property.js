/**
 * 创建模型
 */
var $epv_build = {
	/**
	 * 文本型
	 */
	text: function(p) {
		/* 定义模板 */
		var template_property = '<div class="form-group m-b-xs">' + 
				'<label class="col-sm-2 control-label">{#frontend_label#}</label>' + 
				'<div class="col-sm-6">' + 
			    '<input type="text" class="form-control" id="{#property_code#}" name="{#property_code#}" value="{#property_value#}" placeholder="{#frontend_placeholder#}" />' + 
			    '<span class="help-block m-b-none">{#remark#}</span>' + 
			    '</div>' + 
			    '</div>' + 
			    '<div class="line line-dashed line-sm pull-in"></div>';
		
		/* 格式化模板(@todo 需处理) */
		var template_property = template_property.replace(/{#label_name#}/g, p.label_name);
		
		var v = p.values;
		var str_option = '';
		$(v).each(function(){
			var str_property = p.property_id + '_' + p.property_value_id;
			var str_property_temp = ',' + str_property + ',';
			var selected = property_now.indexOf(str_property_temp) > -1 ? 'selected' : '';
			str_option += '<option value="' + str_property + '" ' + selected + '>' + p.property_value + '</option>';
		});
		
		template_property = template_property.replace(/{#options#}/g, str_option);
		
		/* 返回数据 */
		return template_property;
	},
	
	/**
	 * 文本域型
	 */
	textarea : function(p) {
		/* 定义模板 */
		var template_property = '<div class="form-group m-b-xs">' + 
				'<label class="col-sm-2 control-label">{#frontend_label#}</label>' + 
				'<div class="col-sm-6">' + 
			    '<textarea name="{#property_code#}" id="{#property_code#}" rows="2" class="form-control" placeholder="{#frontend_placeholder#}">{#property_value#}</textarea>' + 
			    '<span class="help-block m-b-none">{#remark#}</span>' + 
			    '</div>' + 
			    '</div>' + 
			    '<div class="line line-dashed line-sm pull-in"></div>';
		
		/* 格式化模板(@todo 需处理) */
		var template_property = template_property.replace(/{#label_name#}/g, p.label_name);
		
		var v = p.values;
		var str_option = '';
		$(v).each(function(){
			var str_property = p.property_id + '_' + p.property_value_id;
			var str_property_temp = ',' + str_property + ',';
			var selected = property_now.indexOf(str_property_temp) > -1 ? 'selected' : '';
			str_option += '<option value="' + str_property + '" ' + selected + '>' + p.property_value + '</option>';
		});
		
		template_property = template_property.replace(/{#options#}/g, str_option);
		
		/* 返回数据 */
		return template_property;
	},
	
	/**
	 * 下拉选项型
	 */
	select : function(p) {
		/* 定义模板 */
		var template_property = '<div class="form-group m-b-xs">' + 
		    	'<label class="col-sm-2 control-label">{#frontend_label#}</label>' + 
		    	'<div class="col-sm-6">' + 
		        '<select name="{#property_code#}" class="form-control">' + 
		        '{#property_options#}' + 
		        '</select>' + 
		        '<span class="help-block m-b-none">{#remark#}</span>' + 
		        '</div>' + 
		        '</div>' + 
		        '<div class="line line-dashed line-sm pull-in"></div>';
		
		/* 格式化模板(@todo 需处理) */
		var template_property = template_property.replace(/{#label_name#}/g, p.label_name);
		
		var v = p.values;
		var str_option = '';
		$(v).each(function(){
			var str_property = p.property_id + '_' + p.property_value_id;
			var str_property_temp = ',' + str_property + ',';
			var selected = property_now.indexOf(str_property_temp) > -1 ? 'selected' : '';
			str_option += '<option value="' + str_property + '" ' + selected + '>' + p.property_value + '</option>';
		});
		
		template_property = template_property.replace(/{#options#}/g, str_option);
		
		/* 返回数据 */
		return template_property;
	},
	
	/**
	 * 单选型
	 */
	radio : function(p) {
		/* 定义模板 */
		var template_property = '<div class="form-group m-b-xs">' + 
				'<label class="col-sm-2 control-label">{#frontend_label#}</label>' + 
				'<div class="col-sm-6">' + 
			    '{#property_options#}' + 
			    '<span class="help-block m-b-none">{#remark#}</span>' + 
			    '</div>' + 
			    '</div>' + 
			    '<div class="line line-dashed line-sm pull-in"></div>';
		var template_property_options = '<label class="checkbox-inline p-left-0">' + 
		    	'<input type="radio" name="{#property_code#}" value="{#property_value#}" />&nbsp;{#property_value#}' + 
		    	'</label>';
		
		/* 格式化模板(@todo 需处理) */
		var template_property = template_property.replace(/{#label_name#}/g, p.label_name);
		
		var v = p.values;
		var str_option = '';
		$(v).each(function(){
			var str_property = p.property_id + '_' + p.property_value_id;
			var str_property_temp = ',' + str_property + ',';
			var selected = property_now.indexOf(str_property_temp) > -1 ? 'selected' : '';
			str_option += '<option value="' + str_property + '" ' + selected + '>' + p.property_value + '</option>';
		});
		
		template_property = template_property.replace(/{#options#}/g, str_option);
		
		/* 返回数据 */
		return template_property;
	},
	
	/**
	 * 多选型
	 */
	checkbox : function(p) {
		/* 定义模板 */
		var template_property = '<div class="form-group m-b-xs">' + 
				'<label class="col-sm-2 control-label">{#frontend_label#}</label>' + 
				'<div class="col-sm-6">' + 
			    '{#property_options#}' + 
			    '<span class="help-block m-b-none">{#remark#}</span>' + 
			    '</div>' + 
			    '</div>' + 
			    '<div class="line line-dashed line-sm pull-in"></div>';
		var template_property_options = '<label class="checkbox-inline col-sm-2">' + 
		        '<input type="checkbox" name="{#property_code#}" value="{#property_value#}" /> {#property_value#}' + 
		        '</label>';
		
		/* 格式化模板(@todo 需处理) */
		var template_property = template_property.replace(/{#label_name#}/g, p.label_name);
		
		var v = p.values;
		var str_option = '';
		$(v).each(function(){
			var str_property = p.property_id + '_' + p.property_value_id;
			var str_property_temp = ',' + str_property + ',';
			var selected = property_now.indexOf(str_property_temp) > -1 ? 'selected' : '';
			str_option += '<option value="' + str_property + '" ' + selected + '>' + p.property_value + '</option>';
		});
		
		template_property = template_property.replace(/{#options#}/g, str_option);
		
		/* 返回数据 */
		return template_property;
	},
	
	/**
	 * 上传附件型
	 */
	file : function(p) {
		/* 定义模板 */
		var template_property = '<div class="form-group m-b-xs">' + 
				'<label class="col-sm-2 control-label">{#frontend_label#}</label>' + 
				'<div class="col-sm-6">' + 
			    '<input type="file" name="{#property_code#}" id="{#property_code#}" class="filestyle" data-icon="false" data-buttonText="上传附件" data-classbutton="btn btn-default" data-classinput="form-control inline input-s" />' + 
			    '<span class="help-block m-b-none">{#remark#}</span>' + 
			    '</div>' + 
			    '</div>' + 
			    '<div class="line line-dashed line-sm pull-in"></div>';
		
		/* 格式化模板(@todo 需处理) */
		var template_property = template_property.replace(/{#label_name#}/g, p.label_name);
		
		var v = p.values;
		var str_option = '';
		$(v).each(function(){
			var str_property = p.property_id + '_' + p.property_value_id;
			var str_property_temp = ',' + str_property + ',';
			var selected = property_now.indexOf(str_property_temp) > -1 ? 'selected' : '';
			str_option += '<option value="' + str_property + '" ' + selected + '>' + p.property_value + '</option>';
		});
		
		template_property = template_property.replace(/{#options#}/g, str_option);
		
		/* 返回数据 */
		return template_property;
	}
}
