<%@ page contentType="text/html;charset=UTF-8" import="com.bluemobi.po.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script src="${STATIC_URL}/scripts/bootree/js/bootstrap-treeview.js"></script>
<style type="text/css">
</style>
<script type="text/javascript">
	$(function(){
		
		loadTree();
		
		
		$("#btn_add1").click(function(){
			//清空地区名
			$("#name").val("");
			//校验是否三级菜单  三级不允许添加子菜单
			var node = $("#treeview").treeview("getSelected")[0];
			if(node == undefined){
				alert("请选择一个上级地区");
				return;
			}
			var province = $("#treeview").treeview("getParent",node);
			var country = $("#treeview").treeview("getParent",province);
			var root = $("#treeview").treeview("getParent",country);
			if(root.nodeId != undefined){
				alert("此级别不能添加子地区!");
				return;
			}
			//如果国家级别 显示价格表单
			if(node.href == 0){
				$("#hide_price").show();
				$("#hide_price1").show();
			}else{
				$("#hide_price").hide();
				$("#hide_price1").hide();
			}
			//标识action
			$("#action_btn").val("save");
			$("#myModal").modal("show");
		});
		
		
		/**
		   模态框 保存按钮
		*/
		$("#btn_save").click(function(){
			var node = $("#treeview").treeview("getSelected")[0];
			var pid = node.href;//新增为 选中节点id
			if($("#action_btn").val()=="edit"){
				//修改为 父节点id
				pid = node.pid;
			}
			if(pid == 0){
				//判断国家简称是否存在
				$.ajax({
			    	type:'post',
			        url:'${BASE_URL}/background/area/findAbbreviation',
			        data:'abbreviation='+$("#mabbreviation").val()+'&areaid='+node.href,
			        timeout:60000,
			        success:function(data){
			        	var dama=eval("("+data+")");
			        	if(dama.status>0) {
			        		alert("国家简称已存在");
			        		return false;
			        	} else {
			        		if(!validate()){
								return;
							}
							if($("#name").val()==""){
								alert("请填写地区名称");
								return;
							}
							//传递数据
							var data  = $("#f_price").serialize()+"&pid="+pid; //新增传递
							if($("#action_btn").val()=="edit"){
								data = $("#f_price").serialize()+"&areaid="+node.href+"&pid="+pid;
								modifyArea(data,node.href,pid);
							}else{
								saveArea(data);
							}
			        	}
			    	}
			    });
			} else {
				if($("#name").val()==""){
					alert("请填写地区名称");
					return;
				}
				//传递数据
				var data  = $("#f_price").serialize()+"&pid="+pid; //新增传递
				if($("#action_btn").val()=="edit"){
					data = $("#f_price").serialize()+"&areaid="+node.href+"&pid="+pid;
					modifyArea(data,node.href,pid);
				}else{
					saveArea(data);
				}
			}
		});
		
		$("#btn_dele").click(function(){
			var node = $("#treeview").treeview("getSelected")[0];
			if(node.href == 0 || node.pid == 0){
				alert("不能删除此项!");
				return;
			}
			if(confirm("是否删除此地区")){
				$.post("${BASE_URL}/background/area/validate",{areaid:node.href},function(data){
					 if(data=="1"){
						 deletearea(node.href);
					 }else{
						 alert("不能删除此地区(此地区内有用户或地区下包含子地区)");
					 }	
				},"json");
			}
		});
		
		
		$("#btn_edit").click(function(){
			//显示模态框
			var node = $("#treeview").treeview("getSelected")[0];
			if(node == undefined){
				alert("选择需要修改的地区");
				return;
			}
			//修改时候回显地区名
			$("#name").val(node.text);
			//如果国家级别 显示价格表单
			if(node.pid == 0){
				$("#hide_price").show();
				$("#hide_price1").show();
			}else{
				$("#hide_price").hide();
				$("#hide_price1").hide();
			}
			$("#action_btn").val("edit");
			$("#myModal").modal("show");
		});
		
		
		
		
		
	});
	
	
	
	function loadTree(){
		$.post("${BASE_URL}/background/area/load",{},function(data){
			var $tree = $("#treeview").treeview({
			  data: data,
			  levels:2,
			  multiSelect:false,
			  onNodeSelected: function(event, data) {
				 $("#f_price")[0].reset();//每次点击清空价格表单
					 if(data.pid == 0){
						 showPricePanel(data.href); 
						 $("#p_price").show();
					 }else{
						 $("#p_price").hide();
					 }	 
				 //新增
				 $("#pname").val(data.text);
			  }
			});
		});
		
	}
	
	function deletearea(areaid){
		$.post(
			"${BASE_URL}/background/area/delete",
			{areaid:areaid, areaname:$("#areaname").val()},
			function(data){
				if(data=="1"){
					alert("删除成功!");
					loadTree();
				}
			}
		,"json");
	}
	
	function showPricePanel(areaid){
		//回显各种价格
		$.post("${BASE_URL}/background/area/loadprice",{areaid:areaid},function(data){
			$.each(data,function(i,item){
				$("#type"+item.type).val(item.price);
				$("#m"+item.type).val(item.price);
			});
			$("#unit").val(data[0].unit);
			$("#munit").val(data[0].unit);
			$("#abbreviation").val(data[0].abbreviation);
			$("#languageid").val(data[0].languageid);
			$("#mabbreviation").val(data[0].abbreviation);
			$("#mlanguageid").val(data[0].languageid);
		},"json");
	}
	
	
	function saveArea(data){
		if(confirm("是否在 \""+$("#pname").val()+"\" 下增加新地区 \"" + $("#name").val() + "\"")){
			$.ajax({
				type : "post",
				url : "${BASE_URL}/background/area/add",
				data: data, 
				dataType : 'json',
				success : function (data) {
					alert(data);
					$("#myModal").modal("hide");
					loadTree();
				},
				error : function () {
					alert("操作失败");
				}
			});
		}	
	}
	
	/**
	*修改地区
	*
	*/
	function modifyArea(data,areaid,pid){
		$.ajax({
			type : "post",
			url : "${BASE_URL}/background/area/modify",
			data: data, 
			dataType : 'json',
			success : function (data) {
				alert(data);
				$("#myModal").modal("hide");
				loadTree();
				if(pid==0){
					showPricePanel(areaid);//如果是修改国家修改后更新右侧显示价格
				}
			},
			error : function () {
				alert("操作失败");
			}
		});
	}
	
	/**
	* 校验相关信息
	**/
	function validate(){
		var flag = true;
		var form = $("#f_price")[0];
		//var reg = /^[0-9]+(.[0-9]{2})?$/ ;//2位小数整数
		$.each(form,function(i,item){
			
			if($(item).val() == ""){
				flag = false;
				alert("所有项目不能为空");
				return false;
			}
			if( i > 2 && i != form.length-1){
				if(i!=9) {
					if(!/^[0-9]+(.[0-9]{1,2})?$/.test($(item).val())){
						flag = false;
						alert("相关价格只能为最多2位小数的数字");
						return false;
					}
				}
			}
		});
		return flag;
	}
		
	
