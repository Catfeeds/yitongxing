package com.bluemobi.controller.app;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.po.User;
import com.bluemobi.service.LanguageService;
import com.bluemobi.service.UserService;
import com.bluemobi.to.ResponseBean;

/**
 * 我的接口
 */
@Controller
@RequestMapping("app/language")
public class AppLanguageController extends AbstractWebController {

	private static final Logger log = LoggerFactory
			.getLogger(AppLanguageController.class);

	@Autowired
	private LanguageService languageService;

	@Autowired
	private UserService userService;

	/**
	 * 获取语种列表
	 */
	@RequestMapping(value = "getLanguage", method = { RequestMethod.POST,
			RequestMethod.GET })
	@ResponseBody
	public ResponseBean getLanguage(String languageEng, String hotLanguageId,
			Integer userId) {// TODO
		log.info("getLanguage————>languageEng:" + languageEng
				+ ",hotLanguageId:" + hotLanguageId);
		try {
			Map<String, Object> languageMap = new HashMap<String, Object>();
			languageMap.put("languageEng", languageEng);
			languageMap.put("hotLanguageId", hotLanguageId);
			List<Map<String, Object>> list = languageService.getLanguage(languageMap);
			if (userId != null ) {
				User user = userService.getUser(userId);
				String[] languages = user.getNeedlanguageid().split(",");
				for (Map<String, Object> map : list) {
					Integer languageid = (Integer) map.get("languageid");
					int exist = 1;
					for (int i = 0; i < languages.length; i++) {
						String userlanguageid = languages[i];
						if (userlanguageid.equals(languageid.toString())) {
							exist=0;
						}
					}
					map.put("exist", exist);
				}
			}
			return new ResponseBean(ResponseBean.SUCCESS, "", list);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常！");
		}
	}

}