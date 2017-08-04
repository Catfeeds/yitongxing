<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script>
function save(){
	var title = $("#mes_title").val();
	var content = $("textarea[name=content]").val();
	if($.trim(title) == ""){
		alert("消息标题不可为空！");
		return;
	}
	if($.trim(content) == ""){
		alert("内容不可为空！");
		return;
	}
	if(content.length > 500){
		alert("内容过长！");
		return;
	}
	/* 执行 */
	$.ajax({
    	type:'post',
        url:'${BASE_URL}/background/message/saveMessage',
        data:{content:content,title:title},
        dataType:'json',
        success:function(data){
        	 if(data == '1'){
     			window.location.href="${BASE_URL}/background/message/index";
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

function back(){
	window.location.href="${BASE_URL}/background/message/index";
}
</script>
<section class="hbox stretch">
    <aside class="aside-md bg-white b-r">
        <section class="vbox">
            <header class="b-b header">
                <p class="h4">添加消息</p>
            </header>
                
            <section class="scrollable wrapper w-f">
                <form class="form-horizontal" id="f_message" method="post" enctype="multipart/form-data">
                   <div class="form-group">
                   		<div class="col-sm-4">
                   			<label for="mes_title">消息标题:</label>
                   			<input id="mes_title" name="title" class="form-control" placeholder="请输入消息标题" />
                   		</div>
                   </div>
                   <div class="form-group">
   						<div class="col-sm-7">
   							<label for="mes_content">消息内容:</label>
     						<textarea id="mes_content" name="content" class="form-control" rows="15" placeholder="请输入消息内容"></textarea>
   						</div>
   						<div class="col-sm-5"></div>	 
 					</div>
                </form>
            </section>
            
            <footer class="footer b-t bg-white-only">
                <div class="m-t-sm">
                    <button type="button" data_submit_type="submit_save_back"  class="btn btn-s-md btn-primary btn-sm input-submit" onclick="javascript:save()">提交</button>
                    <button type="button" data_submit_type="submit_cancel" class="btn btn-danger btn-sm input-submit" onclick="javascript:back()">返回</button>
                    <span id="edit_notice"></span>
                </div>
            </footer>
        </section>
    </aside>
</section>

<jsp:include page="/view/panel/wrapper.suffix.jsp"/>