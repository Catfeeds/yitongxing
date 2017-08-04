package com.bluemobi.controller.backstage;



import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.service.UserService;
import com.bluemobi.to.ResponseBean;

/**
 * @author   xiaojin_wu
 * @datetime 2017年7月21日
 * @description
 * 			 后台译员审核功能	
 */
@Controller
@RequestMapping("/backstage/login")
public class LoginController extends AbstractWebController {

	/**
	 * user服务
	 */
	@Autowired
	private UserService userservice;
	
	
	/**
	 * 后台登录
	 */
	@RequestMapping(value = "/doLogin")
	@ResponseBody
	public ResponseBean audietList(HttpServletRequest request,String username,String password) {
		
		if("admin".equalsIgnoreCase(username) && "123456".equals(password)){
			return new ResponseBean(ResponseBean.SUCCESS, "登录成功");
		}else{
			return new ResponseBean(ResponseBean.FAIL, "登录失败");
		}
		
	}
	
}
