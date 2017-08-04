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
import com.bluemobi.service.WithDrawCashApplyService;
import com.bluemobi.util.PreciseCompute;

/**
 * @author   xiaojin_wu
 * @datetime 2017年7月28日
 * @description
 * 			 后台提现申请
 */
@Controller
@RequestMapping("/backstage/withdraw")
public class WithdrawCashController extends AbstractWebController{

	/**
	 * 提现申请服务
	 */
	@Autowired
	private WithDrawCashApplyService withDrawCashApplyService;
	
	/**
	 * 后台订单查看列表
	 */
	@RequestMapping(value = "/withdrawApplyList")
	public String orderList(HttpServletRequest request) {
		LOGGER.info("进入后台提现申请查看列表");
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
		List<Map<String, Object>> list = withDrawCashApplyService.getWithDrawApplyList(map);
		int count = withDrawCashApplyService.getWithDrawApplyCount();//总条数
		request.setAttribute("list", list);
		request.setAttribute("paginationHtml", Pagination.getIstance().getPaginationHtml(request.getContextPath()+"/backstage/withdraw/withdrawApplyList", offset, row, count+""));
		return "/withdrawCash/withdrawCashApplyList";
	}
}
