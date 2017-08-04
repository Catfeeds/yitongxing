<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script type="text/javascript">
function back(){
	window.location.href="${BASE_URL}/background/useradmin/useradminindex";
}
//编辑管理员
function adduser(){
var ids = "";  
$("input:checkbox[name='checkid']:checked").each(function() { ids += this.value + ','; });
var state = $('select[name=state]').val();
var userid = $("#userid").val();
	if(ids == ""){
		alert("请选择权限！");
		return;
	}
	/* 执行 */
	$.ajax({
    	type:'post',
        url:'${BASE_URL}/background/useradmin/updateUserAdmin',
        data:{
			userid:userid,
        	checkid:ids,
        	state:state
        },
        dataType:'json',
        success:function(data){
        	 if(data == '1'){
     			window.location.href="${BASE_URL}/background/useradmin/useradminindex";
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
</script>
<section class="hbox stretch">
    <aside class="aside-md bg-white b-r">
        <section class="vbox">
            <header class="b-b header">
                <p class="h4">添加管理员</p>
            </header>
                
            <section class="scrollable wrapper w-f">
                <form class="form-horizontal" id="add_form"  method="post">
                
                   <div class="form-group"><input type="hidden" id="userid" value="${user.userid}">
                   		<label class="col-sm-2 control-label"><font class="red">* </font>账户</label>
   						<div class="col-sm-3">
     						<input readonly="readonly" type="text" class="form-control" value="${user.account}">
   						</div>	
                   </div>
                  <!--  <div class="form-group">
                   		<label class="col-sm-2 control-label"><font class="red">* </font>密码</label>
   						<div class="col-sm-3">
     						<input type="text" id="pwd" name="pwd" class="form-control" value="">
   						</div>	
                   </div>--> 
                   <div class="form-group">
                   		<label class="col-sm-2 control-label">状态</label>
   						<div class="col-sm-3">
     					<select name="state" class="form-control m-b">
                          <option value="0" <c:if test="${user.state == '0'}">selected="selected"</c:if>  >开通</option>
                          <option value="1" <c:if test="${user.state == '1'}">selected="selected"</c:if>>关闭</option>
                        </select>
   						</div>	
                   </div>
                   <div class="form-group">
                  		<label class="col-sm-2 control-label"><font class="red">* </font>权限设置</label>
   						<div class="col-sm-10">
     						<table class="table-bordered">
     							<tr height="35px" align="center"><td width="50px">序号</td><td width="200px">功能模块</td><td width="200px">选择</td></tr>
     							<c:forEach items="${list}" var="all" varStatus="status">
     							<tr height="35px" align="center"><td>${status.count}</td><td>${all.title}</td><td><input value="${all.menuid}" name="checkid" <c:if test="${all.link ne null}">checked="checked"</c:if>  type="checkbox"></td></tr>
     							</c:forEach>
     						</table>
   						</div>	 
 					</div>
 					<div class="form-group">
 						<div class="col-sm-2">
 						</div>
   						<div class="col-sm-4">
								<button type="button" class="btn btn-success" onclick="javascript:adduser();">修改</button>
								<button type="button" class="btn btn-default" onclick="javascript:back();" data-dismiss="modal">取消</button>
   						</div>
   						<div class="col-sm-6">
   						</div>	 
 					</div>
 					
                </form>
                
            </section>
        </section>
    </aside>
</section>

<jsp:include page="/view/panel/wrapper.suffix.jsp"/>