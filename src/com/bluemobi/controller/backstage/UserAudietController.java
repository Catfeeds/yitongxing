package com.bluemobi.controller.backstage;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bluemobi.controller.AbstractWebController;
import com.bluemobi.controller.backstage.utils.Pagination;
import com.bluemobi.po.UserAudit;
import com.bluemobi.service.UserAuditService;
import com.bluemobi.service.UserService;
import com.bluemobi.to.ResponseBean;

/**
 * @author   xiaojin_wu
 * @datetime 2017年7月21日
 * @description
 * 			 后台译员审核功能	
 */
@Controller
@RequestMapping("/backstage/userAudit")
public class UserAudietController extends AbstractWebController {

	/**
	 * user服务
	 */
	@Autowired
	private UserService userservice;
	
	/**
	 * 译员审核服务
	 */
	@Autowired
	private UserAuditService userAuditService;
	
	/**
	 * 后台审核列表
	 */
	@RequestMapping(value = "/audit")
	public String audietList(HttpServletRequest request) {
		LOGGER.info("进入后台译员审核列表");
		String offset = request.getParameter("offset"); 
		String row = request.getParameter("row");
		Map<String, Object> map = new HashMap<>();
		LOGGER.info("页码---------"+offset+","+row);
		//默认首页
		if(com.alibaba.dubbo.common.utils.StringUtils.isBlank(offset)){
			offset = "0";
		}
		//默认首页15条数据
		if(com.alibaba.dubbo.common.utils.StringUtils.isBlank(row)){
			row = "15";
		}
		map.put("offset", Integer.valueOf(offset));
		map.put("rows", Integer.valueOf(row));
		List<Map<String, Object>> list = userAuditService.getList(map);
		int count = userAuditService.getAuditCount();//总条数
		request.setAttribute("list", list);
		request.setAttribute("paginationHtml", Pagination.getIstance().getPaginationHtml(request.getContextPath()+"/backstage/userAudit/audit", offset, row, count+""));
		return "/userAudit/auditList";
	}
	
	
	/**
	 * 后台审核页面
	 */
	@RequestMapping(value = "/auditExamine")
	public String audietExamine(HttpServletRequest request) {
		LOGGER.info("开始进行后台用户审核");
		String auditid = request.getParameter("auditid");
		UserAudit userAudit = null;
		List<String> imgUrls = new ArrayList<>();
 		if(com.alibaba.dubbo.common.utils.StringUtils.isNotEmpty(auditid)){
		    userAudit = userAuditService.getUserAuditById(Integer.valueOf(auditid));
		    if(null != userAudit){
		    	//拼接译员审核图片
		    	String urls = userAudit.getIdentificationPhoto();
		    	String[] arr = urls.split(",");
		    	for(int i = 0; i < arr.length; i++){
		    		imgUrls.add(arr[i]);
		    	}
		    }
		}
		request.setAttribute("userAudit", userAudit);
		request.setAttribute("imgUrls", imgUrls);
		return "/userAudit/auditExamine";
	}
	
	/**
	 * 后台审核
	 */
	@RequestMapping(value = "/updateAudit")
	@ResponseBody
	public ResponseBean updateAudit(HttpServletRequest request) {
		ResponseBean responseBean = null;
		Map<String,Object> map = new HashMap<>();
		Map<String,Object> user_map = new HashMap<>();
		String auditid = request.getParameter("auditid");
		String auditstate = request.getParameter("auditstate");//0未填资料，1审核中，2审核不通过，3审核通过，4申请更新资料，5更新资料审核不通过
		String userid = request.getParameter("userid");
		if(com.alibaba.dubbo.common.utils.StringUtils.isNotEmpty(auditid) && com.alibaba.dubbo.common.utils.StringUtils.isNotEmpty(auditstate)){
			//修改译员审核状态
			map.put("auditid", auditid);
			map.put("auditstate", auditstate);
			userAuditService.auditExamine(map);
			//审核通过
			if("3".equals(auditstate)){
				//在e_user表内将user状态从用户改为译员
				user_map.put("userid", userid);
				userAuditService.userToAudiet(user_map);
			}
			responseBean = new ResponseBean(ResponseBean.SUCCESS,"审核成功");
		}else{
			responseBean = new ResponseBean(ResponseBean.FAIL,"审核失败,参数不全");
		}
		return responseBean;
	}
}
