<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script type="text/javascript">
function edit(id){
window.location.href="${BASE_URL}/background/word/edit?id="+id;
}
function getOne(id){
	window.location.href="${BASE_URL}/background/word/get?id="+id;
}
</script>
<section class="hbox stretch">
    <aside class="aside-md bg-white b-r">
        <section class="vbox">
            <header class="b-b header">
                <p class="h4">文字管理</p>
            </header>
                
            <section class="scrollable wrapper w-f">
                <form class="form-horizontal" id="edit_form" method="post" enctype="multipart/form-data">
                   <div class="form-group">
                  		<div class="col-sm-1">
   						</div>
   						<div class="col-sm-11">
     						<table class="table-bordered">
     							<tr height="50px" align="center"><td width="50px">序号</td><td width="200px">标题</td><td width="200px">内容</td><td width="200px">操作</td></tr>
     							<c:forEach items="${list}" var="l" varStatus="status">
     							<tr height="35px" align="center"><td>${status.count}</td><td>${l.title}</td><td><a href="javascript:getOne(${l.wordid})">${l.content}</a></td>
     								<td><a href="javascript:edit(${l.wordid})">编辑</a></td></tr>
     							</c:forEach>
     						</table>
   						</div>	 
 					</div>
                </form>
            </section>
        </section>
    </aside>
</section>

<jsp:include page="/view/panel/wrapper.suffix.jsp"/>