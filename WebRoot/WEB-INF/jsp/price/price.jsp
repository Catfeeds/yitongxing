<%@ page contentType="text/html;charset=UTF-8" import="com.bluemobi.po.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<link href="${STATIC_URL}/scripts/datepicker/css/datepicker3.css" rel="stylesheet" type="text/css"/>
<script src="${STATIC_URL}/scripts/datepicker/js/bootstrap-datepicker.js"></script>
<script src="${STATIC_URL}/scripts/datepicker/js/locales/bootstrap-datepicker.zh-CN.time.js" charset="UTF-8"></script>
<script src="${STATIC_URL}/scripts/specialty/specialty.js"></script>
<script type="text/javascript">
var areaid = '<%=request.getAttribute("areaid")%>';
function updataprice(){
	var con = confirm("确定要保存吗？");
	if(!con){
		return;
	}
	var name=$("input:text");
	for(var i=0;i<name.length;i++){
		if(!/^\d+(\.\d{1,2})?$/.test(name[i].value)){
			alert(name[i].title+"不是正确的数字值！");
			return;
		}
	}
	var form = document.getElementById("edit_form");
	form.action="${BASE_URL}/background/price/updataprice";
	form.submit();
}

$(function(){ 
	$("#areaid option[value='"+areaid+"']").attr("selected", true);
	$("#areaid").change(function(){ 
		window.location.href = "${BASE_URL}/background/price/price_index?areaid=" + $("#areaid").val();
	}); 
}); 
</script>
<section class="hbox stretch">
    <aside class="aside-md bg-white b-r">
        <section class="vbox">
            <header class="b-b header">
                <p class="h4">价格管理</p>
                <!-- ywei添加国家过滤 start -->
                <form class="form-inline">
					<div class="row m-t-sm">
						<div class="col-sm-12 m-b-xs">
							<div class="form-group col-sm-4 m-b-xs">
								<label class="control-label">所在国家：</label>
								<select name="areaid" class="form-control input-sm" id="areaid">
									<c:forEach items="${countryList}" var="countryList">
										<option value="${countryList.areaid}">${countryList.areaname}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
				</form>
				<!-- ywei添加国家过滤 end -->
            </header>
            <section class="scrollable wrapper w-f" style="margin-top: 35px;overflow:auto">
                <form class="form-horizontal" id="edit_form"  method="post" enctype="multipart/form-data">
	                <div class="container-fluid">
		                <c:forEach items="${list}" var="l">
			                <div class="form-group">
			                    <div class="col-md-2">
			                   		<div style="text-align: right;margin-top: 4%;">${l.name}：</div>
			                   	</div>
			                    <div class="col-md-2">
									<input style="width:150px;" type="text" title="${l.name}" id="${l.priceid}" value="${l.price}" name="${l.priceid}" class="input-sm form-control">
							    </div>
			                    <div class="col-md-8">
			                    	<div style="text-align: left;margin-top: 1%;">${l.remark}</div>
			                    </div>
			                     <div class="col-md-1">
			                   	</div>
			                </div>
			             </c:forEach>
		             	<div class="form-group">
		                	<div class="col-md-5">
		                		<div style="text-align: center;">
		                			<button id="bt" type="button" data-toggle="modal" onclick="updataprice()" data-target="#reason_modal" data_submit_type="submit_cancel" class="btn btn-primary btn-sm input-submit">&nbsp;&nbsp;保&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;存&nbsp;&nbsp;</button>
		                		</div>
		                	</div>
		                </div>
		            </div>
                </form>
            </section>
        </section>
    </aside>
</section>
<jsp:include page="/view/panel/wrapper.suffix.jsp"/>