</script>
<section class="hbox stretch">
    <aside>
        <section class="vbox">
	        <header class="header bg-white b-b clearfix">
	        	<div class="row m-t-sm" >
		        	<div class="col-sm-12 m-b-xs">
		       			<form class="form-inline">
		       				 <input type="hidden" id="pname" />
		                   	 <div class="form-group col-sm m-b-xs">
		                       	<a class="btn btn-default" id="btn_add1">
		                       		<i class="fa fa-plus"></i>
		                       		新增地区
		                       	</a>
		                     </div>
		                     <div class="form-group col-sm m-b-xs">
		                       	<a class="btn btn-default" id="btn_edit">
		                       		<i class="fa fa-edit"></i>
		                       		修改地区
		                       	</a>
		                     </div>
		                     <div class="form-group col-sm m-b-xs">
		                       	<a class="btn btn-default" id="btn_dele">
		                       		<i class="fa fa-minus"></i>
		                       		删除地区
		                       	</a>
		                     </div>
	                     </form>
	                 </div>
	        	</div>          
	        </header>
	        <section class="scrollable wrapper">
            <div class="htmleaf-container">
			  <div class="row">
		        <div class="col-sm-5">
		          <div id="treeview" class=""></div>
		        </div>
		        <div class="col-sm-5">
			    	<div class="panel panel-default" id="p_price" style="display:none">
			    		<div class="panel-heading">
	    					<h3 class="panel-title">相关信息</h3>
			    		</div>
			    		<div class="panel-body">
			    			<form class="form-horizontal"  enctype="multipart/form-data" method="post"  action=""  role="form" id="f_price1">
			    				<div class="form-group">
								  <label for="languageid" class="col-sm-4 control-label">语言:</label>
								  <div class="col-sm-6">
								  	 <select name="languageid" class="form-control" id="languageid">
									  	 <c:forEach items="${languagelist}" var="w">
									  	 	<option value="${w.languageid}">${w.languagename}</option>
									  	 </c:forEach>
								  	 </select>
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="abbreviation" class="col-sm-4 control-label">地区简称:</label>
								  <div class="col-sm-6">
									 <input type="text" id="abbreviation" class="form-control" >
								  </div>
							   </div>
							   <!-- 
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">口译员:</label>
								  <div class="col-sm-6">
									 <input type="text" id="type2" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">高级口译员:</label>
								  <div class="col-sm-6">
									 <input type="text" id="type3" class="form-control" >
								  </div>
							   </div> -->
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">起步小时:</label>
								  <div class="col-sm-6">
									 <input type="text" id="type4" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">担保金金额:</label>
								  <div class="col-sm-6">
									 <input type="text" id="type5" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">口译员会费:</label>
								  <div class="col-sm-6">
									 <input type="text" id="type6" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">高级口译员会费:</label>
								  <div class="col-sm-6">
									 <input type="text" id="type8" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">口译员罚金:</label>
								  <div class="col-sm-6">
									 <input type="text" id="type7" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">高级口译员罚金:</label>
								  <div class="col-sm-6">
									 <input type="text" id="type9" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">货币单位:</label>
								  <div class="col-sm-6">
									 <input type="text" id="unit" class="form-control">
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">口译员价钱:</label>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-3 control-label">0:00-6:00:</label>
								  <div class="col-sm-3">
								  	 <input type="text" id="type10" class="form-control" >
								  </div>
								   <label for="lastname" class="col-sm-3 control-label">6:00-9:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type11" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-3 control-label">9:00-18:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type12" class="form-control" >
								  </div>
								   <label for="lastname" class="col-sm-3 control-label">18:00-22:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type13" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-3 control-label">22:00-24:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type14" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-4 control-label">高级口译员价钱:</label>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-3 control-label">0:00-6:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type15" class="form-control" >
								  </div>
								   <label for="lastname" class="col-sm-3 control-label">6:00-9:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type16" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-3 control-label">9:00-18:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type17" class="form-control" >
								  </div>
								   <label for="lastname" class="col-sm-3 control-label">18:00-22:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type18" class="form-control" >
								  </div>
							   </div>
							   <div class="form-group">
								  <label for="lastname" class="col-sm-3 control-label">22:00-24:00:</label>
								  <div class="col-sm-3">
									 <input type="text" id="type19" class="form-control" >
								  </div>
							   </div>
							</form> 
			    		</div>
			    	</div>	
		        </div>
		      </div>
		    </div>
		    </section>
        </section>
    </aside>
