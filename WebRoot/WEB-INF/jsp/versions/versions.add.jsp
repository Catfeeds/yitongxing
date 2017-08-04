<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script type="text/javascript">
	//添加
	function addVersionsForm() {
		if($("#versions").val()=="") {
			alert("版本号不能为空");
			return false;
		}
		var file=check_file();
		if(file=="0") {
			alert("文件只能为apk类型");
			return false;
		} else if(file=="2") {
			alert("文件不能为空");
			return false;
		}
		if($("#context").val()=="") {
			alert("更新内容不能为空");
			return false;
		} else {
			if($("#context").val().length>500) {
				alert("更新内容不能超过500字");
				return false;
			}
		}
		$(".input-submit").attr('disabled', true);
		document.edit_form.action='${BASE_URL}'+"/background/versions/insertVersions";
		document.edit_form.submit();
	}
	function check_file(){
        var fileName = document.getElementById("fileurl").value;
		var file_suffix = fileName.substr(fileName.lastIndexOf(".")).toLowerCase();
		var su="1";
        if(fileName!="") {
            var lx=".apk";
           	if(file_suffix!=lx) {
           		su="0";
           	}
        } else {
        	su="2";
        }
        return su;
    }
	//返回
	function backVersions() {
		window.top.location='${BASE_URL}/background/versions/findVersionsList';
	}
</script>
<section class="hbox stretch">
    <aside class="aside-md bg-white b-r">
        <section class="vbox">
            <header class="b-b header">
                <p class="h4">添加</p>
            </header>
            <section class="scrollable wrapper w-f">
            	<div class="col-sm-12">
	                <form class="form-horizontal" id="edit_form" name="edit_form" action="#" method="post" enctype="multipart/form-data">
	                	<div class="form-group">
	                        <label for="trainname" class="col-sm-3 control-label"><font class="red">* </font>类型</label>
                            <div class="col-sm-3">
                            	 <select name="istype" class="form-control" style="width: 150px;">
		                       		<option value="1">用户端</option>
		                       		<option value="2">翻译端</option>
		                       	</select>
                             </div>
	                      </div>
	                	<div class="form-group">
	                        <label for="trainname" class="col-sm-3 control-label"><font class="red">* </font>版本号</label>
                            <div class="col-sm-3">
                            	<input type="text" class="form-control" id="versions" name="versions" maxlength="10"/>
                             </div>
	                      </div>
	                      <div class="form-group">
	                        <label for="trainname" class="col-sm-3 control-label"><font class="red">* </font>文件</label>
                            <div class="col-sm-3">
                            	<input type="file" class="form-control" id="fileurl" name="fileurl"/>
                             </div>
	                      </div>
	                    <div class="form-group">
	                        <label for="trainname" class="col-sm-3 control-label"><font class="red">* </font>更新内容</label>
                            <div class="col-sm-3">
                            	<textarea class="form-control" id="context" name="context" style="height: 100px;"></textarea>
                             </div>
	                      </div>
	                </form>
	            </div>
            </section>
        
            <footer class="footer b-t bg-white-only">
                <div class="m-t-sm">
                    <button type="button" class="btn btn-s-md btn-primary btn-sm input-submit" onclick="addVersionsForm()">保存</button>
                    <button type="button" class="btn btn-danger btn-sm input-submit" onclick="backVersions()">取消</button>
                    <span id="edit_notice"></span>
                </div>
            </footer>
        </section>
    </aside>
</section>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>