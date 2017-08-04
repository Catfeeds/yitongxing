package com.bluemobi.controller.app;
import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.service.SpecialtyService;
import com.bluemobi.service.WordService;
import com.bluemobi.to.ResponseBean;

/**
 * 文字
 */
@Controller
@RequestMapping("app/word/")
public class AppWordController extends AbstractWebController {
	
	private static final Logger log = LoggerFactory.getLogger(AppWordController.class);
	
	@Autowired
	private WordService wordservice;
	
	@Autowired
	private SpecialtyService specialtyService;
	
	/**
	 * 获取文字信息
	 */
	@RequestMapping(value = "findWord", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean findword(HttpServletRequest request, String type) {
		log.info("findWord————>type:" + type);  
		try {
			return new ResponseBean(ResponseBean.SUCCESS, "",wordservice.getListApp(type));
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取使用帮助信息失败");
		}
	}
	
	
	/**
	 * 获取文字信息
	 */
	@RequestMapping(value = "findWordById", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean findWordById(HttpServletRequest request, String wordId) {
		log.info("findWordById————>wordId:" + wordId);  
		try {
			return new ResponseBean(ResponseBean.SUCCESS, "",wordservice.findWordById(wordId));
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取使用帮助信息失败！");
		}
	}
	
	/**
	 * 获取专业信息
	 */
	@RequestMapping(value = "getAllSpecialty", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean getAllSpecialty() {
		try {
			return new ResponseBean(ResponseBean.SUCCESS, "",specialtyService.getAllSpecialty());
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取专业信息失败");
		}
	}
}