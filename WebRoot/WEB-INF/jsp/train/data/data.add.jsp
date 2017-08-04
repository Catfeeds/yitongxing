<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script charset="utf-8" src="${STATIC_URL}/kindeditor/kindeditor.js"></script>
<script charset="utf-8" src="${STATIC_URL}/kindeditor/lang/zh_CN.js"></script>
<script type="text/javascript">
	//返回
	function blackTrain() {
		window.top.location='${BASE_URL}/background/train/dataindex';
	}
	$(document).ready(function() {
		KindEditor.ready(function(K) {
			K.create('#content1',{afterBlur: function(){
					this.sync();
				}
			});
		});
	});
	//添加
	function addForm() {
		if($("#dataname").val()=="") {
			alert("题目不能为空");
			return false;
		}
		if($("#content1").val()=="") {
			alert("培训内容不能为空");
			return false;
		}
		document.edit_form.action='${BASE_URL}/background/train/adddata';
		document.edit_form.submit();
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
	                <form class="form-horizontal" id="edit_form" name="edit_form" action="#" method="post">
	                    <div class="form-group">
	                        <label for="dataname" class="col-sm-3 control-label"><font class="red">* </font>题目</label>
                            <div class="col-sm-6">
                            	<input type="text" class="form-control" id="dataname" name="dataname" onkeydown="if(event.keyCode==13)return false;" placeholder="请输入" maxlength="100"/>
                             </div>
	                      </div>
	                      <div class="form-group">
	                        <label for="content" class="col-sm-3 control-label"><font class="red">* </font>培训内容</label>
                            <div class="col-sm-6">
                            	<textarea id="content1" name="context" style="width: 100%; height: 400px; visibility: hidden;"></textarea>
                             </div>
	                      </div>
	                </form>
	            </div>
            </section>
        
            <footer class="footer b-t bg-white-only">
                <div class="m-t-sm">
                    <button type="button" class="btn btn-s-md btn-primary btn-sm input-submit" onclick="addForm()">保存</button>
                    <button type="button" class="btn btn-danger btn-sm input-submit" onclick="blackTrain()">取消</button>
                    <span id="edit_notice"></span>
                </div>
            </footer>
        </section>
    </aside>
</section>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>