<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="page-sidebar-wrapper">
	<div class="page-sidebar navbar-collapse collapse">
		<ul class="page-sidebar-menu   " data-keep-expanded="false"
			data-auto-scroll="true" data-slide-speed="200">

			<li class="heading">
				<h3 class="uppercase">数据管理</h3>
			</li>
			<li class="nav-item  " name="auditExamine">
			<a href="javascript:;" class="nav-link nav-toggle"> 
				<i class="icon-puzzle"></i> 
				<span class="title">资料审核管理</span> 
				<span class="arrow"></span> 
			</a>
				<ul class="sub-menu">
					<li class="nav-item  " name="audit">
						<a href="<%=request.getContextPath()%>/backstage/userAudit/audit" class="nav-link "> 
						<span class="title">资料审核管理</span> 
						</a>
					</li>
				</ul>
			</li>
		

			<li class="nav-item  " name="orderManagement">
			<a href="javascript:void(0);" class="nav-link nav-toggle"> 
				<i class="icon-docs"></i> 
				<span class="title">订单管理</span> 
				<span class="arrow"></span> 
			</a>
				<ul class="sub-menu">
					<li class="nav-item  " name="order">
						<a href="<%=request.getContextPath()%>/backstage/order/orderList" class="nav-link "> 
						<span class="title">订单管理</span> 
						</a>
					</li>
					<li class="nav-item  " name="preOrder">
						<a href="<%=request.getContextPath()%>/backstage/order/preOrderList" class="nav-link "> 
						<span class="title">预约订单管理</span> 
						</a>
					</li>
				</ul>
			</li>
		
		

			<li class="nav-item  " name="area">
			<a href="javascript:;" class="nav-link nav-toggle"> 
				<i class="icon-pointer"></i> 
				<span class="title">地区管理</span> 
				<span class="arrow"></span> 
			</a>
				<ul class="sub-menu">
					<li class="nav-item  " name="areaList">
						<a href="<%=request.getContextPath()%>/backstage/area/areaList" class="nav-link "> 
						<span class="title">地区管理</span> 
						</a>
					</li>
				</ul>
			</li>
		

			<li class="nav-item  " name="language">
			<a href="javascript:;" class="nav-link nav-toggle"> 
				<i class="icon-social-dribbble"></i> 
				<span class="title">语种管理</span> 
				<span class="arrow"></span> 
			</a>
				<ul class="sub-menu">
					<li class="nav-item  " name="languageList">
						<a href="<%=request.getContextPath()%>/backstage/language/languageList" class="nav-link "> 
						<span class="title">语种管理</span> 
						</a>
					</li>
				</ul>
			</li>

			<li class="nav-item  " name="withdraw">
			<a href="javascript:;" class="nav-link nav-toggle"> 
				<i class="icon-wallet"></i> 
				<span class="title">提现管理</span> 
				<span class="arrow"></span> 
			</a>
				<ul class="sub-menu">
					<li class="nav-item  " name="withdrawList">
						<a href="<%=request.getContextPath()%>/backstage/withdraw/withdrawApplyList" class="nav-link "> 
						<span class="title">提现管理</span> 
						</a>
					</li>
				</ul>
			</li>
			
			<li class="nav-item" name="refund">
			<a href="javascript:;" class="nav-link nav-toggle"> 
				<i class="icon-bulb"></i> 
				<span class="title">退款管理</span> 
				<span class="arrow"></span> 
			</a>
				<ul class="sub-menu">
					<li class="nav-item  " name="refundList">
						<a href="<%=request.getContextPath()%>/backstage/refund/refundApplyList" class="nav-link "> 
						<span class="title">退款管理</span> 
						</a>
					</li>
				</ul>
			</li>
			
			
			<li class="nav-item" name="version">
			<a href="javascript:;" class="nav-link nav-toggle"> 
				<i class="icon-settings"></i> 
				<span class="title">版本管理</span> 
				<span class="arrow"></span> 
			</a>
				<ul class="sub-menu">
					<li class="nav-item  " name="versionList">
						<a href="<%=request.getContextPath()%>/backstage/version/versionList" class="nav-link "> 
						<span class="title">版本管理</span> 
						</a>
					</li>
				</ul>
			</li>
			
		</ul>
		
		<!-- END SIDEBAR MENU -->
	</div>
	<!-- END SIDEBAR -->
</div>