package com.bluemobi.controller.app;

import java.io.IOException;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.service.AreaService;
import com.bluemobi.to.ResponseBean;


/**
 * 语言接口
 */
@Controller
@RequestMapping("app/area")
public class AppAreaController extends AbstractWebController {
	
	private static final Logger log = LoggerFactory.getLogger(AppAreaController.class);
	
	@Autowired
	private AreaService areaService;
	
	@RequestMapping(value = "getAreaList", method = {RequestMethod.POST,RequestMethod.GET})
	  public void exchangeJson(HttpServletRequest request,HttpServletResponse response) {  
	      try {  
	    	  	response.setCharacterEncoding("UTF-8");
		        response.setContentType("text/plain");  
		        response.setHeader("Pragma", "No-cache");  
		        response.setHeader("Cache-Control", "no-cache");   
		        response.setDateHeader("Expires", 0);  
		        List<Map<String, Object>> getareList=areaService.getArea("0","CN");
		        Map<String,List<Map<String, Object>>> map = new HashMap<>();
	         	map.put("result", getareList);  
	         	PrintWriter out = response.getWriter();       
	         	JSONObject resultJSON = JSONObject.fromObject(map); //根据需要拼装json  
	         	String jsonpCallback = request.getParameter("fun");//客户端请求参数  
	         	out.println(jsonpCallback+"("+resultJSON.toString(1,1)+")");//返回jsonp格式数据  
	         	out.flush();  
	         	out.close();  
		      } catch (IOException e) {  
		      e.printStackTrace();  
		    }  
	    }  
	
	
	
	/**
	 * 获取城市
	 * 国家为 0
	 */
	@RequestMapping(value = "getArea", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean getArea(String areaId,String areaEng) {//TODO
		log.info("getArea————>areaId:" + areaId+",areaEng:"+areaEng);
		try {
			return new ResponseBean(ResponseBean.SUCCESS, "", areaService.getArea(areaId,areaEng));
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常！");
		}
	}
	
	/**
	 * 获取热门城市
	 */
	@RequestMapping(value = "getHotCity", method = RequestMethod.POST)
	@ResponseBody
	public ResponseBean getHotArea(String hotCityId,String areaEng) {//TODO
		log.info("getHotCity————>hotCityId:" + hotCityId+",areaEng:"+areaEng);
		try {
			return new ResponseBean(ResponseBean.SUCCESS, "", areaService.getHotCity(hotCityId, areaEng));
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常！");
		}
	}
	
	
}