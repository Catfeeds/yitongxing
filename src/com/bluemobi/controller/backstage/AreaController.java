package com.bluemobi.controller.backstage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.controller.backstage.utils.Pagination;
import com.bluemobi.po.Area;
import com.bluemobi.service.AreaService;
import com.bluemobi.service.LanguageService;
import com.bluemobi.to.ResponseBean;

import flex.messaging.util.URLDecoder;

/**
 * @author   xiaojin_wu
 * @datetime 2017年7月27日
 * @description
 * 			 后台地区管理
 */
@Controller
@RequestMapping("/backstage/area")
public class AreaController extends AbstractWebController{

	/**
	 * 地区服务
	 */
	@Autowired
	private AreaService areaService;
	
	/**
	 * 语言服务
	 */
	@Autowired
	private LanguageService languageService;
	
	/**
	 * 后台语言查看列表
	 */
	@RequestMapping(value = "/areaList")
	public String orderList(HttpServletRequest request) {
		LOGGER.info("进入后台地区列表");
		String offset = request.getParameter("offset"); 
		String row = request.getParameter("row");
		Map<String, Object> map = new HashMap<>();
		LOGGER.info("当前地区列表页码---------"+offset+","+row);
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
		List<Map<String, Object>> list = areaService.getList(map);
		int count = areaService.getAreaListCounts();//总条数
		request.setAttribute("list", list);
		request.setAttribute("paginationHtml", Pagination.getIstance().getPaginationHtml(request.getContextPath()+"/backstage/area/areaList", offset, row, count+""));
		return "/area/areaList";
	}
	
	/**
	 * 新增父地区拼接前端select标签
	 * @param request
	 */
	@RequestMapping(value = "/languageSelect")
	@ResponseBody
	public ResponseBean getSelectList(HttpServletRequest request) {
		List<Map<String, Object>> list = languageService.getSelectList();
		StringBuffer html = new StringBuffer("<option value='0'>请选择</option>");
		if(null != list && list.size()>0){
			for(Map<String, Object> map : list){
				html.append("<option value='").append(map.get("languageid")).append(",")
					.append(map.get("languageEng")).append("'>").append(map.get("languagename"))
					.append("</option>");
			}
		}
		return new ResponseBean(ResponseBean.SUCCESS,html.toString());
	}
	
	
	/**
	 * 拼接前端select标签
	 * 父地区信息
	 * @param request
	 */
	@RequestMapping(value = "/parentSelect")
	@ResponseBody
	public ResponseBean getParentList(HttpServletRequest request) {
		List<Map<String, Object>> list = areaService.getParentList();
		StringBuffer html = new StringBuffer("<option value='0'>请选择</option>");
		if(null != list && list.size()>0){
			for(Map<String, Object> map : list){
				html.append("<option value='").append(map.get("areaid")).append("'>")
					.append(map.get("areaname"))
					.append("</option>");
			}
		}
		return new ResponseBean(ResponseBean.SUCCESS,html.toString());
	}
	
	
	
	/**
	 * 新增国家
	 * @param request
	 */
	@RequestMapping(value = "/addParent")
	@ResponseBody
	public ResponseBean addParent(HttpServletRequest request) {
		ResponseBean responseBean = null;
		String areaname = request.getParameter("areaname");
		String languageid = request.getParameter("languageid");
		
		try {
			areaname = URLDecoder.decode(areaname, "utf-8");
			languageid = URLDecoder.decode(languageid, "utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		} ;
		if(com.alibaba.dubbo.common.utils.StringUtils.isNotEmpty(areaname) && com.alibaba.dubbo.common.utils.StringUtils.isNotEmpty(languageid)){
			Area area = new Area();
			String[] language = languageid.split(",");
			area.setAreaname(areaname);
			area.setLanguageid(Integer.valueOf(language[0].trim()));
			area.setAreaEng(language[1]);
			area.setHotcityid(0);
			area.setParentid(0);
			areaService.save(area);
			responseBean = new ResponseBean(ResponseBean.SUCCESS,"新增国家成功");
		}else{
			responseBean = new ResponseBean(ResponseBean.FAIL,"新增国家参数不全");
		}
		return responseBean;
	}
	
	/**
	 * 新增国家
	 * @param request
	 */
	@RequestMapping(value = "/add")
	@ResponseBody
	public ResponseBean add(HttpServletRequest request) {
		ResponseBean responseBean = null;
		String areaChildName = request.getParameter("areaChildName");
		String parentArea = request.getParameter("parentArea");
		String childLanguage = request.getParameter("childLanguage");
		String hotcity = request.getParameter("hotcity");
		
		try {
			areaChildName = URLDecoder.decode(areaChildName, "utf-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(com.alibaba.dubbo.common.utils.StringUtils.isNotEmpty(areaChildName) && com.alibaba.dubbo.common.utils.StringUtils.isNotEmpty(childLanguage)){
			Area area = new Area();
			String[] language = childLanguage.split(",");
			area.setAreaname(areaChildName);
			area.setLanguageid(Integer.valueOf(language[0].trim()));
			area.setAreaEng(language[1]);
			area.setHotcityid(Integer.valueOf(hotcity));
			area.setParentid(Integer.valueOf(parentArea));
			areaService.save(area);
			responseBean = new ResponseBean(ResponseBean.SUCCESS,"新增地区成功");
		}else{
			responseBean = new ResponseBean(ResponseBean.FAIL,"新增地区参数不全");
		}
		return responseBean;
	}
}
