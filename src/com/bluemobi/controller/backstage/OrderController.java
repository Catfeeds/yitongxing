package com.bluemobi.controller.backstage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.controller.backstage.utils.Pagination;
import com.bluemobi.service.MaketransService;
import com.bluemobi.service.OrderService;

/**
 * @author   xiaojin_wu
 * @datetime 2017年7月27日
 * @description
 * 			 后台查看订单
 */
@Controller
@RequestMapping("/backstage/order")
public class OrderController extends AbstractWebController{

	/**
	 * 订单服务
	 */
	@Autowired
	private OrderService orderService;
	
	/**
	 * 预约订单服务
	 */
	@Autowired
	private MaketransService maketransService;
	
	/**
	 * 后台订单查看列表
	 */
	@RequestMapping(value = "/orderList")
	public String orderList(HttpServletRequest request) {
		LOGGER.info("进入后台订单查看列表");
		String offset = request.getParameter("offset"); 
		String row = request.getParameter("row");
		Map<String, Object> map = new HashMap<>();
		LOGGER.info("订单页码---------"+offset+","+row);
		//默认首页
		if(com.alibaba.dubbo.common.utils.StringUtils.isBlank(offset)){
			offset = "0";
		}
		//默认首页15条数据
		if(com.alibaba.dubbo.common.utils.StringUtils.isBlank(row)){
			row = "15";
		}
		map.put("offset", Integer.valueOf(offset));
		map.put("rows", Integer.valueOf(row));
		List<Map<String, Object>> list = orderService.getList(map);
		int count = orderService.getOrderListCounts();//总条数
		request.setAttribute("list", list);
		request.setAttribute("paginationHtml", Pagination.getIstance().getPaginationHtml(request.getContextPath()+"/backstage/order/orderList", offset, row, count+""));
		return "/order/orderList";
	}
	
	
	/**
	 * 后台预约订单查看列表
	 */
	@RequestMapping(value = "/preOrderList")
	public String preOrderList(HttpServletRequest request) {
		LOGGER.info("进入后台预约订单查看列表");
		String offset = request.getParameter("offset"); 
		String row = request.getParameter("row");
		Map<String, Object> map = new HashMap<>();
		LOGGER.info("预约订单页码---------"+offset+","+row);
		//默认首页
		if(com.alibaba.dubbo.common.utils.StringUtils.isBlank(offset)){
			offset = "0";
		}
		//默认首页15条数据
		if(com.alibaba.dubbo.common.utils.StringUtils.isBlank(row)){
			row = "15";
		}
		map.put("offset", Integer.valueOf(offset));
		map.put("rows", Integer.valueOf(row));
		List<Map<String, Object>> list = maketransService.getList(map);
		int count = maketransService.getPreOrderListCounts();//总条数
		request.setAttribute("list", list);
		request.setAttribute("paginationHtml", Pagination.getIstance().getPaginationHtml(request.getContextPath()+"/backstage/order/preOrderList", offset, row, count+""));
		return "/order/preOrderList";
	}
}
