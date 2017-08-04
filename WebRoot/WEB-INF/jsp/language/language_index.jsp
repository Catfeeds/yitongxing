<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script type="text/javascript">
//添加语种
function addL(){
	var languagename = $("#languagename").val();
	if(!/^[0-9a-zA-Z\u4e00-\u9fa5]{1,100}$/.test(languagename)){
			alert("请输入正确语种名称");
			return;
		}
	/* 执行 */
	$.ajax({
    	type:'post',
        url:'${BASE_URL}/background/language/insert',
        data:{languagename:languagename
        	},
        dataType:'json',
        success:function(data){
        	 if(data == '1'){
     			window.location.href="${BASE_URL}/background/language/language_index";
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
//删除
function deleteById(id) {
	var update = confirm('确定要删除吗？');
	if (! update) {return false;}
	/* 执行 */
	$.ajax({
    	type:'post',
        url:'${BASE_URL}/background/language/delete',
        data:{id:id
        	},
        dataType:'json',
        success:function(data){
        	 if(data == '1'){
        		window.location.href="${BASE_URL}/background/language/language_index";
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
                <p class="h4">语种管理</p>
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
     							<tr height="50px" align="center"><td width="50px">序号</td><td width="200px">语种</td><td width="200px">操作</td></tr>
     							<c:forEach items="${list}" var="l" varStatus="status">
     							<tr height="35px" align="center"><td>${status.count}</td><td>${l.languagename}</td><td><a href="javascript:deleteById(${l.languageid})">删除</a></td></tr>
     							</c:forEach>
     						</table>
   						</div>	 
 					</div>
                </form>
            </section>
        </section>
    </aside>
</section>

<!-- 新增语种 -->
<div class="modal fade" id="reason_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="exampleModalLabel">请填语种名称</h4>
			</div>
			<div class="modal-body">
				<form>
					<div class="form-group">
						<input style="width:300px;margin-left: 100px;" type="text" id="languagename" name="languagename" class="input-sm form-control">
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-success" onclick="javascript:addL();">确认</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>

<jsp:include page="/view/panel/wrapper.suffix.jsp"/>