</section>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="panel panel-default" id="p_price">
    		<div class="panel-heading">
    			<h3 class="panel-title">
    				地区管理
    			</h3>
    		</div>
    		<div class="panel-body">
    			<input type="hidden" id="action_btn" />
    			<form class="form-horizontal"  enctype="multipart/form-data" method="post"  action=""  role="form" id="f_price">
    			   <div class="form-group">
					  <label for="lastname" class="col-sm-3 control-label">地区名称:</label>
					  <div class="col-sm-3">
						 <input type="text" id="name" class="form-control" name="areaname" placeholder="地区名称">
					  </div>
				   </div>
				   <div id="hide_price1" style="display:none">
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">默认语言:</label>
						  <div class="col-sm-3">
						  	 <select name="languageid" class="form-control" id="mlanguageid">
							  	 <c:forEach items="${languagelist}" var="w">
							  	 	<option value="${w.languageid}">${w.languagename}</option>
							  	 </c:forEach>
						  	 </select>
						  </div>
						  <label for="lastname" class="col-sm-3 control-label">地区简称:</label>
						  <div class="col-sm-3">
							 <input type="text" id="mabbreviation" class="form-control" name="abbreviation" placeholder="地区简称">
						  </div>
					   </div>
				   </div>
				   <div id="hide_price" style="display:none">
				   		<!-- 
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">口译员:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m2" class="form-control" name="2" placeholder="口译员">
						  </div>
						  <label for="lastname" class="col-sm-3 control-label">高级口译员:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m3" class="form-control" name="3" placeholder="高级口译员">
						  </div>
					   </div> -->
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">起步小时:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m4" class="form-control" name="4" placeholder="起步小时">
						  </div>
						  <label for="lastname" class="col-sm-3 control-label">担保金金额:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m5" class="form-control" name="5" placeholder="担保金金额">
						  </div>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">口译员会费:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m6" class="form-control" name="6" placeholder="口译员会费">
						  </div>
						  <label for="lastname" class="col-sm-3 control-label">口译员罚金:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m7" class="form-control" name="7" placeholder="口译员罚金">
						  </div>
					   </div>
					   <div class="form-group">
					   	  <label for="lastname" class="col-sm-3 control-label">高级口译员会费:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m8" class="form-control" name="8" placeholder="高级口译员会费">
						  </div>
						  <label for="lastname" class="col-sm-3 control-label">高级口译员罚金:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m9" class="form-control" name="9" placeholder="高级口译员罚金">
						  </div>
					   </div>
					   <div class="form-group">
					   	  <label for="lastname" class="col-sm-3 control-label">货币单位:</label>
						  <div class="col-sm-3">
							 <input type="text" id="munit" class="form-control" name="unit" placeholder="货币单位">
						  </div>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">口译员价钱:</label>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">0:00-6:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m10" class="form-control" name="10" placeholder="价钱">
						  </div>
						   <label for="lastname" class="col-sm-3 control-label">6:00-9:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m11" class="form-control" name="11" placeholder="价钱">
						  </div>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">9:00-18:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m12" class="form-control" name="12" placeholder="价钱">
						  </div>
						   <label for="lastname" class="col-sm-3 control-label">18:00-22:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m13" class="form-control" name="13" placeholder="价钱">
						  </div>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">22:00-24:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m14" class="form-control" name="14" placeholder="价钱">
						  </div>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">高级口译员价钱:</label>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">0:00-6:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m15" class="form-control" name="15" placeholder="价钱">
						  </div>
						   <label for="lastname" class="col-sm-3 control-label">6:00-9:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m16" class="form-control" name="16" placeholder="价钱">
						  </div>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">9:00-18:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m17" class="form-control" name="17" placeholder="价钱">
						  </div>
						   <label for="lastname" class="col-sm-3 control-label">18:00-22:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m18" class="form-control" name="18" placeholder="价钱">
						  </div>
					   </div>
					   <div class="form-group">
						  <label for="lastname" class="col-sm-3 control-label">22:00-24:00:</label>
						  <div class="col-sm-3">
							 <input type="text" id="m19" class="form-control" name="19" placeholder="价钱">
						  </div>
					   </div>
				   </div>
				</form> 
    		</div>
    		<div class="panel-heading">
				<button type="button" class="btn btn-default btn-sm" data-dismiss="modal">关闭</button>
  				<button id="btn_save" type="button" class="btn btn-primary btn-sm">保存</button>
    		</div>
    	</div>
         
      </div><!-- /.modal-content -->
</div><!-- /.modal -->
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>