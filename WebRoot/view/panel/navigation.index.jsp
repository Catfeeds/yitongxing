<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@page import="com.bluemobi.po.*" %>

<jsp:include page="/view/panel/wrapper.prefix.jsp"/>

<script src="${STATIC_URL}/panel/js/navigation.index.js"></script>

<section class="vbox">
    <header class="header bg-white b-b clearfix">
        <div class="row m-t-sm">
            <div class="col-sm-7 m-b-xs">
                <div class="btn-group">
                    <button type="button" class="btn btn-sm btn-default action-refresh" title="Refresh"><i class="fa fa-refresh"></i></button>
                </div>
                <a href="${BASE_URL}/panel/navigation/add" data-toggle="ajaxModal" class="btn btn-sm btn-default" id="modal_edit"><i class="fa fa-plus"></i> 添加</a>
            </div>
        </div>
    </header>
        
    <section class="scrollable wrapper">
        <section class="panel panel-default">
            <div class="table-responsive">
                <table class="table table-striped m-b-none datagrid" id="navigation_listing">
                    <thead>
                    </thead>
                </table>
            </div>
        </section>
    </section>
</section>

<jsp:include page="/view/panel/wrapper.suffix.jsp"/>