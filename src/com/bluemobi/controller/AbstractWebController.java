package com.bluemobi.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.appcore.context.AppContext;
import com.appcore.security.AccessToken;
import com.appcore.service.TokenService;
import com.appcore.util.AjaxUtil;
import com.appcore.util.CookieUtil;
import com.appcore.util.SessionUtil;
import com.bluemobi.po.Menu;
import com.bluemobi.po.User;
import com.bluemobi.service.MenuService;
import com.bluemobi.util.CommonUtils;

/**
 * 抽象的web控制器
 * 
 * @Description
 * @author haojian 309444359@qq.com
 * @date 2015-10-26 下午5:14:41
 * 
 */
public abstract class AbstractWebController {

	public static final Logger LOGGER = LoggerFactory.getLogger(AbstractWebController.class);

	@Autowired
	private MenuService menuService;

	/**
	 * 初始化界面调用
	 * @author HeWeiwen 2015-1-28
	 * @param model
	 * @return
	 */
	public void initIndex(Model model, HttpServletRequest req) {
		if(AjaxUtil.checkIsAjax(req)) {
    		return;
    	}
		User user = (User) SessionUtil.getAttribute(req, "userSession_admin");
		model.addAttribute("user", user);
		List<Menu> menuList = menuService.getAllMenu(user.getUserid());
		model.addAttribute("menuList", menuList);
	}

	/**
	 * 获取当前登陆用户
	 * @author yubin
	 * @param request
	 * @return
	 */
	public User getUser(HttpServletRequest request) {
		return (User) SessionUtil.getAttribute(request, "userSession_admin");//乙方封装在java包中
	}
	
	/**
	 * 获取工程WebRoot绝对路径
	 * @author yubin
	 * @return
	 */
	public String getTomcatRoot(HttpServletRequest request) {
		String path = AbstractWebController.class.getResource("/").getPath().substring(0, AbstractWebController.class.getResource("/").getPath().indexOf("WEB-INF") - 1);
		path = path.substring(0, path.lastIndexOf("/"));
		return path;
	}
	
	/**
	 * 获取工程WebRoot绝对路径
	 * @author yubin
	 * @return
	 */
	public String getTomcatPath() {
		return AbstractWebController.class.getResource("/").getPath().substring(0,
				AbstractWebController.class.getResource("/").getPath().indexOf("WEB-INF") - 1);
	}
	
	/**
	 * 获取userId
	 * 
	 * @author haojian
	 * @date 2015-10-15 上午10:09:30
	 * @return
	 * @return int
	 */
	public int getUserid() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		// 1、校验客户端cookie里面的token是否为空
		String tokenId = CookieUtil.getCookieValue(request, SessionUtil.bm_token);
		if (tokenId == null || "".equals(tokenId)) {
			LOGGER.error("来自【{}】的请求中没有tokenId", CommonUtils.toIpAddr(request));
			return 0;
		}
		// 2、校验服务端自定义session里面的accessToken对象是否为空
		TokenService tokenService = (TokenService) AppContext.getBean("tokenService");
		AccessToken accessToken = tokenService.checkToken(tokenId);
		return Integer.valueOf(accessToken.getUserId());
	}
	
}