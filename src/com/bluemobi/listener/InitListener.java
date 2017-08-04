package com.bluemobi.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.appcore.context.AppContext;
import com.bluemobi.conf.Config;
/**
 * web应用监听器
 * @author haojian
 * @date 2015-4-14 下午3:26:25 
 *
 */
public class InitListener implements ServletContextListener {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(InitListener.class);

    @Override
    public void contextDestroyed(ServletContextEvent arg0) {
        LOGGER.info("关闭web服务器的时候，销毁ServletContext...");
    }

    @Override
    public void contextInitialized(ServletContextEvent arg0) {
        //1、保存spring容器
        WebApplicationContext webContext = WebApplicationContextUtils.getRequiredWebApplicationContext(arg0.getServletContext());
        LOGGER.info("启动web系统的时候，获取并设置web容器启动的spring容器。【{}】", new Object[]{webContext});
        AppContext.setContext(webContext);
        //2、设置全局参数
        ServletContext context = arg0.getServletContext();
        context.setAttribute("SITE_NAME", Config.SITE_NAME);
        context.setAttribute("BASE_URL",  Config.BASE_URL);
        context.setAttribute("STATIC_URL", Config.STATIC_URL);
        context.setAttribute("IMG_URL", Config.IMG_URL);
    }
    
}
