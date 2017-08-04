package com.bluemobi.controller.app;

import io.rong.methods.RongUser;
import io.rong.models.TokenResult;

import java.util.ArrayList;
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

import com.bluemobi.conf.Config;
import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.po.User;
import com.bluemobi.service.UserService;
import com.bluemobi.to.ResponseBean;

/**
 * 聊天接口
 */
@Controller
@RequestMapping("app/chat")
public class AppChatController extends AbstractWebController{
	private static final Logger log = LoggerFactory.getLogger(AppChatController.class);
	
	@Autowired
	private UserService userService;
	
	/**
	 * 通过用户id获取token
	 */
	@RequestMapping(value="getToken", method={RequestMethod.POST,RequestMethod.GET})//TODO
	@ResponseBody
	public ResponseBean getToken(Integer userId) {
		log.info("getToken————>userId:" + userId);
		try {
			List<Map<String, String>> tokenList=new ArrayList<>();
			Map<String, String> tokenMap=new HashMap<String, String>();
 			User user = userService.getUser(userId);
			if (user==null) {
				return new ResponseBean(ResponseBean.FAIL, "获取用户信息失败");
			}
			if (user.getName().equals("")) {
				return new ResponseBean(ResponseBean.FAIL, "请填写用户名");
			}
			if (user.getHeadurl().equals("")) {
				return new ResponseBean(ResponseBean.FAIL, "请上传头像");
			}
			RongUser rongUser = new RongUser(Config.RONG_APPKEY, Config.RONG_APPSECRET);
			TokenResult tokenResult=rongUser.getToken(userId.toString(), user.getName(), user.getHeadurl());
			String token = tokenResult.getToken();
			tokenMap.put("token", token);
			tokenList.add(tokenMap);
			if (!token.equals("")) {
				return new ResponseBean(ResponseBean.SUCCESS, "获取token成功",tokenList);
			}
			else {
				return new ResponseBean(ResponseBean.FAIL, "获取token失败");
			}
		} catch (Exception e) {
			e.getStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取token失败");
		}
	}

}
