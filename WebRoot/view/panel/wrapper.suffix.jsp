<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% boolean isAjax = com.appcore.util.AjaxUtil.checkIsAjax(request); %><!--确定指定的HTTP请求是否是AJAX请求(返回值Boolean) -->
<c:if test="${isAjax != true}">
		<jsp:include page="/view/panel/inc/footer.jsp"/>
	</body>
</html>
</c:if>    