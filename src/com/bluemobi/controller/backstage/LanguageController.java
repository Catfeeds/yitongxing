package com.bluemobi.controller.backstage;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.common.utils.StringUtils;
import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.controller.backstage.utils.Pagination;
import com.bluemobi.service.LanguageService;
import com.bluemobi.to.ResponseBean;

/**
 * @author   xiaojin_wu
 * @datetime 2017年7月27日
 * @description
 * 			 后台语言管理
 */
@Controller
@RequestMapping("/backstage/language")
public class LanguageController extends AbstractWebController{

	/**
	 * 语言服务
	 */
	@Autowired
	private LanguageService languageService;
	
	/**
	 * 后台语言查看列表
	 */
	@RequestMapping(value = "/languageList")
	public String orderList(HttpServletRequest request) {
		LOGGER.info("进入后台语言列表");
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
		List<Map<String, Object>> list = languageService.getList(map);
		int count = languageService.getlanguageListCounts();//总条数
		request.setAttribute("list", list);
		request.setAttribute("paginationHtml", Pagination.getIstance().getPaginationHtml(request.getContextPath()+"/backstage/language/languageList", offset, row, count+""));
		return "/language/languageList";
	}
	

	/**
	 * 后台语言查看列表
	 */
	@RequestMapping(value = "/addLanguage")
	@ResponseBody
	public ResponseBean add(HttpServletRequest request) {
		ResponseBean responseBean = null;
		String languagename = request.getParameter("languagename");
		String languageEng = request.getParameter("languageEng");
		String hotLanguageId = request.getParameter("hotLanguageId");
		
		try {
			languagename = URLDecoder.decode(languagename,"utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(StringUtils.isNotEmpty(languagename) && StringUtils.isNotEmpty(languageEng) && StringUtils.isNotEmpty(hotLanguageId)){
			Map<String,Object> map = new HashMap<>();
			map.put("languagename", languagename);
			map.put("languageEng", languageEng);
			map.put("hotLanguageId", hotLanguageId);
			languageService.insertLanguage(map);
			responseBean = new ResponseBean(ResponseBean.SUCCESS,"新增语言成功");
		}else{
			responseBean = new ResponseBean(ResponseBean.FAIL,"新增语言失败，参数不全");
		}
		return responseBean;
	}
}
