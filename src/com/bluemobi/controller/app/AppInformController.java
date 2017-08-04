package com.bluemobi.controller.app;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.po.User;
import com.bluemobi.service.MessageService;
import com.bluemobi.service.UserService;
import com.bluemobi.to.ResponseBean;

/**
 *系统通知
 */
@Controller
@RequestMapping("app/inform/")
public class AppInformController extends AbstractWebController {
	
	private static final Logger log = LoggerFactory.getLogger(AppInformController.class);
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("getMessageListApp")
	@ResponseBody
	public ResponseBean getMessageListApp(Integer userId, Integer pageIndex, Integer pageSize) {
		log.info("getMessageListApp————>userId:" + userId+"pageIndex:"+pageIndex+"pageSize:"+pageSize);  
		try {
			User user = userService.getUser(userId);
			if(user != null) {
				List<Map<String, Object>> list = messageService.getMessageByUserId(String.valueOf(userId), pageIndex, pageSize);
				return new ResponseBean(ResponseBean.SUCCESS, "", list);
			} else {
				return new ResponseBean(ResponseBean.FAIL, "请重新登录");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "获取消息列表失败");
		}
	}
	
	/**
	 * 删除消息
	 */
	@RequestMapping(value = "deleteMessage", method = RequestMethod.POST)
	@ResponseBody
	public ResponseBean deleteMessage(Integer userId, String id) {
		log.info("deleteMsg————>userId:" + userId + ",id:" + id);
		try {
			User user = userService.getUser(userId);
			if(user != null) {
				messageService.deleteApp(id, String.valueOf(userId));
				return new ResponseBean(ResponseBean.SUCCESS, "删除成功");
			} else {
				return new ResponseBean(ResponseBean.FAIL, "请重新登录！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常！");
		}
	}
	
	/**
	 * 修改消息已读状态
	 * 
	 */
	@RequestMapping(value = "updateRead", method = RequestMethod.POST)
	@ResponseBody
	public ResponseBean updateRead(String id) {
		log.info("updateRead————>id:" + id);
		try {
			messageService.updateRead(id);
			return new ResponseBean(ResponseBean.SUCCESS, "修改状态");
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseBean(ResponseBean.FAIL, "系统异常！");
		}
	}
	
}