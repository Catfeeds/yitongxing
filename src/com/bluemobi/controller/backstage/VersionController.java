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
import com.bluemobi.service.VersionsService;
import com.bluemobi.service.WithDrawCashApplyService;
import com.bluemobi.util.PreciseCompute;

/**
 * @author   xiaojin_wu
 * @datetime 2017年7月31日
 * @description
 * 			app版本信息
 */
@Controller
@RequestMapping("/backstage/version")
public class VersionController extends AbstractWebController{

	/**
	 * app版本服务
	 */
	@Autowired
	private VersionsService versionsService;
	
	/**
	 * 后台订单查看列表
	 */
	@RequestMapping(value = "/versionList")
	public String orderList(HttpServletRequest request) {
		LOGGER.info("进入后台app版本查看列表");
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
		List<Map<String, Object>> list = versionsService.find(map);
		int count = versionsService.getVersionsCount();//总条数
		request.setAttribute("list", list);
		request.setAttribute("paginationHtml", Pagination.getIstance().getPaginationHtml(request.getContextPath()+"/backstage/version/versionList", offset, row, count+""));
		return "/versions/versionList";
	}
}
