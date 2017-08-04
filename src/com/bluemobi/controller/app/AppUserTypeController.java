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
import com.bluemobi.service.UserService;
import com.bluemobi.service.UserTypeService;
import com.bluemobi.to.ResponseBean;

/**
 * 我的接口
 */
@Controller
@RequestMapping("app/usertype")
public class AppUserTypeController extends AbstractWebController {

	private static final Logger log = LoggerFactory
			.getLogger(AppUserTypeController.class);

	@Autowired
	private UserTypeService userTypeService;
	
	@Autowired
	private UserService userService;


	/*
	 * 译员类型列表
	 */
	@RequestMapping(value = "getusertype", method = { RequestMethod.POST,RequestMethod.GET })
	@ResponseBody
	public ResponseBean getusertype(String typeEng,Integer userId) {// TODO
		log.info("getusertype————>typeEng:"+typeEng+",userId"+userId);
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("typeEng", typeEng);
			List<Map<String, Object>> list = userTypeService.getusertype(map);
			if (userId != null ) {
				User user = userService.getUser(userId);
				String[] usertypes = user.getUsertype().split(",");
				for (Map<String, Object> usertypemap : list) {
					Integer typeid = (Integer) usertypemap.get("typeid");
					int exist = 1;
					for (int i = 0; i < usertypes.length; i++) {
						String usertypesid = usertypes[i];
						if (usertypesid.equals(typeid.toString())) {
							exist=0;
						}
					}
					map.put("exist", exist);
				}
			}
			return new ResponseBean(ResponseBean.SUCCESS, "获取译员类型列表成功！", list);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常！");
		}
	}

}