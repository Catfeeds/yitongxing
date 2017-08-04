<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/view/panel/wrapper.prefix.jsp"/>
<script>
function back(){
window.location.href="${BASE_URL}/background/word/word_index";
}
</script>
<section class="hbox stretch">
    <aside class="aside-md bg-white b-r">
        <section class="vbox">
            <header class="b-b header">
                <p class="h4">${word.title}</p>
            </header>
                
            <section class="scrollable wrapper w-f">
                <form class="form-horizontal" id="edit_form" method="post" enctype="multipart/form-data">
                   <div class="form-group">
   						<div class="col-sm-7">
     						<textarea class="form-control" rows="18">${word.content}</textarea>
   						</div>
   						 <div class="col-sm-5"></div>	 
 					</div>
                </form>
            </section>
            
            <footer class="footer b-t bg-white-only">
                <div class="m-t-sm">
                    <button type="button" data_submit_type="submit_cancel" class="btn btn-danger btn-sm input-submit" onclick="javascript:back()">返回</button>
                    <span id="edit_notice"></span>
                </div>
            </footer>
        </section>
    </aside>
</section>

<jsp:include page="/view/panel/wrapper.suffix.jsp"/>