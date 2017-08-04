package com.bluemobi.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.appcore.context.AppContext;
import com.appcore.security.AccessToken;
import com.appcore.service.TokenService;
import com.appcore.util.CookieUtil;
import com.appcore.util.SessionUtil;
import com.bluemobi.util.CommonUtils;

/**
 * AccessFilter过滤
 * @author heweiwen
 * 2015-6-18 下午4:04:23
 */
public class AccessFilter implements Filter {

	private static List<String> secure_url_list;

	private static Log log = LogFactory.getLog(AccessFilter.class);
	
	@Override
	public void destroy() {
		secure_url_list = null;
	}
	
	String[] mobileAgents = {"iphone", "android", "windows nt"};

	/**
	 * 过滤器
	 */
	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain){
		
//		HttpServletRequest request = (HttpServletRequest) req;
//		HttpServletResponse response = (HttpServletResponse) resp;
//		// 解析请求URI
//		String uri = request.getRequestURI().replace(request.getContextPath(), "");
//		if (request.getHeader("User-Agent") != null && uri.indexOf(".") < 0) {
//			for (String mobileAgent : mobileAgents) {
//				if (request.getHeader("User-Agent").toLowerCase().indexOf(mobileAgent) >= 0) {
//					switch (mobileAgent) {
//					case "iphone":
//						log.info("【iPhone】手机-->IP【" + CommonUtils.toIpAddr(request) + "】-->" + "URI【" + uri + "】-->" + request.getHeader("User-Agent"));
//						break;
//					case "android":
//						log.info("【Android】手机-->IP【" + CommonUtils.toIpAddr(request) + "】-->" + "URI【" + uri + "】-->" + request.getHeader("User-Agent"));
//						break;
//					case "windows nt":
//						log.info("【windows】系统-->IP【" + CommonUtils.toIpAddr(request) + "】-->" + "URI【" + uri + "】-->" + request.getHeader("User-Agent"));
//						break;
//					default:
//						log.info("未知系统-->IP【" + CommonUtils.toIpAddr(request) + "】-->" + "URI【" + uri + "】-->" + request.getHeader("User-Agent"));
//						break;
//					}
//					break;
//				}
//			}
//		}
//		
//		if(uri.startsWith("/app")) { //APP请求不过滤
//			chain.doFilter(req, resp);
//			return;
//		}
//		if(uri.startsWith("/view")) { //静态资源文件不过滤
//			chain.doFilter(req, resp);
//			return;
//		}
//		//非过滤uri地址筛选（登陆页面地址不跳转）
//		if (uri.equals("/") || uri.startsWith("/background/login") || uri.startsWith("/background/code")) {
//			chain.doFilter(req, resp);
//			return;
//		}
		//1、校验客户端cookie里面的token是否为空
//		String tokenStr = CookieUtil.getCookieValue(request, SessionUtil.bm_token);
		//token为空
//		if (tokenStr == null) {
//			//token为空，是登陆页面的时候，直接返回
//			if(uri.startsWith("/background/code") || uri.startsWith("/background/login")){
//				chain.doFilter(req, resp);
//				return;
//			} else {
//				if(request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
//					response.setHeader("sessionstatus", "sessionOut");
//					return;
//				}
//				//token为空，并且不是登陆页面的时候，重定向
//				log.error("没有取到cookie里面的token！需要先登录！");
//				response.sendRedirect(request.getContextPath() + "/background/loginpage");
//				return;
//			}
//		}
		
		//2、校验服务端自定义session里面的accessToken对象是否为空
//		TokenService tokenService = (TokenService)AppContext.getBean("tokenService");
		//校验用户是否登陆（当AccessToken为空位未登录状态）
//		AccessToken accessToken = tokenService.checkToken(tokenStr);
		//accessToken为空
//		if (accessToken == null) {
//			//accessToken为空，是登陆页面的时候，直接返回
//			if(uri.startsWith("/background/code") || uri.startsWith("/background/login")){
//				chain.doFilter(req, resp);
//				return;
//			} else {
//				if(request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
//					response.setHeader("sessionstatus", "sessionOut");
//					return;
//				}
//				//accessToken为空，并且不是登陆页面的时候，重定向
//				log.error("服务端自定义session已过期！需要重新登录！");
//				response.sendRedirect(request.getContextPath() + "/background/loginpage");
//				return;
//			}
//		}
		try {
			//全部放行
			req.setCharacterEncoding("UTF-8");
			chain.doFilter(req, resp);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void init(FilterConfig conf) throws ServletException {
		// 获取配置URI列表
		String[] uris = conf.getInitParameter("authentication").split("\n");
		// 初始化URI列表
		secure_url_list = new ArrayList<String>(uris.length);
		// 填充URI集合
		for (String uri : uris) {
			// 配置URI为空，不作处理
			if (null == uri)
				continue;
			if ("".equals(uri.trim()))
				continue;
			// 把需要验证ACCESS TOKEN的URI加入列表
			secure_url_list.add(uri.trim());
		}
	}
}