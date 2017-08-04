package com.bluemobi.controller.app;


import java.util.HashMap;
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

import com.bluemobi.service.CommentService;
import com.bluemobi.to.ResponseBean;

/*
 * 添加测试
 */

@Controller
@RequestMapping("app/comment/")
public class AppCommentController {
	
	private static final Logger log = LoggerFactory.getLogger(AppCommentController.class);
	
	@Autowired
	private CommentService commentService;
	
	@RequestMapping(value = "getCommentList", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public ResponseBean getCommentList(Integer userId,Integer pageIndex,Integer pageSize) {
		try {
			Map<String, Object> mapm=new HashMap<String, Object>();
			return new ResponseBean(ResponseBean.SUCCESS, "",commentService.getCommentList(mapm, pageIndex, pageSize, userId));
		} catch (Exception e) {
			return new ResponseBean(ResponseBean.FAIL, "获取信息失败！");
		}
	}

}
