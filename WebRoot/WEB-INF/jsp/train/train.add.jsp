<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script type="text/javascript">
	function zengjia() {
		var bb=$("#answersize").val();
		if(bb=="") {
			bb=1;
		}
		var divpj="<div class='form-group' id='gxid"+bb+"'><label for='answerid' class='col-sm-3 control-label'><input type='radio' name='answerid' onclick='onanswer("+bb+")'/></label><div class='col-sm-6'>"+
		"<table style='width: 100%'><tr><td width='90%'><input type='text' class='form-control' id='inputdivId"+bb+"' name='answer' onkeydown='if(event.keyCode==13)return false;' placeholder='请输入' maxlength='300'/><input type='hidden' name='succoption' value='"+bb+"'/></td><td style='padding-left: 10px;' width='10%'><a href='javascript:;' onclick='deleteTrain("+bb+")'>删除</a></td></tr></table></div>";
		$("#dividid").append(divpj);
		bb++;
		$("#answersize").val(bb);
	}
	function lookId() {
		if($("#trainname").val()=="") {
			alert("培训问题不能为空");
			return false;
		}
		if($("#isanswerid").val()=="") {
			alert("请选择正确答案");
			return false;
		}
		if($("#inputdivId"+$("#isanswerid").val()).val()==null) {
			alert("请选择正确答案");
			return false;
		} else {
			var succ=$("#inputdivId"+$("#isanswerid").val()).val().replace(/\s+/g,"");
			if(succ=="") {
				alert("请选择正确答案");
				return false;
			}
		}
		document.edit_form.action='${BASE_URL}/background/train/add';
		document.edit_form.submit();
	}
	//选择答案
	function onanswer(i) {
		$("#isanswerid").val(i);
	}
	//删除答案
	function deleteTrain(i) {
		$("#gxid"+i).remove();
	}
	//返回
	function blackTrain() {
		window.top.location='${BASE_URL}/background/train/index';
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
	                	<input type="hidden" id="answersize"/>
	                	<input type="hidden" id="isanswerid" name="isanswerid"/>
	                    <div class="form-group">
	                        <label for="trainname" class="col-sm-3 control-label"><font class="red">* </font>培训问题</label>
                            <div class="col-sm-6">
                            	<input type="text" class="form-control" id="trainname" name="trainname" onkeydown="if(event.keyCode==13)return false;" placeholder="请输入" maxlength="100"/>
                             </div>
	                      </div>
	                      <div class="form-group">
	                        <label for="trainname" class="col-sm-3 control-label"><font class="red">* </font>答案选项</label>
	                        <div class="col-sm-6">
                            	<table>
	                           		<tr>
	                           			<td>
		                                	<button class="btn btn-sm btn-default" type="button" onclick="return zengjia()">增加选项</button>
		                                </td>
	                           			<td style="color: red;padding-left: 10px;">
	                           				点击答案左侧勾选正确答案
	                           			</td>
	                           		</tr>
                            	</table>
	                         </div>
	                      </div>
	                      <div id="dividid">
	                      	<div class="form-group" id="gxid0">
		                        <label for="answerid" class="col-sm-3 control-label"><input type="radio" name="answerid" onclick="onanswer(0)"/></label>
	                            <div class="col-sm-6">
	                            	<table style="width: 100%">
	                            		<tr>
	                            			<td width="90%">
	                            				<input type="text" class="form-control" id='inputdivId0' name="answer" onkeydown="if(event.keyCode==13)return false;" placeholder="请输入" maxlength="300"/>
	                            				<input type="hidden" name="succoption" value="0"/>
	                            			</td>
	                            			<td style="padding-left: 10px;" width="10%">
	                            				&nbsp;
	                            			</td>
	                            		</tr>
	                                </table>
	                            </div>
		                    </div>
	                      </div>
	                </form>
	            </div>
            </section>
        
            <footer class="footer b-t bg-white-only">
                <div class="m-t-sm">
                    <button type="button" class="btn btn-s-md btn-primary btn-sm input-submit" onclick="lookId()">保存</button>
                    <button type="button" class="btn btn-danger btn-sm input-submit" onclick="blackTrain()">取消</button>
                    <span id="edit_notice"></span>
                </div>
            </footer>
        </section>
    </aside>
</section>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>